From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] ASoC AC97 generic glue patches
Date: Wed, 13 Oct 2010 10:31:12 +0100
Message-ID: <1286962272.3282.29.camel@odin>
References: <cover.1286958072.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id DDFCE243BB
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 11:31:15 +0200 (CEST)
Received: by wyb32 with SMTP id 32so3658754wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 02:31:15 -0700 (PDT)
In-Reply-To: <cover.1286958072.git.mika.westerberg@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-10-13 at 11:30 +0300, Mika Westerberg wrote:
> Hi,
> 
> While I was porting ep93xx-ac97 driver to multicomponent ASoC, I encountered few
> issues with the generic AC97 glue driver (which we are using with Sim.One). This
> series tries to fix those.
> 
> Regards,
> MW
> 
> Mika Westerberg (3):
>   ASoC: ac97: don't call snd_soc_new_ac97_codec at probe
>   ASoC: don't register AC97 devices twice
>   ASoC: ac97: add MODULE_ALIAS for the platform driver
> 
>  include/sound/soc.h     |    1 +
>  sound/soc/codecs/ac97.c |    7 +------
>  sound/soc/soc-core.c    |   18 ++++++++++++++++++
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
