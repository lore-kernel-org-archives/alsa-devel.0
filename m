From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] SOC: UDA134x: Remove POWER_OFF_ON_STANDBY
	define.
Date: Sun, 08 May 2011 15:10:21 +0100
Message-ID: <1304863821.3246.4.camel@odin>
References: <1304426792-23540-1-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 40C7110380D
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 16:10:25 +0200 (CEST)
Received: by wwf26 with SMTP id 26so3808665wwf.20
	for <alsa-devel@alsa-project.org>; Sun, 08 May 2011 07:10:24 -0700 (PDT)
In-Reply-To: <1304426792-23540-1-git-send-email-marek.belisko@open-nandra.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-05-03 at 14:46 +0200, Marek Belisko wrote:
> Define POWER_OFF_ON_STANDBY cause trobles when trying to get some
> sound from codec because code for bias setup was not compiled
> (define wasn't defined). This define was removed in commit:
> cc3202f5 but again introduced by commit: f0fba2ad1 which then
> completely break codec functionality so remove it again.
> 
> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
> ---
>  sound/soc/codecs/uda134x.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
> index 48ffd40..a7b8f30 100644
> --- a/sound/soc/codecs/uda134x.c
> +++ b/sound/soc/codecs/uda134x.c
> @@ -601,9 +601,7 @@ static struct snd_soc_codec_driver soc_codec_dev_uda134x = {
>  	.reg_cache_step = 1,
>  	.read = uda134x_read_reg_cache,
>  	.write = uda134x_write,
> -#ifdef POWER_OFF_ON_STANDBY
>  	.set_bias_level = uda134x_set_bias_level,
> -#endif
>  };
>  
>  static int __devinit uda134x_codec_probe(struct platform_device *pdev)

Acked-by: Liam Girdwood <lrg@ti.com>
