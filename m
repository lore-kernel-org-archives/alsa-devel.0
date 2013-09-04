From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - Re-setup HDMI pin and audio
 infoframe on stream switches
Date: Wed, 4 Sep 2013 04:53:51 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F801331195@SHSMSX101.ccr.corp.intel.com>
References: <1378202279-14990-1-git-send-email-tiwai@suse.de>
 <5225C3B3.8030108@canonical.com> <s5hvc2i9kj1.wl%tiwai@suse.de>
 <5225D7BD.1060005@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F801330FF3@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B80B62654BE
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 06:53:59 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F801330FF3@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Lin, Mengdong
> Sent: Wednesday, September 04, 2013 9:30 AM
> 
> > >> Also, this looks a bit like the workaround I added a while back
> > >> (83f26ad2c909083fa6 - ALSA: hda - fixup D3 pin and right channel
> > >> mute on Haswell HDMI audio) is there a possibility we need to fix
> > >> up D3 as well here? I e, call haswell_verify_pin_D0 rather than just setting
> the mute?
> > >> Or perhaps move the call to haswell_verify_pin_D0 from
> > >> hdmi_setup_stream to hdme_setup_audio_infoframe ?
> > >
> > > The power state is fine in this case, but just to reset the amp
> > > state by some reason.  It's not enough to update the info frame, as
> > > far as I tested.
> >
> > Ok - maybe Mengdong can comment more on this, if it's the same
> > scenario as I was working around earlier (right channel muted and pin
> > in D3), or if this is something different.
> 
> They're same in nature, although the pin power state can be affected or not.
> S3, hot-plug and Gfx mode switch can all make Gfx reconnect the port, maybe
> to the same or a different transcoder.
> During this process , audio will be disabled and re-enabled again in Gfx driver
> side.
> As a result, pin mute status, inforframe transmission, power state need to be
> re-setup.
> 
> Till now, we only observed pin in D3 after boot. But considering Gfx is
> implement runtime PM, it would be better to always check/fix pin power state.

Fix typo: We only observe pin in D3 after boot and S3, i.e. the pin (port) is used for 1st time after GPU change state to D0.
In this display mode switch case, the pin power state remains in D0, although Gfx driver disables and re-enables the port.

> Since the ELD valid unsolicited response is a signal to indicate Gfx driver has
> finished audio re-enabling, the audio driver could fix things in
> hdmi_present_sense() triggered by the HDMI intrinsic event handler.
> >
> > If it's the same issue, I was thinking that we could
> >  1) skip the extra snd_hda_codec_write here, and
> >  2) move the call to haswell_verify_pin_D0 from hdmi_setup_stream to
> > hdmi_setup_audio_infoframe?
> >
> > Also, if the pin amp is always unmuted, we could speed up
> > haswell_verify_pin_D0 to always unmute instead of read-then-write.

I've submitted a patch for this, with subject 'ALSA: hda - unmute pin amplifier in infoframe setup for Haswell'. Could you have a look?

But haswell_verify_pin_D0 is still called in hdmi_setup_stream() and only unmuting pin amp is moved to hdmi_setup_audio_infoframe().
It's because ELDV unsol event may come in codec D3, and pin should not be set to D0 in the event handler for this case. 
So the new patch still fixes pin power state when preparing the stream.

Thanks
Mengdong
