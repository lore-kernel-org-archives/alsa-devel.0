From: Con Kolivas <kernel@kolivas.org>
Subject: Re: ALSA:usb audio Higher sample rates on usb audio no longer working.
Date: Fri, 4 Jan 2019 10:16:42 +1100
Message-ID: <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
References: <CABqErrECNH+gRiZXM+z=igjAw895e7KLeV6H0EKvMkW0UsVvJw@mail.gmail.com>
 <s5hsgy96fiu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hsgy96fiu.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, saranya.gopal@intel.com, felipe.balbi@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Iwai-san.

Added some relevant CCs.

On Fri, 4 Jan 2019 at 00:23, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 03 Jan 2019 12:43:54 +0100,
> Con Kolivas wrote:
> >
> > Upon switching from 4.19.0 to 4.20.0, pulseaudio started complaining
> > that sinks that previously worked are no longer supported.
> >
> > On 4.19.0 trying 24 bit 88200, 176400, and 192000 I get the following
> > output from pulse.
> > resampler.c: Forcing resampler 'copy', because of fixed, identical
> > sample rates.sink-input.c: Created input 15 "Playback Stream" on
> > alsa_output.usb-DSPeaker_Anti-Mode_X4-00.iec958-stereo with sample
> > spec float32le 2ch 176400Hz and channel map front-left,front-right
> >
> > Switching to 4.20 gives me:
> > alsa-sink.c: Sink does not support sample rate of 176400 Hz
> > and
> > alsa-sink.c: Sink does not support sample rate of 88200 Hz
> > and
> > alsa-sink.c: Sink does not support sample rate of 192000 Hz
> >
> > Sample rates of 44100, 48000, and 96000 work fine, but 88200, 176400,
> > and 192000 no longer work
> >
> > Switching back to 4.19 immediately fixes the issue.
> >
> >
> > I tried looking through the alsa changelogs but there were too many to
> > give an obvious culprit, and haven't had time to do a git bisect. If
> > there's an obvious choice patch to back out I'd be grateful for the
> > heads up.
>
> Hm, through a quick glance, there hasn't been any relevant changes in
> USB-audio part (sound/usb/*).  Also, the changes in sound/core/* are
> irrelevant with your problem.
>
> So I have no idea what went wrong.  The bisection, or at least,
> narrowing down the commits would be helpful.

I've done a git bisect and found the offending commit:

commit f13912d3f014a7f2fa5c35d25ee8c3f96bda6272 (refs/bisect/bad)
Author: Saranya Gopal <saranya.gopal@intel.com>
Date:   Wed Sep 12 08:46:26 2018 +0530

    usbcore: Select UAC3 configuration for audio if present

    USB audio class 3.0 specification introduced many significant
    changes like
     - new power domains, support for LPM/L1
     - new cluster descriptor
     - new high capability and class-specific string descriptors
     - BADD profiles
     - ... and many other things (check spec from link below:
    http://www.usb.org/developers/docs/devclass_docs/USB_Audio_v3.0.zip)

    Now that UAC3 is supported in linux, choose UAC3
    configuration for audio if the device supports it.
    Selecting this configuration will enable the system to
    save power by leveraging the new power domains and LPM L1
    capability and also support new codec types and data formats
    for consumer audio applications.

    Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
    Reviewed-by: Felipe Balbi <felipe.balbi@linux.intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reverting this patch fixes the problem for me.

Hope this helps.

Thanks,
Con
