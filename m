From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 0/9] ARM: DaVinci: ASoC: Adds Audio support for
	TI DM646X
Date: Mon, 16 Mar 2009 08:00:54 -0400
Message-ID: <1237204854-29989-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D6F1103804
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 13:18:09 +0100 (CET)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2GCI32x021304
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 07:18:08 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Adds Audio support for TI DM646X EVM platform

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch set adds audio support for DM646x

This series is dependant on the following 2 patches submitted to the
DaVinci git:

[PATCH 1/2] ARM: DaVinci: EDMA: Move queue to tc mapping to dm<soc>.c
[PATCH 2/2] ARM: DaVinci: EDMA: Enable EDMA support for dm646x

Patch 1: Adds ASoC driver support for TI DM646X EVM platform
	Applies to the DaVinci git.

Patch 2: Adds ALSA SoC McASP Audio Layer for TI DM646X processor
	Applies to the ASoC tree.

Patch 3: Adds header file for McASP Audio Layer for TI DM646X processor
	Applies to the ASoC tree.

Patch 4: Adds ALSA PCM interface for the TI DM646X processor
	Applies to the ASoC tree.

Patch 5: Adds Audio Serial Port support for TI DM646X processor
	Applies to the DaVinci git.

Patch 6: Adds McASP clock support for TI DM646X processor
	Applies to the DaVinci git.

Patch 7: Adds ALSA SoC DIT driver support for DM646X
	Applies to the ASoC tree.

Patch 8: ASoC: Adds header file for DM646X DIT driver
	Applies to the ASoC tree.

Patch 9: Adds build support for DM646X audio driver
	Applies to the ASoC tree.

These patches are based on the work done by Steve Chen <schen@mvista.com>
on Monstavista 2.6.18 kernel.

Even without these patches the ASoC tree (http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=commit;h=168776ef58d38503f8ac4f8a7eb1039137208032) build for DaVinci is broken.
