From: Bruce Paterson <bruce@tele-ip.com>
Subject: Re: Help !  Distorted sound on re-run
Date: Thu, 31 Oct 2002 16:47:13 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC0C3E1.B49F4EEE@tele-ip.com>
References: <3DB8D214.674FEFB6@tele-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Bruce Paterson wrote:
> 

I got zero feedback on the problem below, so I thought I'd add the code
segment and see
if anyone can tell me what I'm doing wrong !
See code below.

> HELP !
> I've tried everything I can think of and I'm at a loss.
> 
> Setup:
> alsa 0.9.0rc2
> soundcard Terratec EWS88 (ice1712 driver)
> direct hw:0,0 using snd_pcm_readi & writei with descriptor polling.
> length approx 50s similtaneous read & write. read from all channels.
> modified 'envy24setup' to preset hardware levels on startup
> full restart of sound system each 'pass' (new handles etc.)
> 
> Problem:
> The first pass works fine with beautiful audio.
> The next pass the output is badly distorted (sounds like an incomplete
> buffer or something), but
> no errors reported, no under/overruns.... only evidence that something
> is wrong is to listen to it.
> 
> What fixes it:
> Waiting. Yup...if I wait > 1 minute before the 2nd pass then that is
> also fine. Something 'happens'
> in that time to make it all ok again.
> This is why it's taken me ages to actually notice the problem at all !
> (program has been running
> for months).
> 
> What *doesn't* help:
> Not doing a full sound restart between passes (ie. merely doing a drop
> afterwards, then restart with
> prepare & start, leaving pcm handles alive).
> Playing a wav file with 'aplay' in between passes.
> Exiting from my program and starting again between passes.
> adding hw_free commands prior to close of the in & out handles.

Recent observations: The distortion (buffer problem ?) seems to occur a
fixed interval after
the sound is started after a good delay then stopped, then started
again. ie. If I send shorter bursts
I can get two good ones in beofre a bad one (quite consistantly),
whereas only 1 good longer burst.

Also, if I send a really really long burst (ie continueous) the problem
never occurs. It's only if I stop
then start again !

Here is the code segment in question. The periodsize is setup to be 1/4
of the buffersize which is set
to the maximum the soundcard will give me. When restarting the soundcard
is initialised from scratch
(new fd's), but I tried without doing this and it makes no difference):

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
	outp = a buffer that contains what I want to output;
	outl = length of said buffer;			
	outs = (QUIET * (Fs/1000));	/* Pre-silence output time */
	Delay *= Fs;			/* Change to sample count */
	Delay += QUIET * (Fs/1000);	/* Always delay the output quiet period as
well */
	dc = Delay;
	samps = N; 
	ocopy = 0;
	/* inptrs already point to fmptrs */
	for(;;)
	{
		if(outs)
			out = outs;
		else
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
						/* only 2 channels output (180 deg out of phase) */
						*sampm = *sampl++;
						sampm += OUTCH;		 /* Skip over other output channels */
						if( x > outl )
							break;
					}
					out = outl;
				}
			}
			else
				out = out_buffer_size;		/* Silence after */
		}

		/* See if ready for output data yet */
        	poll(outfds, ocount, -1);
        	snd_pcm_poll_descriptors_revents(outhand, outfds, ocount,
&revents);
        	if (revents & POLLERR)
		{
			fprintf(stderr, "Tx Poll failed\n");
			err = -1;
			break;
		}
        	if (revents & POLLOUT)
		{
			err = snd_pcm_writei(outhand, (void *)outbuf, out > out_buffer_size ?
out_buffer_size  : out );
			if( err < 0 )
			{
				/* EAGAIN Shouldn't happen now since we're polling first */
				if( err != -EAGAIN )
				{
					fprintf(stderr, "Write failed %s", snd_strerror(err));
					break;
				}
			}
			else
			{
				if(outs)
					outs -= err;
				else
				{
					if(outl)
					{
						outl -= err;
						outp += err * snd_pcm_format_width(format)/8;
						ocopy = 0;
						if( outl == 0 )
						{
							/* Finished actual output. Now fill buffer with silence again */
							sampm = (long *)outbuf;
							for(x=0; x < out_buffer_size; x++)
							{
								*sampm++ = 0;
								*sampm = 0;
								sampm += OUTCH-1; /* Skip over other output channels */
							}
						}
					}
				}
			}	
		}

		/* See if data ready to be read yet... we started sampling earlier. */
        	poll(infds, icount, -1);
        	snd_pcm_poll_descriptors_revents(inhand, infds, icount,
&revents);
        	if (revents & POLLERR)
		{
			fprintf(stderr, "Rx Poll failed\n");
			err = -1;
			break;
		}
        	if( !((revents & POLLIN) || (revents & POLLPRI)) )
			continue;

		if(dc)
		{
	  		err = snd_pcm_readi(inhand, inbuf, dc > in_buffer_size ?
in_buffer_size : dc);
	  		if(err < 0)
			{
				if( err != -EAGAIN )
				{
					fprintf(stderr,"Read error at %ld: %s\n", Delay-dc,
snd_strerror(err));
					break;
				}
			}
			else
			{
				dc -= err;
				if( dc )
					continue;
			}
		}

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
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
