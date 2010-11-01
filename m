From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Fix SND_SOC_ALL_CODECS typos for
 alc5623 and jz4740
Date: Mon, 1 Nov 2010 09:22:56 -0400
Message-ID: <20101101132253.GA23423@opensource.wolfsonmicro.com>
References: <1288360065-9793-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3DEC10381C
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 14:22:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288360065-9793-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 29, 2010 at 04:47:44PM +0300, Jarkko Nikula wrote:

>  	select SND_SOC_AK4671 if I2C
> -	select SND_SOC_ALC562 if I2C
> +	select SND_SOC_ALC5623 if I2C

This patch doesn't apply as-is since this CODEC isn't in mainline.  I've
dropped it from the patch and applied together with the second patch.
