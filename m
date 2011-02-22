From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Correct definition of
 WM8903_VMID_RES_5K
Date: Tue, 22 Feb 2011 09:42:02 +0000
Message-ID: <1298367722.3353.12.camel@odin>
References: <>
	<1298314655-5596-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C32510386A
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 10:42:05 +0100 (CET)
Received: by wwe15 with SMTP id 15so6817981wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 01:42:05 -0800 (PST)
In-Reply-To: <1298314655-5596-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-02-21 at 18:57 +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8903.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8903.h b/sound/soc/codecs/wm8903.h
> index 7d96646..ed4cb5b 100644
> --- a/sound/soc/codecs/wm8903.h
> +++ b/sound/soc/codecs/wm8903.h
> @@ -183,7 +183,7 @@ extern int wm8903_mic_detect(struct snd_soc_codec *codec,
>  
>  #define WM8903_VMID_RES_50K                          2
>  #define WM8903_VMID_RES_250K                         3
> -#define WM8903_VMID_RES_5K                           4
> +#define WM8903_VMID_RES_5K                           6
>  
>  /*
>   * R8 (0x08) - Analogue DAC 0

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
