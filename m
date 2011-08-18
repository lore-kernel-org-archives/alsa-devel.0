From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: omap: Fix build errors in ams-delta
Date: Thu, 18 Aug 2011 14:20:04 +0100
Message-ID: <4E4D1184.1080507@ti.com>
References: <1313668967-5657-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 281AA2432E
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 15:20:08 +0200 (CEST)
In-Reply-To: <1313668967-5657-1-git-send-email-jarkko.nikula@bitmer.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: alsa-devel@alsa-project.org

On 18/08/11 13:02, Jarkko Nikula wrote:
> Fix "error: too few arguments to function 'ams_delta_set_bias_level'"
> build errors in ams-delta.c that were introduced after commit d4c6005 ("ASoC:
> Add context parameter to card DAPM callbacks") by adding dapm context
> to ams_delta_set_bias_level calls.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Acked-by: Liam Girdwood <lrg@ti.com>

Mark, can you take this since my broadband is still broken.

Thanks

Liam
