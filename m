From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/4] Fixes resource leaks for Samsung SoCs
Date: Fri, 26 Nov 2010 12:26:36 +0000
Message-ID: <1290774396.3298.6.camel@odin>
References: <1290754245.25125.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 39CAA24341
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 13:26:42 +0100 (CET)
Received: by wyi11 with SMTP id 11so1902941wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 04:26:41 -0800 (PST)
In-Reply-To: <1290754245.25125.1.camel@mola>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cuelenaere <mcuelenaere@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Graeme Gregory <graeme@openmoko.org>, Chanwoo Choi <cw00.choi@samsung.com>, Maurus@alsa-project.org, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-11-26 at 14:50 +0800, Axel Lin wrote:
> This serial of patches fixes resource leaks for Samsung SoCs.
> 
> Axel Lin (4):
>   ASoC: Fix resource leask in goni_wm8994.c
>   ASoC: Fix resource leask in neo1973_gta02_init() error path
>   ASoC: Add missing gpio_free(S3C64XX_GPK(12)) in smartq_exit()
>   ASoC: Fix resource leask in smdk_spdif.c
> 
>  sound/soc/samsung/goni_wm8994.c          |    9 +++++++--
>  sound/soc/samsung/neo1973_gta02_wm8753.c |   22 +++++++++++-----------
>  sound/soc/samsung/smartq_wm8987.c        |    1 +
>  sound/soc/samsung/smdk_spdif.c           |   13 +++++++++----
>  4 files changed, 28 insertions(+), 17 deletions(-)
> 

All 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
