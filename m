From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Conditionalize the enable of WM8994
	ADC TDM mode
Date: Wed, 6 Jul 2011 10:00:48 +0100
Message-ID: <4E142440.6040604@ti.com>
References: <1309936148-11027-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 7211A1037F3
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 11:00:54 +0200 (CEST)
In-Reply-To: <1309936148-11027-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 06/07/11 08:09, Mark Brown wrote:
> Future devices will not benefit from this.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
