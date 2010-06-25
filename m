From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: ak4642: Add ak4642_fill_cache
 function
Date: Fri, 25 Jun 2010 11:47:33 +0100
Message-ID: <1277462853.3123.13.camel@odin>
References: <w3pvd97k0nb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 349BD2455F
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 12:47:36 +0200 (CEST)
Received: by wwb39 with SMTP id 39so219375wwb.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 03:47:35 -0700 (PDT)
In-Reply-To: <w3pvd97k0nb.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-06-25 at 16:54 +0900, Kuninori Morimoto wrote:
> ak4642 driver is used for ak4642/ak4643.
> So, reading real register value is better than using constant value.
> 

To be honest, this is only really useful when the codec has some
volatile registers.  Forcing I2C reads for all IO will just slow down
the driver. 

Does this codec have volatile registers ?

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
