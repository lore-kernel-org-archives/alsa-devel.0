From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA driver 1.0.2c: divide by zero oops
Date: Thu, 18 Mar 2004 09:00:20 +1030 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403172230.i2HMUKu09754@sprite.physics.adelaide.edu.au>
References: <s5hwu5lf52a.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwu5lf52a.wl@alsa2.suse.de> from "Takashi Iwai" at Mar 16, 2004 11:40:29 AM
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

Takashi

> > > > I have been trying cinelerra 1.1.9 in OSS mode against the OSS emulation
> > > > driver (snd-pcm-oss) from ALSA driver 1.0.2c. Whenever anything is done to
> > > > start audio playback (such as playing a video clip) the ALSA driver panics
> > > > with a divide by zero error.  The decoded oops is found below.
> > > > 
> > > > Under native OSS from 2.4.23 cinelerra works fine.  Furthermore, all other
> > > > OSS applications I've tried against ALSA driver 1.0.2c seem to be fine. 
> > > > Thus the problem seems to be associated with the way cinelerra does things -
> > > > something it does is upsetting ALSA but is fine under native OSS.  Of
> > > > course, even a misbehaving application not running as root should not be
> > > > able to panic the kernel.
> > > 
> > > sure.  what soundcard/soundchip are you using?
> > 
> > It's an Ensoniq AudioPCI card with the ES-1370 chipset.
> :
> please turn on the debug option.  it will help to catch the bug there,
> at least we can know whether it's really zero division.

I did this last night.  The following is my analysis of the problem.

With full debug selected, the only message reported by the ALSA system is
  ALSA ../alsa-kernel/core/pcm_timer.c:70: BUG? (rate != 0) 
  (called from d8c33a79)
That is, the assertion "rate!=0" fails.  This confirms the reported oops
trigger (that is, divide by zero).

Address d8c33a79 appears to be in snd_pcm_hw_params().  The call to 
snd_pcm_timer_resolution_change() appears at pcm_native.c:396.

In debug mode the divide isn't done when rate==0: the action in response to
the failed assertion is to return before attempting the divide.  When using
the debug mode ALSA driver cinelerra appears to function without any
immediately apparent problems (except of course the above debug message is
sent to the logs).

The earliest ALSA call in the previously reported oops backtrace appears to
be snd_pcm_oss_set_format(), which is called via the SNDCTL_DSP_SETFMT
ioctl.

cinelerra calls SNDCTL_DSP_SETFMT in a number of places in audiooss.C:
* AudioOSS::open_input():
    if(ioctl(dsp_in[i], SNDCTL_DSP_SETFRAGMENT, &buffer_info))
      printf("SNDCTL_DSP_SETFRAGMENT failed.\n");
    if(ioctl(dsp_in[i], SNDCTL_DSP_SETFMT, &format) < 0)
      printf("SNDCTL_DSP_SETFMT failed\n");
    if(ioctl(dsp_in[i], SNDCTL_DSP_CHANNELS,&device->in_config->oss_in_channels[i]) < 0) 
      printf("SNDCTL_DSP_CHANNELS failed\n");
    if(ioctl(dsp_in[i], SNDCTL_DSP_SPEED,&device->in_samplerate) < 0) 
      printf("SNDCTL_DSP_SPEED failed\n");
* AudioOSS::open_output():
    dsp_out[i] = open(device->out_config->oss_out_device[i],
                 O_WRONLY /*| O_NDELAY*/);
    set_cloexec_flag(dsp_out[i], 1);
    if(ioctl(dsp_out[i], SNDCTL_DSP_SETFRAGMENT, &buffer_info))
      printf("SNDCTL_DSP_SETFRAGMENT 2 failed.\n");
    if(ioctl(dsp_out[i], SNDCTL_DSP_SETFMT, &format) < 0) 
      printf("SNDCTL_DSP_SETFMT 2 failed\n");
    if(ioctl(dsp_out[i], SNDCTL_DSP_CHANNELS, &device->out_config->oss_out_channels[i]) < 0) 
      printf("SNDCTL_DSP_CHANNELS 2 failed\n");
    if(ioctl(dsp_out[i], SNDCTL_DSP_SPEED,&device->out_samplerate) < 0) 
      printf("SNDCTL_DSP_SPEED 2 failed\n");
    ioctl(dsp_out[i], SNDCTL_DSP_GETOSPACE, &playinfo);
* AudioOSS::open_duplex():
    As for AudioOSS::open_output() with
      if(ioctl(dsp_duplex[i], SNDCTL_DSP_SETDUPLEX, 1) == -1)
        printf("SNDCTL_DSP_SETDUPLEX failed\n");
    added after SNDCTL_DSP_SETFRAGMENT call.

In the case of the oops AudioOSS::open_output() was the function being used.
The SNDCTL_DSP_SETFMT call triggering the oops is preceeded with a call to
SNDCTL_DSP_SETFRAGMENT.  Commenting out the SNDCTL_DSP_SETFRAGMENT call
makes the "rate!=0" assertion pass - in other words, it appears that rate
becomes zero as a consequence of calling SNDCTL_DSP_SETFRAGMENT.  Thus the
problem would appear to be the SNDCTL_DSP_SETFRAGMENT preceeding
SNDCTL_DSP_SETFMT call.  Since cinelerra's call sequence for setting up OSS
devices (as shown above) agrees with the published API it therefore appears
that there is a glitch in the ALSA emulation system.

The other OSS apps I've used do not call SNDCTL_DSP_SETFRAGMENT which
probably explains why I've had no problem with other OSS applications.

I hope this helps track down the problem.  I am happy to run more tests if
needed.

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
