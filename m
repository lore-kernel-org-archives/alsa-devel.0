From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 17/20] ASoC: S3C: I2Sv2: Define new field
 for controller features
Date: Wed, 10 Mar 2010 11:09:59 +0000
Message-ID: <20100310110958.GI24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-12-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-13-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-14-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-15-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-16-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-17-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F6ED243B0
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 12:10:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268207349-9979-17-git-send-email-jassi.brar@samsung.com>
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

On Wed, Mar 10, 2010 at 04:49:06PM +0900, Jassi Brar wrote:

> While adding support for new SoCs' I2S, check for the blocks
> of older SoCs that have similar feature and set the flag for
> that feature.

As a result of this...

> +/* Set this flag for I2S controllers that have the bit IISMOD[12]
> + * bridge/break RCLK signal and external Xi2sCDCLK pin.
> + */
> +#define S3C_FEATURE_CDCLKCON	(1 << 0)
> +

...I'd suggest moving this into the patch that adds support for
CDCLKCON (or merging that patch in with this one).

Probably worth namespacing these defines a bit more (eg, S3C_IIS_) since
I'd expect they'll end up being used by the arch/arm code too in the
platform data definition.  They ought to be in include/sound or arch/arm
for visibility to arch/arm code too.
