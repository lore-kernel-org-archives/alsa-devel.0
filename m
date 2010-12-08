From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2] ASoC: WM8580: Debug BCLK and sample size
Date: Wed, 8 Dec 2010 08:06:36 +0000
Message-ID: <A21D77C9-C87A-40DD-BD8A-3A2166B34752@opensource.wolfsonmicro.com>
References: <1291717387-11961-1-git-send-email-jassi.brar@samsung.com>
	<1291794624-13982-1-git-send-email-jassi.brar@samsung.com>
	(sfid-20101208_080432_329121_B86440D6)
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47116103AF3
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 09:06:46 +0100 (CET)
In-Reply-To: <1291794624-13982-1-git-send-email-jassi.brar@samsung.com>
	(sfid-20101208_080432_329121_B86440D6)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, kgene.kim@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 8 Dec 2010, at 07:50, Jassi Brar wrote:

> In case of SNDRV_PCM_FORMAT_S32_LE, we need to set
> WM8580_AIF_LENGTH_32, rather than WM8580_AIF_LENGTH_24.
> Also, the BCLK has to be 64fs, for sample size of 20, 24 and 32 bits.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

The original version of this patch was already applied, though an
incremental patch dropping the |= 0 would be nice.
