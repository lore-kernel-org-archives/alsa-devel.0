From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/20] ASoC: S3C: I2Sv2: Reject immidiate
	register value
Date: Wed, 10 Mar 2010 10:32:04 +0000
Message-ID: <20100310103203.GE24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18E7324347
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 11:32:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
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

On Wed, Mar 10, 2010 at 04:48:51PM +0900, Jassi Brar wrote:
> Towards generalizing CPU driver interface, do not accept direct field
> values for the BCLK and RCLK.
> The machine driver should simply request the FS-multiple and not provide
> the value to be set in divide field of IISMOD.

> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

This is good but it needs to also update all the machine drivers that
use the direct register values.  A brief grep through suggests that the
uda134x machine and the OpenMoko machines need a look, though I didn't
actually check which DAI driver they're all using.  If nothing uses this
feature then just note that in the changelog (if the feature is unused
that's even more reason to remove it anyway).
