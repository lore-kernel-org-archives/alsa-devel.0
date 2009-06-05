From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH v4 0/4] ARM: DaVinci: ASoC: Audio support for
	DM646x
Date: Fri,  5 Jun 2009 06:27:48 -0400
Message-ID: <1244197668-30916-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 810282468F
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 13:06:32 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n55B6PtC007350
	for <alsa-devel@alsa-project.org>; Fri, 5 Jun 2009 06:06:30 -0500
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
Cc: Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Chaithrika U S <chaithrika@ti.com>

Add audio support for DM646x

Signed-off-by: Naresh Medisetty <naresh@ti.com>
Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
This patch set adds audio support for DM646x

This updated version has included most of the review comments received for
the previous version of the patch set.

Patch 1: Registers the platform devices for ASP on dm355, dm644x and dm646x
	 This patch applies to the DaVinci git tree available at
	 http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git

Patch 2: Introduces platform driver model for dm644x and dm355
	 Applies against ALSA mainline - to the topic/asoc
	 branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

Patch 3: Adds driver support for the two instances of McASP on TI's DM646x
	 Applies against ALSA mainline - to the topic/asoc
	 branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

Patch 4: Add machine driver support for DM646x
	 Applies against ALSA mainline - to the topic/asoc
	 branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

These patches are based on the work done by Steve Chen <schen@mvista.com> and
Pavel Kiryukhin <pkiryukhin@ru.mvista.com> on Monstavista 2.6.18 kernel.
