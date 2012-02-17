From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Change spitz_ext_control to take
	dapm as argument.
Date: Fri, 17 Feb 2012 10:17:31 +0000
Message-ID: <1329473851.3972.12.camel@odin>
References: <1329466556.21113.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 29B14103BD5
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 11:17:47 +0100 (CET)
Received: by wgbdq12 with SMTP id dq12so2331545wgb.23
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 02:17:32 -0800 (PST)
In-Reply-To: <1329466556.21113.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-02-17 at 16:15 +0800, Axel Lin wrote:
> This fixes below build warning:
>   CC      sound/soc/pxa/spitz.o
> sound/soc/pxa/spitz.c: In function 'spitz_startup':
> sound/soc/pxa/spitz.c:116: warning: passing argument 1 of 'spitz_ext_control' from incompatible pointer type
> sound/soc/pxa/spitz.c:47: note: expected 'struct snd_soc_card *' but argument is of type 'struct snd_soc_codec *'
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

gah, I must have only compile tested on OMAP.

Acked-by: Liam Girdwood <lrg@ti.com>

Thanks !

Liam
