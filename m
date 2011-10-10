From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: Fix DAPM sync for TLV320AIC3x custom
	DAPM widget
Date: Mon, 10 Oct 2011 10:25:53 +0300
Message-ID: <4E929E01.2030806@bitmer.com>
References: <1318077861-24901-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 522AF243CE
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 09:26:09 +0200 (CEST)
In-Reply-To: <1318077861-24901-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 10/08/2011 03:44 PM, Mark Brown wrote:
> We really should be doing this in the core, not in a driver...
>
> Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
> ---
>   include/sound/soc-dapm.h       |    3 +++
>   sound/soc/codecs/tlv320aic3x.c |    4 ++++
>   sound/soc/soc-dapm.c           |    3 ++-
>   3 files changed, 9 insertions(+), 1 deletions(-)
>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
