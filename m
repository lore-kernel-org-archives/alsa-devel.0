From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Add speaker driver widget.
Date: Tue, 7 Dec 2010 12:36:00 +0000
Message-ID: <20101207123600.GD4698@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7E@dlee06.ent.ti.com>
	<20101206224359.GB2862@opensource.wolfsonmicro.com>
	<1291676132.3281.116.camel@odin>
	<20101206230948.GH2862@opensource.wolfsonmicro.com>
	<1291678207.3281.152.camel@odin>
	<8C6859A9-36EF-4016-822B-DA67D7147E28@opensource.wolfsonmicro.com>
	<1291725285.3275.14.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C11B103834
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 13:36:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291725285.3275.14.camel@odin>
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

On Tue, Dec 07, 2010 at 12:34:45PM +0000, Liam Girdwood wrote:
> On Mon, 2010-12-06 at 23:38 +0000, Mark Brown wrote:

> > ...we don't need to change the ordering at all, we've already got a
> > sequence point for this sort of widget we can use. We should just make
> > the existing speaker and headphone widgets be in terms of one, I think.

> The only minor problem here is that the current sequence point is name
> "snd_soc_dapm_spk" which would seem confusing to haptic/vibra driver
> users. Although, I can live with this....

I meant the number in the sequence - the patch had the new widget coming
up in the slot before the existing output driver widgets.
