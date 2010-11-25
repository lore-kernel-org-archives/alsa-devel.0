From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/8] ASoC: fix resource leak in error paths
Date: Thu, 25 Nov 2010 10:47:47 +0000
Message-ID: <1290682067.3302.14.camel@odin>
References: <1290668785.30158.7.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AB474103C13
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 11:47:50 +0100 (CET)
Received: by eyg24 with SMTP id 24so355298eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 02:47:50 -0800 (PST)
In-Reply-To: <1290668785.30158.7.camel@mola>
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
Cc: alsa-devel@alsa-project.org, Hauer <s.hauer@pengutronix.de>, Jaswinder Singh Brar <jassi.brar@samsung.com>, Sergey Lapin <slapin@ossfans.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sedji@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Sascha@alsa-project.org, Gaouaou <sedji.gaouaou@atmel.com>, Mika Westerberg <mika.westerberg@iki.fi>, Jon@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-25 at 15:06 +0800, Axel Lin wrote:
> This serial of patches fix resource leak in error paths.
> 
> Axel Lin (8):
>   ASoC: efika-audio-fabric: fix resource leak in efika_fabric_init
>     error path
>   ASoC: pcm030-audio-fabric: fix resource leak in pcm030_fabric_init
>     error path
>   ASoC: snd-soc-afeb9260: remove unneeded platform_device_del in error
>     path
>   ASoC: sam9g20_wm8731: fix resource leak in at91sam9g20ek_init error
>     path
>   ASoC: smdk_wm9713: fix resource leak in smdk_init error path
>   ASoC: simone: fix resource leak in simone_init error path
>   ASoC: imx-ssi: fix resource leak
>   ASoC: phycore-ac97: fix resource leak
> 
>  sound/soc/atmel/sam9g20_wm8731.c    |    5 ++++-
>  sound/soc/atmel/snd-soc-afeb9260.c  |    1 -
>  sound/soc/ep93xx/simone.c           |   18 ++++++++++--------
>  sound/soc/fsl/efika-audio-fabric.c  |    1 +
>  sound/soc/fsl/pcm030-audio-fabric.c |    1 +
>  sound/soc/imx/imx-ssi.c             |   15 +++++++++++----
>  sound/soc/imx/phycore-ac97.c        |   28 +++++++++++++++++++++-------
>  sound/soc/samsung/smdk_wm9713.c     |   17 ++++++++++-------
>  8 files changed, 58 insertions(+), 28 deletions(-)
> 
All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
