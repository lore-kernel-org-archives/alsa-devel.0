From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] ASoC: OMAP: Add CPU DAI driver for HDMI
Date: Fri, 6 May 2011 14:21:33 +0100
Message-ID: <20110506132133.GM23729@opensource.wolfsonmicro.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-5-git-send-email-ricardo.neri@ti.com>
	<20110505082253.GF11744@opensource.wolfsonmicro.com>
	<1304624105.1900.41.camel@sagan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ABDE3243BA
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 15:21:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304624105.1900.41.camel@sagan>
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

On Thu, May 05, 2011 at 02:35:05PM -0500, Ricardo Neri wrote:
> Am Donnerstag, den 05.05.2011, 03:22 -0500 schrieb Mark Brown:

> > dev_er().  Also, why are you checking this, and are you checking it too
> > early?

> I will replace with dev_err(). I need to check if HDMI display is active
> because the HDMI DSS driver is in charge of powering on/off the HDMI IP.
> Audio can play only if the HDMI IP is on. I don't have a .trigger
> function in my DAI so I thought it was OK to perform the check
> at .startup. Do you think I should create a .trigger function and
> perform the check from there?

Why do you need to check at all?  The playback won't work when the
output isn't connected but the application layer will find that out when
there's no data transfer anyway.  If you implement the check in startup
I'd imagine there may be some races with hotplug of HDMI cables.
