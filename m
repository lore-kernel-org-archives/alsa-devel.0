From: stan <stanl@cox.net>
Subject: Re: hardware not asking for more data using asyn call
 back
Date: Mon, 28 May 2007 15:43:00 -0700
Message-ID: <20070528154300.69ac9c03@ip72-208-99-199.ph.ph.cox.net>
References: <975f530d0705281232j32d28964r54b9b2b33a77c085@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao102.cox.net (fed1rmmtao102.cox.net [68.230.241.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 848FC2417B
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 00:43:02 +0200 (CEST)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao102.cox.net
	(InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
	id <20070528224301.YLVL2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Mon, 28 May 2007 18:43:01 -0400
In-Reply-To: <975f530d0705281232j32d28964r54b9b2b33a77c085@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 28 May 2007 15:32:16 -0400
"Ashlesha Shintre" <ashlesha.shintre@gmail.com> wrote:

> Hi,
> 
> In my asynchronous playback program, the hardware stops asking for
> any data and the program gets stuck after one call to the callback
> function.  I have pasted the program below -- please let me know if
> something is wrong -
> 
> Thanks,
> Ashlesha.
> 
> /* Reading wav file into a buffer and then trying to play it */
> >
> > #include <stdio.h>
> > #include </usr/include/alsa/asoundlib.h>
> > #include </usr/include/alsa/pcm.h>
> > #include <sys/types.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> >
> > #define SIZE 128
> >
> > short int *buffer;
> > int ind=10, fd1;
> > static snd_pcm_t *handle;
> > static char *device = "default";                        /* playback
> > device */
> > snd_output_t *output = NULL;
> > static short int *wto, *rfrom, buflen;
> >
> > void MyCallback(snd_async_handler_t *pcm_callback);
> >
> > int main()
> > {
> >     int i,j,n,length,count,a,err,k=0;
> >     char c;
> >     snd_pcm_sframes_t frames;
> >     snd_async_handler_t *pcm_callback;
> >
> >
> >
> >     if((fd1=open("SA2.WAV",O_RDONLY,0))==-1)
> >         printf("error opening wav file\n");
> >
> >     count=0;
> >     while(count++<40)
> >         a=read(fd1,&c,sizeof(char));
> >
> >     a=read(fd1,&length,sizeof(int));
> >
> >     n=length/SIZE;
> >
> >     printf("length = %d\n",length);
> >
> >     buflen = 4*SIZE;
> >     buffer = (short int *) malloc (buflen*sizeof(short int));
> >
> >     wto = NULL;
> >     rfrom = &buffer[0];
> >
> >     count=0;
> >     a=1;
> >     while(count<buflen && a>0)
> >         a=read(fd1,&buffer[count++],sizeof(short int));
> >     if(a<0)
> >         printf("error in reading from wav file\n");
> >
> >     if((err = snd_pcm_open(&handle, device,
> > SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
> >         printf("error opening device: %s\n",snd_strerror(err));
> >         return -1;
> >     }
> >
> >     if((err = snd_pcm_set_params(handle,
> >                                 SND_PCM_FORMAT_S16_LE,
> >                                 SND_PCM_ACCESS_RW_INTERLEAVED,
> >                                 1,
> >                                 16000,
> >                                 1,
> >                                 1000)) < 0) {   /* 2 sec */
> >             printf("Playback open error: %s\n", snd_strerror(err));
> >             return -2;
> >     }
> >     printf("n=%d\n",n);
> >     for (i=0; i<50; i++)
> >     {
> >         printf("i=%d\n",i);
> >         frames = snd_pcm_writei(handle, rfrom, SIZE);
> >         if(frames < 0)              // underrun
> >             {
> >                 printf("underrun recovery\n");
> >                 frames = snd_pcm_recover(handle, frames,0);
> >                 if(frames < 0){
> >                     printf("error in recovery\n");
> >                     return -3;
> >                     }
> >             }
> >         if(frames >0 && frames < SIZE)
> >             printf("expected to write %d, wrote %d\n",SIZE,frames);
> >         printf("distance between ptrs before reinit is %d\n",rfrom
> > - wto); if(rfrom < &buffer[buflen-1])
> >             {
> >                 wto = rfrom;
> >                 rfrom = rfrom + SIZE;
> >             }
> >         else
> >             {
> >                 printf("rfm at the end, rfrom -buffer[buflen-1]
> > =%d\n",(*rfrom - buffer[buflen-1]));
> >                 wto = rfrom;
> >                 rfrom = &buffer[0];
> >             }
> >         for(k=0; k<SIZE; k++)
> >             {
> >                 a=read(fd1,(wto+k),sizeof(short int));
> >                 if(a<0)
> >                     printf("error in reading from wav file k =
> > %d\n"); }
> >         printf("buffer[i*SIZE] - rfrom = %d\n",(buffer[(i+1)*SIZE] -
> > *rfrom));
> >
> >     }
> >
> >     /* Async Handler */
> >
> >    // err =
> > snd_async_add_pcm_handler(&pcm_callback,handle,MyCallback,buffer);
> >     err =
> > snd_async_add_pcm_handler(&pcm_callback,handle,MyCallback,NULL);
> > if(err<0) printf("add pcm handler error =
> > %d\n%s\n",err,snd_strerror(err));
> >
> >     err = snd_pcm_start(handle);
> >     if(err<0)
> >         printf("error in starting snd pcm start err
> > :%s\n",snd_strerror(err));
> >
> >    while (1) {
> >                  if(wto == NULL)
> >                     break;
> >                  sleep(1);

I think you should be filling the buffer in this loop instead of in the
callback function below.

> >          }
> >
> >     err = snd_pcm_close(handle);
> >     if(err<0)
> >         printf("error in closing pcm device:
> > %s\n",snd_strerror(err)); close(fd1);
> >     return 0;
> > }
> >
> > void MyCallback(snd_async_handler_t *pcm_callback)
> > {
> >
> >     snd_pcm_t *pcm_handle = snd_async_handler_get_pcm(pcm_callback);
> >     snd_pcm_sframes_t avail;
> >     int count,a;
> >     snd_pcm_uframes_t period_size = 64;
> >     snd_pcm_sframes_t frames;
> >     //short int *bufferin =
> > snd_async_handler_get_callback_private(pcm_callback);
> >
> >     while((avail=snd_pcm_avail_update(pcm_handle)) >= period_size)
> >         {
> >             printf("available frames = %d\n",avail);
> >             frames = snd_pcm_writei(pcm_handle, rfrom, SIZE);
> >             if(frames < 0)              // underrun
> >             {
> >                 printf("underrun recovery\n");
> >                 frames = snd_pcm_prepare(pcm_handle);
> >                 printf("error from snd_pcm_prepare is:
> > %d\n",frames); if(frames < 0){
> >                     printf("error in recovery\n");
> >                    // break;
> >                     }
> >             }
> >
> >             if(frames >0 && frames < SIZE)
> >                 printf("expected to write %d, wrote
> > %d\n",SIZE,frames); count = 0;
> >             a=1;
> >             while(count<SIZE && a>0){
> >                 a=read(fd1,(wto+count),sizeof(short
> > int));      //write to the buffer from file
> >                 ++count;
> >                 }
> >             printf("count = %d\n",count);
> >             if(a <0){ //EOF
> >                     wto = NULL;
> >                     printf("end of file reached\n");
> >                     break;
> >                     }
> >             else{
> >                     if(rfrom < &buffer[buflen-1])
> >                         {
> >                             wto = wto+count;
> >                             rfrom = rfrom + SIZE;
> >                         }
> >                     else
> >                         {
> >                             wto = wto + count;
> >                             rfrom = &buffer[0];
> >                         }                 //location of where to
> > start writing from next
> >                 }
> >             ++ind;
> >         }
> >
> >         printf("going out of callback, ind = %d\n",ind);
> > }
> >
> >
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Could you post the output of all the printfs when the program runs, and
describe the behavior.  I read what you read above as saying that it
hangs.  The printf output will indicate where it is hanging.
