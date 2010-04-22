From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC - Support for multiple components
Date: Thu, 22 Apr 2010 09:52:17 -0500
Message-ID: <4BD062A1.8080107@freescale.com>
References: <1271686144.3208.305.camel@odin>	
	<k2ved82fe3e1004211407qae60e223of729dff1b6e34d83@mail.gmail.com>	
	<p2ned82fe3e1004211513zffc1ae64k7e12daf4a3cac648@mail.gmail.com>
	<1271935673.3228.335.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id B70901038B3
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 16:52:38 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3MEqK7b029755
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 07:52:31 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3MF1bj1008497
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 10:01:37 -0500 (CDT)
In-Reply-To: <1271935673.3228.335.camel@odin>
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
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>, mano@roarinelk.homelinux.net, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, anemo@mba.ocn.ne.jp
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> The use of ID here is to deprecate the passing in of the 'driver' struct
> so it can be removed in a subsequent patch. I'm trying to make the
> changes as small as possible here, but let me see how much difference
> changing this now will make to the current patch size. 

I'd be okay if you did this work later, if it turns out to be too onerous.

-- 
Timur Tabi
Linux kernel developer at Freescale
