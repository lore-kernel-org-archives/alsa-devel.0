From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 1/3] dmaengine: Add wrapper for device_tx_status
 callback
Date: Wed, 20 Jun 2012 16:24:22 +0530
Message-ID: <1340189662.1927.1648.camel@vkoul-udesk3>
References: <1339438302-12417-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339438302-12417-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Russell King <linux@arm.linux.org.uk>, Ola Lilja <ola.o.lilja@stericsson.com>, Shawn Guo <shawn.guo@linaro.org>, Mika Westerberg <mika.westerberg@iki.fi>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-06-11 at 20:11 +0200, Lars-Peter Clausen wrote:
> This patch adds a small inline wrapper for the devivce_tx_status callback of a
> dma device. This makes the source code of users of this function a bit more
> compact and a bit more legible.
Applied, thanks

rest of the series should go thru ASoC tree.

-- 
~Vinod
