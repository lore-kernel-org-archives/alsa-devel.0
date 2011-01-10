From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Add DAPM selection for
	LOM invert
Date: Mon, 10 Jan 2011 13:50:59 +0000
Message-ID: <20110110135059.GD23070@opensource.wolfsonmicro.com>
References: <1294666789-16272-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 084031038D0
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 14:53:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294666789-16272-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 10, 2011 at 03:39:49PM +0200, Peter Ujfalusi wrote:
> The L/R LOM line can be invertined side of the
> corresponding DAC, or inverted from the corresponding
> LOP.
> Add control for user space to select the source of the
> LOM inversion.
> When only the analog bypass is enabled, and the LOM
> is inverted from DAC output, we need to power the
> corresponding DAC.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
