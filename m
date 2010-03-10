From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/20] ASoC: S3C64XX: I2S: Move RATE and
 FMT defines to header
Date: Wed, 10 Mar 2010 10:51:10 +0000
Message-ID: <20100310105109.GG24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BAC524391
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 11:51:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 04:48:57PM +0900, Jassi Brar wrote:
> In order for the RATE and FMT defines to be reuseable in future by the
> i2sv4 driver, move the MACROs out to the header file.

I'll apply this but for the rates...

> -#define S3C64XX_I2S_RATES \
> -	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
> -	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
> -	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)

This is just SNDRV_PCM_RATE_8000_96000 anyway so may as well use it
directly.
