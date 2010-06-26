From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 0/5] ASoC multi-component support : core
Date: Sat, 26 Jun 2010 18:29:27 +0100
Message-ID: <1277573367.3110.17.camel@odin>
References: <1277407467.3100.579.camel@odin>
	<AANLkTimfC5rdr8r0Ll4GM7d_8WapNR3Tkk9_r-Vo3aeB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A9E1724386
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 19:29:35 +0200 (CEST)
Received: by wyf23 with SMTP id 23so656446wyf.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 10:29:35 -0700 (PDT)
In-Reply-To: <AANLkTimfC5rdr8r0Ll4GM7d_8WapNR3Tkk9_r-Vo3aeB@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, jassisinghbrar <jassisinghbrar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, "vaibhav.bedia" <vaibhav.bedia@ti.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Ryan Mallon <ryan@bluewatersys.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-06-26 at 10:25 +0800, Wan ZongShun wrote:
> 2010/6/25 Liam Girdwood <lrg@slimlogic.co.uk>:

> > All the multi-component code is in my multi-component branch here :-
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git
> >
> 
> I really want to test my nuc900 platform, but the git tree seems to
> base linux-2.6.31,
> where nuc900 most platform files not be merged. so I have to wait for
> 2.6.36 to update and test my driver?

The multi-component branch is up to date, it's just that the master
branch on this tree is at an older version.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
