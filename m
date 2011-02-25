From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v5] ASoC: Add Freescale SGTL5000 codec
 support
Date: Fri, 25 Feb 2011 09:13:42 +0000
Message-ID: <1298625222.3363.7.camel@odin>
References: <1298484501-3993-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DE57103813
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 10:13:47 +0100 (CET)
Received: by wyb28 with SMTP id 28so1363990wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 01:13:46 -0800 (PST)
In-Reply-To: <1298484501-3993-1-git-send-email-zhaoming.zeng@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhaoming.zeng@freescale.com
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, timur.tabi@gmail.com, zengzm.kernel@gmail.com, xiao-lizhang@freescale.com, arnaud.patard@rtp-net.org, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-02-24 at 02:08 +0800, zhaoming.zeng@freescale.com wrote:
> From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
> 
> Add Freescale SGTL5000 codec support.
> Supported features:
>  - line-in and mic input
>  - headphone and line-out output
>  - line-in bypass ADC and DAC to headphone
>  - 16, 20, 24, 32 bit audio
>  - 8 ~ 96k sample rates
> 
> Signed-off-by: Zeng Zhaoming <zhaoming.zeng@freescale.com>
> ---
> Changes since v4:
> 1. Fix regulator resource leak in sgtl5000_enable_regulators().
> 2. Fix memory leak in ldo_regulator_register() when desc.name malloc failed.
> 3. Del snd_soc_dapm_free() in sgtl5000_remove().
> 4. Correct the typos.
> 5. Replace pr_err() with dev_err in sgtl5000_set_clock().
> 6. Fix code style.
> 
> Thanks for the review of Timur, Mark, Sascha and Arnaud.
> ---
>  sound/soc/codecs/Kconfig    |    5 +
>  sound/soc/codecs/Makefile   |    2 +
>  sound/soc/codecs/sgtl5000.c | 1512 +++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/sgtl5000.h |  402 ++++++++++++
>  4 files changed, 1921 insertions(+), 0 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Btw, your custom PCM volume controls look similar to the register format
used by AC97 volume controls. Did you try the kcontrol convenience
macros before writing your own control ? 

Thanks

Liam
