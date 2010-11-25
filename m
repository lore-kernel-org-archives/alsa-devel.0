From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix compile error for smartq_wm8987.c
Date: Thu, 25 Nov 2010 10:47:14 +0000
Message-ID: <1290682034.3302.13.camel@odin>
References: <1290663829.30158.5.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 81CFC103BEE
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 11:47:18 +0100 (CET)
Received: by wwb13 with SMTP id 13so691764wwb.2
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 02:47:18 -0800 (PST)
In-Reply-To: <1290663829.30158.5.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Maurus Cuelenaere <mcuelenaere@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-25 at 13:43 +0800, Axel Lin wrote:
> Fix below compile error:
> 
>   CC      sound/soc/samsung/smartq_wm8987.o
> sound/soc/samsung/smartq_wm8987.c: In function 'smartq_hifi_hw_params':
> sound/soc/samsung/smartq_wm8987.c:42: error: 'struct snd_soc_pcm_runtime' has no member named 'dai'
> sound/soc/samsung/smartq_wm8987.c:43: error: 'struct snd_soc_pcm_runtime' has no member named 'dai'
> sound/soc/samsung/smartq_wm8987.c: In function 'smartq_wm8987_init':
> sound/soc/samsung/smartq_wm8987.c:192: warning: passing argument 1 of 'snd_soc_jack_new' from incompatible pointer type
> sound/soc/samsung/smartq_wm8987.c: At top level:
> sound/soc/samsung/smartq_wm8987.c:216: warning: initialization from incompatible pointer type
> make[3]: *** [sound/soc/samsung/smartq_wm8987.o] Error 1
> make[2]: *** [sound/soc/samsung] Error 2
> make[1]: *** [sound/soc] Error 2
> make: *** [sound] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.o.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
