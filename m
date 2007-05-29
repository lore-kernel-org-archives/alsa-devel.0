From: "Ashlesha Shintre" <ashlesha.shintre@gmail.com>
Subject: Re: hardware not asking for more data using asyn call
	back
Date: Tue, 29 May 2007 15:19:12 -0400
Message-ID: <975f530d0705291219h3a8601c3hba494ba2e1ac1a7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by alsa0.perex.cz (Postfix) with ESMTP id C50C5243D1
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 21:19:13 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id r21so1672451wxc
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 12:19:12 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stanl@cox.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks Stan, for your response - Instead of copying pcm data from a wav
file, i decided to copy all the data to a master buffer first and then see
if the circular buffer implementation works -

so now instead of copying from the wave file, i m copying data from the
master buffer to the circular buffer.. however, as per your suggestion, if i
copy the data in the while loop in main, then, it might not always be copied
between 2 consecutive callbacks, but maybe more, as the callbacks are
asynchronous.

however, the hardware still does not ask for more data after executing the
callback function about twice -- is there a way to flush the hardware buffer
before beginning playback? I have pasted my code below

Regards,
Ashlesha.

/* Reading wav file into a buffer and then trying to play it */
>
> #include <stdio.h>
> #include </usr/include/alsa/asoundlib.h>
> #include </usr/include/alsa/pcm.h>
> #include <sys/types.h>
> #include <unistd.h>
> #include <fcntl.h>
>
> #define SIZE 128
> //mpos is the position in the master buffer to write from
> short int *buffer, *mbuf, *mpos;
> int ind=10, fd1, length;
> static snd_pcm_t *handle;
> static char *device = "default";                        /* playback device
> */
> snd_output_t *output = NULL;
> static short int *wto, *rfrom, buflen;
>
> void MyCallback(snd_async_handler_t *pcm_callback);
>
> int main()
> {
>     int i,j,n,count,a,err,k=0;
>     char c;
>     snd_pcm_sframes_t frames;
>     snd_async_handler_t *pcm_callback;
>
>
>
>     if((fd1=open("SA2.WAV",O_RDONLY,0))==-1)
>         printf("error opening wav file\n");
>
>     count=0;
>     while(count++<40)
>         a=read(fd1,&c,sizeof(char));
>
>     a=read(fd1,&length,sizeof(int));
>
>     n=length/SIZE;
>
>     printf("length = %d\n",length);
>     mbuf = (short int *) malloc (length * sizeof(short int));
>     mpos = &mbuf[0];
>
>     buflen = 4*SIZE;
>     buffer = (short int *) malloc (buflen*sizeof(short int));
>
>     wto = NULL;
>     rfrom = &buffer[0];
>
>     /* reading to master buffer */
>     count=0;
>     a=1;
>     while(count<length && a>0)
>         a=read(fd1,&mbuf[count++],sizeof(short int));
>     if(a<0){
>         printf("error in reading from wav file\n");
>         exit(1);
>         }
>     close (fd1);
>
>     for(count =0; count < buflen; count++)
>     {
>         buffer[count]=mbuf[count];
>     }
>     /******************************/
>
>     /*ALSA DEV INIT*/
>     if((err = snd_pcm_open(&handle, device, SND_PCM_STREAM_PLAYBACK, 0)) <
> 0) {
>         printf("error opening device: %s\n",snd_strerror(err));
>         return -1;
>     }
>
>     if((err = snd_pcm_set_params(handle,
>                                 SND_PCM_FORMAT_S16_LE,
>                                 SND_PCM_ACCESS_RW_INTERLEAVED,
>                                 1,
>                                 16000,
>                                 1,
>                                 1000)) < 0) {   /* 2 sec */
>             printf("Playback open error: %s\n", snd_strerror(err));
>             return -2;
>     }
>     /*****************************/
>
>     printf("n=%d\n",n);
>     for (i=0; i<50; i++)
>     {
>         printf("i=%d\n",i);
>         frames = snd_pcm_writei(handle, rfrom, SIZE);
>         if(frames < 0)              // underrun
>             {
>                 printf("underrun recovery\n");
>                 frames = snd_pcm_recover(handle, frames,0);
>                 if(frames < 0){
>                     printf("error in recovery\n");
>                     return -3;
>                     }
>             }
>         if(frames >0 && frames < SIZE)
>             printf("expected to write %d, wrote %d\n",SIZE,frames);
>
>         printf("distance between ptrs before reinit is %d\n",rfrom - wto);
>         if(rfrom < &buffer[buflen-1])
>             {
>                 wto = rfrom;
>                 rfrom = rfrom + SIZE;
>             }
>         if(rfrom >= &buffer[buflen-1])
>             {
>                 printf("rfm at the end, rfrom -buffer[buflen-1]
> =%d\n",(*rfrom - buffer[buflen-1]));
>                 //wto = rfrom;
>                 rfrom = &buffer[0];
>             }
>
>         if((a = writetobuf())<0)
>                 printf("error in reading from wav file k = %d\n");
>
>         printf("buffer[i*SIZE] - rfrom = %d\n",(buffer[(i+1)*SIZE] -
> *rfrom));
>
>     }
>
>     /* Async Handler */
>
>
>     err = snd_async_add_pcm_handler(&pcm_callback,handle,MyCallback,NULL);
>     if(err<0)
>         printf("add pcm handler error = %d\n%s\n",err,snd_strerror(err));
>
>     err = snd_pcm_start(handle);
>     if(err<0)
>         printf("error in starting snd pcm start err
> :%s\n",snd_strerror(err));
>    /******************************/
>
>    while (1) {
>
>                  if(wto == NULL)
>                     break;      // redundancy -- already checking for this
> condition in MyCallback
>                  printf("infinite loop\n");
>                  sleep(1);
>          }
>
>     err = snd_pcm_close(handle);
>     if(err<0)
>         printf("error in closing pcm device: %s\n",snd_strerror(err));
>
>     return 0;
> }
>
> void MyCallback(snd_async_handler_t *pcm_callback)
> {
>
>     snd_pcm_t *pcm_handle = snd_async_handler_get_pcm(pcm_callback);
>     snd_pcm_sframes_t avail;
>     int count,a;
>     snd_pcm_uframes_t period_size = 64;
>     snd_pcm_sframes_t frames;
>
>     if((avail=snd_pcm_avail_update(pcm_handle)) >= period_size)
>         {
>             printf("available frames = %d\n",avail);
>             frames = snd_pcm_writei(pcm_handle, rfrom, SIZE);
>             if(frames < 0)              // underrun
>             {
>                 printf("underrun recovery\n");
>                 frames = snd_pcm_prepare(pcm_handle);
>                 printf("error from snd_pcm_prepare is: %d\n",frames);
>                 if(frames < 0){
>                     printf("error in recovery\n");
>
>                     }
>             }
>
>             if(frames >0 && frames < SIZE)
>                 printf("expected to write %d, wrote %d\n",SIZE,frames);
>
>
>             if(rfrom < &buffer[buflen-1])
>                 {
>                     wto = rfrom;
>                     rfrom = rfrom + SIZE;
>                 }
>             if(rfrom >= &buffer[buflen-1])
>                 {
> //                    wto = rfrom;
>                     rfrom = &buffer[0];
>                 }                 //location of where to start writing
> from next
>
>             if(writetobuf()<0){
>                 wto=NULL;
>                 exit(0); // returns 0 to the operating system -- so it
> ends the program!
>                 }
>             ++ind;
>         }
>
>         printf("going out of callback, ind = %d\n",ind);
> }
>
> /*Function to copy data from master buffer (mbuf) to circular buffer
> (buffer)*/
> int writetobuf()
> {
>     int count=-1;
>
>     while((++count < SIZE) && (mpos < &mbuf[length]))
>         *(mpos++) = *(wto+count);
>
>     if(mpos >= &mbuf[length-1])
>         return -1;
>     else
>         return 0;
> }
>
