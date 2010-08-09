From: Stephen Warren <swarren@nvidia.com>
Subject: Re: HDMI audio: TV vs. codec supported sample rates
Date: Mon, 9 Aug 2010 14:31:30 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF683@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF319@HQMAIL01.nvidia.com>
	<201008051357.18821.anssi.hannula@iki.fi>	<s5hmxt1gw58.wl%tiwai@suse.de>
	<201008051417.10835.anssi.hannula@iki.fi>	<s5heiedgs66.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF02FD6DF494@HQMAIL01.nvidia.com>
	<s5h39us3ona.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CA1F24151
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 23:31:19 +0200 (CEST)
In-Reply-To: <s5h39us3ona.wl%tiwai@suse.de>
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
>
> At Thu, 5 Aug 2010 07:23:26 -0700,
> Stephen Warren wrote:
> >
> > Takashi Iwai wrote:
> > > Sent: Thursday, August 05, 2010 6:28 AM
> > >
...
> > > OK, what about the patch below (totally untested)?
> > >
> > > This updates the PCM info only at PCM open time. Apps usually check
> > > parameters only at open (due to hw_params stuff), so it doesn't make
> > > much sense to change dynamically at hotplug in the end.
> >
> > Doesn't that patch only use the ELD to set up the stream's supported parameters?
> > I think the code needs to determine the intersection of what's supported by the
> > codec (from HDA node parsing if that's the correct terminology) *and* the display
> > device (from the ELD), not just one of them.
> 
> Good point.  A revised patch is below.
> Can anyone test it?

FYI, I asked our affected end-user to test this a few days ago, but haven't heard
back yet. I'll let you know his results when I get them. I'll also see if we can
get this tested internally to NVIDIA. Unfortunately, I don't have the HW to do so
at present (although perhaps if I fake the ELD data, I could test it...)

-- 
nvpublic
