From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 3/5] ASoC: omap-mcpdm: Set 24msbits
	constraint
Date: Wed, 18 Jan 2012 11:45:02 +0000
Message-ID: <20120118114501.GL8732@opensource.wolfsonmicro.com>
References: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
	<1326885506-6140-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58846103B52
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 12:45:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326885506-6140-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 18, 2012 at 12:18:24PM +0100, Peter Ujfalusi wrote:
> McPDM internal FIFO is 24 bit wide. From the 32 bit sample
> 8 bit is discarded. Let application know about this
> via msbits constraint.

Applied, thanks.
