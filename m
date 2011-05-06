From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: OMAP4: Add HDMI Audio machine
 driver for OMAP4 boards
Date: Fri, 6 May 2011 14:22:03 +0100
Message-ID: <20110506132203.GN23729@opensource.wolfsonmicro.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-6-git-send-email-ricardo.neri@ti.com>
	<20110505082516.GG11744@opensource.wolfsonmicro.com>
	<1304629759.1900.111.camel@sagan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 336EF243BA
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 15:22:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304629759.1900.111.camel@sagan>
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

On Thu, May 05, 2011 at 04:09:19PM -0500, Ricardo Neri wrote:
> Am Donnerstag, den 05.05.2011, 03:25 -0500 schrieb Mark Brown:

> > You never need to reset driver data on unregister, nothing should
> > reference it except a driver.
> I saw that other drivers (harmony and mfld) reset driver data after
> unregister. Is that incorrect as well? Anyways, I don't needed for my
> driver.

It's always a waste of time.
