From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [ASoC PATCH 1/1] IMote 2 ASoC Support
Date: Mon, 4 May 2009 15:41:19 +0100
Message-ID: <20090504144119.GO6975@sirena.org.uk>
References: <49FEFDC8.2090103@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C433F1037FE
	for <alsa-devel@alsa-project.org>;
	Mon,  4 May 2009 16:41:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49FEFDC8.2090103@cam.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: alsa-devel@alsa-project.org, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, May 04, 2009 at 02:38:00PM +0000, Jonathan Cameron wrote:

> +	/* Disable the PLL */
> +	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, 0);
> +	if (ret < 0)

This seems very odd - the PLL is never enabled by your driver but you go
through and explicitly disable it every time the driver is configured.

Other than that this looks fine; you're including more headers than you
really need but that shouldn't do any harm.
