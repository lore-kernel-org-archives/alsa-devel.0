From: Stephen Warren <swarren@nvidia.com>
Subject: Re: HDMI audio: TV vs. codec supported sample rates
Date: Thu, 12 Aug 2010 14:02:45 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF98A@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF319@HQMAIL01.nvidia.com>
	<201008051357.18821.anssi.hannula@iki.fi>	<s5hmxt1gw58.wl%tiwai@suse.de>
	<201008051417.10835.anssi.hannula@iki.fi>	<s5heiedgs66.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF02FD6DF494@HQMAIL01.nvidia.com>
	<s5h39us3ona.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF02FD6DF683@HQMAIL01.nvidia.com>
	<s5hd3tqyl9w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 67293244ED
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 23:06:57 +0200 (CEST)
In-Reply-To: <s5hd3tqyl9w.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: 'Anssi Hannula' <anssi.hannula@iki.fi>, Wei Ni <wni@nvidia.com>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 9 Aug 2010 14:31:30 -0700,
> Stephen Warren wrote:
> >
> > Takashi Iwai wrote:
> > >
> > > At Thu, 5 Aug 2010 07:23:26 -0700,
> > > Stephen Warren wrote:
> > > >
> > > > Takashi Iwai wrote:
> > > > > Sent: Thursday, August 05, 2010 6:28 AM
> > > > >
> > ...
> > > > > OK, what about the patch below (totally untested)?
> > > > >
> > > > > This updates the PCM info only at PCM open time. Apps usually check
> > > > > parameters only at open (due to hw_params stuff), so it doesn't make
> > > > > much sense to change dynamically at hotplug in the end.
> > > >
> > > > Doesn't that patch only use the ELD to set up the stream's supported parameters?
> > > > I think the code needs to determine the intersection of what's supported by the
> > > > codec (from HDA node parsing if that's the correct terminology) *and* the display
> > > > device (from the ELD), not just one of them.
> > >
> > > Good point.  A revised patch is below.
> > > Can anyone test it?
> >
> > FYI, I asked our affected end-user to test this a few days ago, but haven't heard
> > back yet. I'll let you know his results when I get them. I'll also see if we can
> > get this tested internally to NVIDIA. Unfortunately, I don't have the HW to do so
> > at present (although perhaps if I fake the ELD data, I could test it...)
> 
> OK, thanks for update.  If anyone can give it a try, please let me know the
> result.

I gave this a try by hacking our display driver to pass some hard-coded SADs to the
audio HW. This seems to work OK. Some thoughts:

I tested with a nice utility called alsacap from:

http://www.volkerschatz.com/noise/alsa.html

... slightly hacked to use snd_pcm_hw_params_test_rate for each rate explicitly.

I notice that when the ELD contains no results in common with the codec, alsacap says:

  Device 7, ID `NVIDIA HDMI', name `NVIDIA HDMI', 1 subdevices (1 available)
Error opening sound device for card 1, device 7: Hotplug device has been removed.  Skipping.

... which I guess does make sense, since there's no possibility of actually using the
device. However, when there is no device connected, this patch sets the PCM's
capabilities to the codec's capabilities. Does this make sense; should ALSA behave
the same as above? I suppose for safety, it may be better to attempt to let things
work in case there is some bug blocking the ELD data.

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
