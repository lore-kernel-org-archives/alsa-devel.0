From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry
 checking for each DAIs separately
Date: Wed, 21 Sep 2011 15:59:12 +0100
Message-ID: <20110921145911.GD6245@opensource.wolfsonmicro.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8DED52414F
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 16:59:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314609314-22162-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, s.hauer@pengutronix.de, w.sang@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 29, 2011 at 05:15:14PM +0800, Dong Aisheng wrote:

> -static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
> +static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
> +					struct snd_soc_dai *soc_dai)

Applied, thanks.  But plain dai would have been a better name here.
