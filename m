From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix type for
	snd_soc_volatile_register()
Date: Mon, 24 Jan 2011 12:41:20 +0000
Message-ID: <20110124124120.GE29925@opensource.wolfsonmicro.com>
References: <1295872772-6308-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A99FB2448D
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 13:41:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295872772-6308-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 24, 2011 at 12:39:32PM +0000, Mark Brown wrote:
> We generally refer to registers as unsigned ints (including in the
> underlying CODEC driver operation).
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> @@ -2039,6 +2040,25 @@ int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg)
>  EXPORT_SYMBOL_GPL(snd_soc_codec_volatile_register);
>  
>  /**
> + * snd_soc_codec_register_name: Return a plain text register name

Gah, clearly this shouldn't be here.
