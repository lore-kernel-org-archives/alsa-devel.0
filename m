From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: wm8994: Fix typo in VMID ramp setting
Date: Tue, 07 Feb 2012 19:17:02 +0000
Message-ID: <1328642222.3896.10.camel@odin>
References: <1328641334-30169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E19D103C65
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 20:17:05 +0100 (CET)
Received: by mail-ww0-f52.google.com with SMTP id ds10so6228611wgb.33
	for <alsa-devel@alsa-project.org>; Tue, 07 Feb 2012 11:17:04 -0800 (PST)
In-Reply-To: <1328641334-30169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Tue, 2012-02-07 at 19:02 +0000, Mark Brown wrote:
> The VMID ramp rate is supposed to be 3b, not 0x11. Fix that.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index 81795eb..b75a652 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -785,7 +785,7 @@ static void vmid_reference(struct snd_soc_codec *codec)
>  				    WM8994_VMID_RAMP_MASK,
>  				    WM8994_STARTUP_BIAS_ENA |
>  				    WM8994_VMID_BUF_ENA |
> -				    (0x11 << WM8994_VMID_RAMP_SHIFT));
> +				    (0x3 << WM8994_VMID_RAMP_SHIFT));

The commit message says 3b, so maybe a typo ?

Liam 
