From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: WM8804: Retrieve the device revision
 and print it
Date: Tue, 05 Oct 2010 17:48:48 +0100
Message-ID: <1286297328.3111.113.camel@odin>
References: <1286206139-8851-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EE4D710381A
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 18:48:50 +0200 (CEST)
Received: by eye27 with SMTP id 27so2605542eye.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Oct 2010 09:48:50 -0700 (PDT)
In-Reply-To: <1286206139-8851-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-10-04 at 16:28 +0100, Dimitris Papastamos wrote:
> Be verbose and print out the device revision.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8804.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
> index 2657f5c..642b07c 100644
> --- a/sound/soc/codecs/wm8804.c
> +++ b/sound/soc/codecs/wm8804.c
> @@ -643,6 +643,14 @@ static int wm8804_probe(struct snd_soc_codec *codec)
>  		goto err_reg_enable;
>  	}
>  
> +	ret = snd_soc_read(codec, WM8804_DEVREV);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to read device revision: %d\n",
> +			ret);
> +		goto err_reg_enable;
> +	}
> +	dev_info(codec->dev, "revision %c\n", ret + 'A');
> +
>  	ret = wm8804_reset(codec);
>  	if (ret < 0) {
>  		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
