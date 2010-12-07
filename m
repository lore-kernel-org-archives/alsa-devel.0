From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Add speaker driver widget.
Date: Tue, 7 Dec 2010 13:09:15 +0000
Message-ID: <20101207130914.GF4698@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7E@dlee06.ent.ti.com>
	<20101206224359.GB2862@opensource.wolfsonmicro.com>
	<1291676132.3281.116.camel@odin>
	<20101206230948.GH2862@opensource.wolfsonmicro.com>
	<1291678207.3281.152.camel@odin>
	<8C6859A9-36EF-4016-822B-DA67D7147E28@opensource.wolfsonmicro.com>
	<1291725285.3275.14.camel@odin>
	<20101207123600.GD4698@rakim.wolfsonmicro.main>
	<1291725988.3275.22.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B8DF103A39
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:09:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291725988.3275.22.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 07, 2010 at 12:46:28PM +0000, Liam Girdwood wrote:

> Ok, but by sharing the number we take away some flexibility in the
> sequence ordering. Say something has to be done in the machine driver
> _after_ the spk/haptic/vibra driver is enabled in the CODEC driver ?

You can say that for pretty much all of the widgets, though, including
the existing speaker and headphone widgets.  I'd be a bit surprised if
you had anything afterwards in this case, a driver is generally the high
power stage wired directly to the transducer.

> I dont actually see any major issue of using a new number here unless
> you have it reserved for something else ?

Adding a new number and renumbering all the subsequent ones wouldn't be
so bad, the patch wasn't doing that.
