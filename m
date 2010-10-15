From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] sound/soc/codecs/wm8994.c: Remove unused
	vol
Date: Fri, 15 Oct 2010 11:08:53 +0100
Message-ID: <1287137333.3271.8.camel@odin>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
	<B2150E1E4418E1438554A300EA5040E40D469C124F@ITSVLEX06.it.maxim-ic.internal>
	<1286934472.1117.129.camel@Joe-Laptop>
	<20101013082414.GD6424@rakim.wolfsonmicro.main>
	<1286971846.1117.191.camel@Joe-Laptop>
	<20101013123301.GL6424@rakim.wolfsonmicro.main>
	<1286983191.1117.338.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 16469103C3D
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 12:08:57 +0200 (CEST)
Received: by wwb28 with SMTP id 28so623430wwb.20
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2010 03:08:56 -0700 (PDT)
In-Reply-To: <1286983191.1117.338.camel@Joe-Laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Marroquin <Jesse.Marroquin@maxim-ic.com>, Jesse@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-10-13 at 08:19 -0700, Joe Perches wrote:
> Remove unused vol from struct access_mask
> 
> Reduces object size ~3kb.
> 
> $ size sound/soc/codecs/wm8994.o*
>    text	   data	    bss	    dec	    hex	filename
>   40727	   4384	   4480	  49591	   c1b7	sound/soc/codecs/wm8994.o.new
>   43879	   4384	   4480	  52743	   ce07	sound/soc/codecs/wm8994.o.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
