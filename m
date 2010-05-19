From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: SDP4430: Add sdp4430 machine
	driver
Date: Wed, 19 May 2010 14:17:03 +0100
Message-ID: <1274275023.3240.148.camel@odin>
References: <1274143990-314-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 14FF51038FB
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 15:17:11 +0200 (CEST)
Received: by wwd20 with SMTP id 20so616126wwd.38
	for <alsa-devel@alsa-project.org>; Wed, 19 May 2010 06:17:09 -0700 (PDT)
In-Reply-To: <1274143990-314-1-git-send-email-jorge.candelaria@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Misael Lopez Cruz <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-05-17 at 19:53 -0500, Jorge Eduardo Candelaria wrote:
> From: Misael Lopez Cruz <x0052729@ti.com>
> 
> Add ASoC support for TI SDP4430.
> 
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> ---
>  sound/soc/omap/Kconfig   |    9 ++
>  sound/soc/omap/Makefile  |    2 +
>  sound/soc/omap/sdp4430.c |  228 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 239 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/omap/sdp4430.c
> 

Applied. Btw, I had to add the following to remove a build warning.

commit d8b55d2cd00df4d599985440fd75b38d153bffcb
Author: Liam Girdwood <lrg@slimlogic.co.uk>
Date:   Wed May 19 14:14:51 2010 +0100

    ASoC: sdp4430 - add sdp4430 pcm ops to DAI.
    
    Fix build warning about unused ops and add ops
    to the sdp4430 DAI link.
    
    Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 3a0c198..4ebbde6 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -167,6 +167,7 @@ static struct snd_soc_dai_link sdp4430_dai = {
        .cpu_dai = &omap_mcpdm_dai,
        .codec_dai = &twl6040_dai,
        .init = sdp4430_twl6040_init,
+       .ops = &sdp4430_ops,
 };
 
 /* Audio machine driver */


Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
