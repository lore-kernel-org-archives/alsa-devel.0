From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH v2 0/6] ARM: DaVinci: ASoC: Add mcasp support
	for DM646x
Date: Thu, 16 Apr 2009 18:37:02 -0400
Message-ID: <1239921422-26729-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E3FBB103945
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 13:24:55 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3GBOnk6021314
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 06:24:54 -0500
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
Cc: davinci-linux-open-source@linux.davincidsp.com, "Naresh.Medisetty" <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Naresh.Medisetty <naresh@ti.com>

Add audio support for DM646x

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch set adds audio support for DM646x

This series is dependant on the following 3 patches submitted to the
DaVinci git:

[PATCH v2 1/2] ARM: DaVinci: EDMA: Move queue related mappings to dm<soc>.c
[PATCH v2 2/2] ARM: DaVinci: EDMA: Enable EDMA support for dm646x
[PATCH] ARM: DaVinci:  Fix the machine_is_davinci_dm6467_evm() error

Patch 1:        Adds driver support for the two instances of McASP on TI's DM646x
                Applies against ALSA mainline - that's the topic/asoc
                branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git


Patch 2:        Adds McASP clock support for the two instances of mcasp
                casp0,mcasp1)
                This patch applies to the DaVinci git tree available at
                http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git


Patch 3:        Registers the platform devices for ASP on dm355, dm644x and dm646x
                This patch applies to the DaVinci git tree available at
                http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git


Patch 4:        Add dummy codec support
                Applies against ALSA mainline - that's the topic/asoc
                branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git


Patch 5:        Add machine driver support for DM646x
                Applies against ALSA mainline - that's the topic/asoc
                branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

Patch 6:        Introduces platfrom driver model for dm644x and dm355
                Applies against ALSA mainline - that's the topic/asoc
                branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

These patches are based on the work done by Steve Chen <schen@mvista.com> and
Pavel Kiryukhin <pkiryukhin@ru.mvista.com> on Monstavista 2.6.18 kernel.
