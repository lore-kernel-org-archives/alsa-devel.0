From: Bruce Paterson <bruce@tele-ip.com>
Subject: Plea to help save me from Windows !!!
Date: Thu, 21 Nov 2002 11:57:42 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DDC2F86.70102@tele-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have a simple alsa application I have developed that isn't behaving 
quite properly. I mentioned this before, but I have since upgraded to
alsa 0.9.0rc5. Similar problem !

Please let me know if I'm sending thist to the wrong place and where it 
should go instead.

There are mutterings about the place about reverting to a Windows 
development (but frankly it was far worse in other ways). Please help 
save me !  I have run out of ideas how to proceed (gdb is not going to 
help with a random problem like this).

My setup:
alsa 0.9.0rc5
mandrake 8.1
no realtime extensions (no xruns so not required)
ice1712 module with EWS88 sound card
direct hw:0,0 interface (no plugin)
output on 2 channels, input on 4 direct to/from memory
sample rate 96k, buffer size maximum EWS88, period size = buffersize/8
32 bits
interleaved to non-interleaved done by my code since plug-in didn't 
behave originally (this may be historical now).

Behaviour:
The output sound is perfect for about 2 minutes. After that every now 
and then I get "distortion" in the audio. No xruns or errors are 
reported in the software. It sounds like only part of the output buffer 
is correct (the general gist is right, but there's crap and warbles 
there as well).

It makes no difference whether I stop the soundcard and restart or 
whether I keep the soundcard going continueously (feed it 0's whilst
I'm restarting my user buffers), the distortion always starts 
happeneing. Even restarting the application makes no difference which 
leads me to suspect some ememory in the alsa driver.

Waiting about 1 minute before starting again fixes the problem for the 
~2 minutes again.

Playing back to back WAV files with aplay doesn't result in the 
distortion (it is something unique to my application...therefore I'm 
using the API incorrectly somehow !)




Here is the main loop of my code:

/* Get one full width buffer, buffersize is in frames. */
outbuf = (char *)calloc(out_buffer_size * OUTCH, 
snd_pcm_format_width(format) / 8);

/* calloc since we want silence initially on output */
inbuf = (char *)calloc(in_buffer_size * INCH, 
snd_pcm_format_width(format) / 8);

/* Start the ball rolling */
snd_pcm_prepare(outhand);
snd_pcm_prepare(inhand);
snd_pcm_reset(outhand);
snd_pcm_reset(inhand);
snd_pcm_start(inhand);

/* This is the IO loop */
outp = soundoutput;
outl = lengthofoutput;		/* output length */
samps = lengthofrecord;         /* > than length of output*/
ocopy = 0;
/* inptrs already point to fmptrs */
for(;;)
{
   if(outl)
   {	
     if( ocopy == 0 )
     {
       ocopy = 1;
       /* Copy from single channel full buffer to full width one */
       sampl = (long *)outp;
       sampm = (long *)outbuf;
       for(x=0; x < out_buffer_size; x++)
       {
         *sampm++ = *sampl;
         *sampm = -*sampl++;	
         /* Inverse for bridge drive */
         sampm += OUTCH-1;
         /* Skip over other output channels*/
         if( x > outl )
           break;
       }
       out = outl;
     }
   }
   else
     out = out_buffer_size;	/* Silence after chirp */
		
   /* See if ready for output data yet */
   poll(outfds, ocount, -1);
   snd_pcm_poll_descriptors_revents(outhand, outfds, ocount, &revents);
   if (revents & POLLERR)
   {
     fprintf(stderr, "Tx Poll failed\n");  <---- this never occurs !!
     err = -1;
     break;
   }

   if (revents & POLLOUT)
   {
     err = snd_pcm_writei(outhand, (void *)outbuf, out > out_buffer_size 
? out_buffer_size  : out );

     if( err < 0 )   <---- this never occurs !!
     {
       /* EAGAIN Shouldn't happen now since we're polling first */
       if( err != -EAGAIN )
       {
         fprintf(stderr, "Write failed at %ld: %s\n", 
lengthofoutput-outl, snd_strerror(err));
         break;
       }
     }
     else
     {
       if(outl)
       {
         outl -= err;
         outp += err * snd_pcm_format_width(format)/8;
         ocopy = 0;
         if( outl == 0 )
         {
           /* Finished output. Now fill buffer with silence again */
           sampm = (long *)outbuf;
           for(x=0; x < out_buffer_size; x++)
           {
             *sampm++ = 0;
             *sampm = 0;
             sampm += OUTCH-1;	 /* Skip over other output channels */
           }
         }
       }
     }
   }	

   /* See if data ready to be read yet... we started sampling earlier. */
   poll(infds, icount, -1);
   snd_pcm_poll_descriptors_revents(inhand, infds, icount, &revents);
   if (revents & POLLERR)
   {
     fprintf(stderr, "Rx Poll failed\n"); <---- this never occurs !!
     err = -1;
     break;
   }
   if( !((revents & POLLIN) || (revents & POLLPRI)) )
     continue;

   /* Finally actually record some real stuff */
   err = snd_pcm_readi(inhand, inbuf, samps > in_buffer_size ? 
in_buffer_size : samps);

   if(err < 0)
   {
     if( err != -EAGAIN )
     {
       /* No point in underrun recovery in this application so abort */
       fprintf(stderr,"Read error at %ld: %s\n", N-samps, 
snd_strerror(err));
       break;
     }
   }
   else
   {
     samps -= err;
     /* Copy from full width buffer to channels */
     for(y=0; y < channels; y++)
     {
       sampl = (long *)inbuf + y;
       sampm = (long *)inptrs[y];
       for(x=0; x < err; x++)
       {
         *sampm++ = *sampl;
         sampl += INCH;
       }
       inptrs[y] += err * snd_pcm_format_width(format)/8;
     }
     if( samps <= 0 )
       break;
   }
}
fprintf(stderr,"Sampling Completed\n");
snd_pcm_unlink(outhand);
snd_pcm_drop(outhand);
snd_pcm_drop(inhand);
snd_pcm_hw_free(outhand);
snd_pcm_close(outhand);
snd_pcm_hw_free(inhand);
snd_pcm_close(inhand);

/* Free up temporary memory */
free(inbuf); free(outbuf);

-- 
Cheers,
Bruce
-------------------------------------------------------------------
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager.

     /\\\/\\\/\\\    /   /      Bruce Paterson
    /  \\\ \\\ \\\  /   /    Senior Design Engineer
   /   /\\\/\\\/\\\/   /   87 Peters Ave, Mulgrave, Vic, 3170
  /   /  \\\ \\\ \\\  /  PO Box 4112, Mulgrave, Vic, 3170, Australia
/   /    \\\/\\\ \\\/   Ph: +61 3 8561 4232   Fax: +61 3 9560 9055
       Tele-IP Ltd.      Email: bruce@tele-ip.com    Icq: #32015991
                         WWW:   http://www.tele-ip.com       VK3TJN
-------------------------------------------------------------------




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
