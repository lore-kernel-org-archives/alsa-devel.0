From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] ASoC: OMAP: Add CPU DAI driver for HDMI
Date: Sun, 8 May 2011 11:34:02 +0100
Message-ID: <20110508103402.GA12921@opensource.wolfsonmicro.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-5-git-send-email-ricardo.neri@ti.com>
	<20110505082253.GF11744@opensource.wolfsonmicro.com>
	<1304624105.1900.41.camel@sagan>
	<20110506132133.GM23729@opensource.wolfsonmicro.com>
	<1304813117.11941.197.camel@sagan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C2A12417D
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 12:33:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304813117.11941.197.camel@sagan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, May 07, 2011 at 07:05:17PM -0500, Ricardo Neri wrote:
> Am Freitag, den 06.05.2011, 08:21 -0500 schrieb Mark Brown:

> > Why do you need to check at all?  The playback won't work when the
> > output isn't connected but the application layer will find that out when
> > there's no data transfer anyway.  If you implement the check in startup
> > I'd imagine there may be some races with hotplug of HDMI cables.

> I need to check somewhere if the Display Subsystem (and the HDMI IP) is
> on. Otherwise I will have L3 interconnect errors when trying to access
> the DSS while it is power-disconnected. I need the HDMI IP on for
> getting configurations (e.g, deep color mode) and use the HDMI audio
> FIFO.

I repeat my question - why do you need to check this?  You'll get errors
but you're generating an error anyway so it's not clear what the urgency
is.

> Can you clarify what kind of races with hotplug are you concerned? The
> DSS would detect cable connection events and power on the HDMI IP
> accordingly. HDMI audio driver would only check if it is powered-on.

Something noticing that the cable is plugged in and trying to begin
audio setup while the link is still being initialised.
