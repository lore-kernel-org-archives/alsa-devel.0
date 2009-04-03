From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 0/5] ARM: DaVinci: ASoC: Add audio support for
	DM646x
Date: Thu,  2 Apr 2009 21:46:51 -0400
Message-ID: <1238723211-27329-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E01BB10385D
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 16:34:19 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n32EYDku028065
	for <alsa-devel@alsa-project.org>; Thu, 2 Apr 2009 09:34:18 -0500
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

Add audio support for DM646x

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch set adds audio support for DM646x

This series is dependant on the following 3 patches submitted to the
DaVinci git:

[PATCH v2 1/2] ARM: DaVinci: EDMA: Move queue related mappings to dm<soc>.c
[PATCH v2 2/2] ARM: DaVinci: EDMA: Enable EDMA support for dm646x
[PATCH] ARM: DaVinci:  Fix the machine_is_davinci_dm6467_evm() error

Patch 1:	Adds driver support for the two instances of McASP on TI's DM646x
		Applies against ALSA mainline - that's the topic/asoc
		branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git


Patch 2: 	Adds McASP clock support for the two instances of mcasp
		casp0,mcasp1)
		This patch applies to the DaVinci git tree available at
		http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git


Patch 3: 	Registers the platform devices for ASP on dm355, dm644x and dm646x
		This patch applies to the DaVinci git tree available at
		http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git


Patch 4: 	Add dummy codec support
		Applies against ALSA mainline - that's the topic/asoc
                branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git


Patch 5: 	Add machine driver support for DM646x
                Applies against ALSA mainline - that's the topic/asoc
                branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

These patches are based on the work done by Steve Chen <schen@mvista.com>
on Monstavista 2.6.18 kernel.
