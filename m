From: stan <stanl@cox.net>
Subject: Re: hardware not asking for more data using asyn call
	back
Date: Tue, 29 May 2007 20:39:05 -0700
Message-ID: <20070529203905.2fde64ad@ip72-208-99-199.ph.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao103.cox.net (fed1rmmtao103.cox.net [68.230.241.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 453B724427
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 05:39:08 +0200 (CEST)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao103.cox.net
	(InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP id
	<20070530033907.SJBV19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 23:39:07 -0400
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

Somehow I replied to the wrong message and it went to a personal email
address. Putting it on the list so searches can find it  (for what that
is worth :-) )

Begin forwarded message:

Date: Tue, 29 May 2007 18:18:22 -0700
From: stan <stanl@cox.net>
To: "Ashlesha Shintre" <ashlesha.shintre@gmail.com>
Subject: Re: hardware not asking for more data using asyn call back


On Tue, 29 May 2007 15:19:12 -0400
"Ashlesha Shintre" <ashlesha.shintre@gmail.com> wrote:

<snip>

I didn't understand what you were asking before.  It sounds to me like
you want to have a thread running that accepts input from arbitrary
processes and puts it in the main buffer.  Then when the alsa callback
occurs you want to take any new sound samples and send them to alsa.
If that is the case, it makes more sense for the main buffer to be
the circular buffer and the alsa buffer to be just a regular buffer.
That's just personal preference though.

As far as the handle error, I don't know what it means beyond what it
says.  You would have to look in the sources for the alsa library to
see what causes that error to be generated.  

I don't see anything wrong in the logic of the code below, but the
output indicates that you are not keeping up with the play rate.  This
is astonishing.  At each play you can see that the available room in
the buffer grows larger until larger than 1000, the buffer you have
allocated.  I'm not sure what infinite loop means and how your program
is recovering from it.  I presume that is where the time is being eaten
up that isn't allowing you to keep up with the requests for data.

I don't think you need to check if there is room when you get a
callback.  You should be able to just write the data to alsa using the
writei call.  i.e. eliminate the snd_pcm_avail_update call.

I'm not familiar enough with alsa to help you further.  Perhaps someone
else can give you a hint or point you to the right place to look.

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
> > //mpos is the position in the master buffer to write from
> > short int *buffer, *mbuf, *mpos;
> > int ind=10, fd1, length;
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
> >     int i,j,n,count,a,err,k=0;
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
> >     mbuf = (short int *) malloc (length * sizeof(short int));
> >     mpos = &mbuf[0];
> >
> >     buflen = 4*SIZE;
> >     buffer = (short int *) malloc (buflen*sizeof(short int));
> >
> >     wto = NULL;
> >     rfrom = &buffer[0];
> >
> >     /* reading to master buffer */
> >     count=0;
> >     a=1;
> >     while(count<length && a>0)
> >         a=read(fd1,&mbuf[count++],sizeof(short int));
> >     if(a<0){
> >         printf("error in reading from wav file\n");
> >         exit(1);
> >         }
> >     close (fd1);
> >
> >     for(count =0; count < buflen; count++)
> >     {
> >         buffer[count]=mbuf[count];
> >     }
> >     /******************************/
> >
> >     /*ALSA DEV INIT*/
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
> >     /*****************************/
> >
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
> >
> >         printf("distance between ptrs before reinit is %d\n",rfrom
> > - wto); if(rfrom < &buffer[buflen-1])
> >             {
> >                 wto = rfrom;
> >                 rfrom = rfrom + SIZE;
> >             }
> >         if(rfrom >= &buffer[buflen-1])
> >             {
> >                 printf("rfm at the end, rfrom -buffer[buflen-1]
> > =%d\n",(*rfrom - buffer[buflen-1]));
> >                 //wto = rfrom;
> >                 rfrom = &buffer[0];
> >             }
> >
> >         if((a = writetobuf())<0)
> >                 printf("error in reading from wav file k = %d\n");
> >
> >         printf("buffer[i*SIZE] - rfrom = %d\n",(buffer[(i+1)*SIZE] -
> > *rfrom));
> >
> >     }
> >
> >     /* Async Handler */
> >
> >
> >     err =
> > snd_async_add_pcm_handler(&pcm_callback,handle,MyCallback,NULL);
> > if(err<0) printf("add pcm handler error =
> > %d\n%s\n",err,snd_strerror(err));
> >
> >     err = snd_pcm_start(handle);
> >     if(err<0)
> >         printf("error in starting snd pcm start err
> > :%s\n",snd_strerror(err));
> >    /******************************/
> >
> >    while (1) {
> >
> >                  if(wto == NULL)
> >                     break;      // redundancy -- already checking
> > for this condition in MyCallback
> >                  printf("infinite loop\n");
> >                  sleep(1);
> >          }
> >
> >     err = snd_pcm_close(handle);
> >     if(err<0)
> >         printf("error in closing pcm device:
> > %s\n",snd_strerror(err));
> >
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
> >
> >     if((avail=snd_pcm_avail_update(pcm_handle)) >= period_size)
                             ^  
>From the alsa lib api docs.  |  
                             |  
Using of this function is useless for the standard read/write
operations. Use it only for mmap access. See to snd_pcm_delay.

Obtain delay for a running PCM handle.

Parameters:
    	pcm 	PCM handle
    	delayp 	Returned delay in frames

Returns:
    0 on success otherwise a negative error code

Delay is distance between current application frame position and sound
frame position. It's positive and less than buffer size in normal
situation, negative on playback underrun and greater than buffer size
on capture overrun.

> >         {
> >             printf("available frames = %d\n",avail);
> >             frames = snd_pcm_writei(pcm_handle, rfrom, SIZE);
Using rfrom is going to be problematic if you get to a 

> >             if(frames < 0)              // underrun
> >             {
> >                 printf("underrun recovery\n");
> >                 frames = snd_pcm_prepare(pcm_handle);
> >                 printf("error from snd_pcm_prepare is:
> > %d\n",frames); if(frames < 0){
> >                     printf("error in recovery\n");
> >
> >                     }
> >             }
> >
> >             if(frames >0 && frames < SIZE)
> >                 printf("expected to write %d, wrote
> > %d\n",SIZE,frames);
> >
> >
> >             if(rfrom < &buffer[buflen-1])
> >                 {
> >                     wto = rfrom;
> >                     rfrom = rfrom + SIZE;
> >                 }
> >             if(rfrom >= &buffer[buflen-1])
> >                 {
> > //                    wto = rfrom;
> >                     rfrom = &buffer[0];
> >                 }                 //location of where to start
> > writing from next
> >
> >             if(writetobuf()<0){
> >                 wto=NULL;
> >                 exit(0); // returns 0 to the operating system -- so
> > it ends the program!
> >                 }
> >             ++ind;
> >         }
> >
> >         printf("going out of callback, ind = %d\n",ind);
> > }
> >
> > /*Function to copy data from master buffer (mbuf) to circular buffer
> > (buffer)*/
> > int writetobuf()
> > {
> >     int count=-1;
> >
> >     while((++count < SIZE) && (mpos < &mbuf[length]))
> >         *(mpos++) = *(wto+count);
> >
> >     if(mpos >= &mbuf[length-1])
> >         return -1;
> >     else
> >         return 0;
> > }
> >

i=49
error in starting snd pcm start err :File descriptor in bad state
infinite loop
inside callback, available frames = 364
going out of callback, ind = 1
infinite loop
inside callback, available frames = 577
going out of callback, ind = 2
infinite loop
inside callback, available frames = 790
underrun recovery
error from snd_pcm_prepare is: 0
going out of callback, ind = 3
infinite loop
infinite loop
infinite loop
