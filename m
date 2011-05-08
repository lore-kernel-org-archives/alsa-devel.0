From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 4/6] ASoC: OMAP: Add CPU DAI driver for HDMI
Date: Sat, 07 May 2011 19:05:17 -0500
Message-ID: <1304813117.11941.197.camel@sagan>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-5-git-send-email-ricardo.neri@ti.com>
	<20110505082253.GF11744@opensource.wolfsonmicro.com>
	<1304624105.1900.41.camel@sagan>
	<20110506132133.GM23729@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 45F6A1037F3
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 02:16:02 +0200 (CEST)
In-Reply-To: <20110506132133.GM23729@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
Am Freitag, den 06.05.2011, 08:21 -0500 schrieb Mark Brown:
> On Thu, May 05, 2011 at 02:35:05PM -0500, Ricardo Neri wrote:
> > Am Donnerstag, den 05.05.2011, 03:22 -0500 schrieb Mark Brown:
> 
> > > dev_er().  Also, why are you checking this, and are you checking it too
> > > early?
> 
> > I will replace with dev_err(). I need to check if HDMI display is active
> > because the HDMI DSS driver is in charge of powering on/off the HDMI IP.
> > Audio can play only if the HDMI IP is on. I don't have a .trigger
> > function in my DAI so I thought it was OK to perform the check
> > at .startup. Do you think I should create a .trigger function and
> > perform the check from there?
> 
> Why do you need to check at all?  The playback won't work when the
> output isn't connected but the application layer will find that out when
> there's no data transfer anyway.  If you implement the check in startup
> I'd imagine there may be some races with hotplug of HDMI cables.

I need to check somewhere if the Display Subsystem (and the HDMI IP) is
on. Otherwise I will have L3 interconnect errors when trying to access
the DSS while it is power-disconnected. I need the HDMI IP on for
getting configurations (e.g, deep color mode) and use the HDMI audio
FIFO.

Can you clarify what kind of races with hotplug are you concerned? The
DSS would detect cable connection events and power on the HDMI IP
accordingly. HDMI audio driver would only check if it is powered-on.
 
Perhaps I could create a .trigger function and perform the check at the
start of audio playback. Furthermore, I could move the check to the HDMI
audio codec, as it is more related to DSS.
