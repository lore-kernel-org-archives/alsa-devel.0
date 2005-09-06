From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda-intel/ALC260: crackly playback and DC offset on recording
Date: Tue, 6 Sep 2005 09:37:20 +0930 (CST)
Message-ID: <200509060007.j8607KRW006657@auster.physics.adelaide.edu.au>
References: <s5h3boju7cv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3boju7cv.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 05, 2005 12:38:56 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi

> > Further tests with the hda-intel driver with the ALC260 chip in my laptop
> > has shown that when audio is played, seemingly random crackling occurs
> > in the output.  This affects only playback - recorded audio is fine.  It
> > affected aplay (native alsa), wavplay (uses /dev/dsp and thus alsa's OSS
> > snd-pcm-oss module) and audacity 1.2.2 (also using /dev/dsp).
> > 
> > I found that the following change to hda_intel.c almost fixed the problem:
> > 
> > --- hda_intel.c 2005-09-03 23:02:18.000000000 +0930
> > +++ hda_intel.c-orig    2005-08-16 05:23:07.000000000 +0930
> > @@ -1026,7 +1026,7 @@
> >  	azx_setup_periods(azx_dev);
> >  	azx_setup_controller(chip, azx_dev);
> >  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > -		azx_dev->fifo_size = azx_sd_readw(azx_dev, SD_FIFOSIZE);
> > +		azx_dev->fifo_size = azx_sd_readw(azx_dev, SD_FIFOSIZE) + 1;
> >  	else
> >  		azx_dev->fifo_size = 0;
> 
> This is already in 1.0.10rc1.  Or do you mean to revert this?

Oops, it looks like I did the diff around the wrong way by accident - sorry
for the confusion.  What I mean is that the "+1" should be removed.  If the
"+1" was added in 1.0.10rc1 then I guess that means that it should be
reverted.  As mentioned below though, without the "+1" aplay output is clean
but not everything is fixed, so this might not be the root cause of the
problem.

> > If this patch was applied then playing audio using aplay was clean - no hint
> > of the crackling was evident.  However, playing through audacity (which used
> > the ALSA OSS emulation) was still crackly.  I then tested using wavplay (which
> > also uses the OSS devices) and it too was still crackly.  I recompiled
> > audacity to use portaudio v19 (thus giving audacity native ALSA support) and
> > was slightly surprised to hear that the crackling remained with audacity even
> > when using the ALSA output options.  Throughout all this, the aplay output
> > was clean so long as the above patch had been applied.
> Does position_fix=1 module option help?

I will try this and advise of the outcome.

> > On the subject of recording, there seems to be a DC offset in the ADC which
> > is dependent on the level of the "capture" mixer control - the higher the
> > control the higher the DC offset.  The offset is present even when nothing
> > is plugged in to the laptop.  With the control at maximum the DC offset
> > is as much as 10% FSD; at mimimum it's around 1-2%.
> > 
> > Any ideas on either of these?
> 
> I guess it's in the codec side, not the controller side.
> There might be missing initialization for ALC260...

I thought of that, but there doesn't appear to be anything in the ALC260
datasheet related to a DC offset.  There is talk about the option of setting
the Vref on these pins (50% or 80% of digital supply) but doing either
doesn't alter the DC offset in the sampled datastream compared to the "no
Vref" case which is what I'm currently using.  Perhaps it's related to the
chip's impedence detection logic - I'll have a look at that area tonight.

Regards
  jonathan


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
