From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [0/4] Convert PXA AC97 to use clock API
Date: Tue, 19 Feb 2008 16:03:41 +0000
Message-ID: <20080219160341.GA6387@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B15EE24601
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 17:03:43 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: eric miao <eric.miao@marvell.com>, Russell King <rmk@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

This patch series adds support for AC97 clocks on the PXA27xx and PXA3xx
and converts both SoC and non-SoC pxa2xx-ac97 drivers to use the clock
API rather than pxa_set_cken().

Since the ALSA changes require the changes to the ARM platform code it
probably makes sense for them to be merged through ARM rather than ALSA.
