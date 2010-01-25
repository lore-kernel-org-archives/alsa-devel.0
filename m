From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: DaVinci: CQ93VC Voice Codec
Date: Mon, 25 Jan 2010 11:11:04 +0000
Message-ID: <20100125111104.GC22909@sirena.org.uk>
References: <1264095660-1323-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8982F10386E
	for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2010 12:11:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1264095660-1323-1-git-send-email-miguel.aguilar@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, nsekhar@ti.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 21, 2010 at 11:41:00AM -0600, miguel.aguilar@ridgerun.com wrote:

> +static __init int cq93vc_codec_probe(struct platform_device *pdev)
> +{

...

> +	cq93vc_codec = codec;
> +
> +	ret = snd_soc_register_dai(&cq93vc_dai);
> +	if (ret != 0) {
> +		dev_err(davinci_vc->dev, "could register dai\n");
> +		goto fail1;
> +	}
> +	return 0;

There should also be a snd_soc_register_codec() before this, and
similarly on the remove.  Otherwise this looks good.
