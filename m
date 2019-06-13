From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: ipc: clarify operator precedence"
	to the asoc tree
Date: Thu, 13 Jun 2019 20:06:04 +0100 (BST)
Message-ID: <20190613190605.C9C2F440046@finisterre.sirena.org.uk>
References: <20190612165705.1858-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E614F89764
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:06:06 +0200 (CEST)
In-Reply-To: <20190612165705.1858-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: ipc: clarify operator precedence

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 847a040dd2ebb39effcc6bd3a5157fbded65bce7 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 12 Jun 2019 11:57:05 -0500
Subject: [PATCH] ASoC: SOF: ipc: clarify operator precedence

Cppcheck complains about the following warning, fix by adding
parentheses

[sound/soc/sof/ipc.c:783]:
(style) Clarify calculation precedence for '&' and '?'.
[sound/soc/sof/ipc.c:785]:
(style) Clarify calculation precedence for '&' and '?'.
[sound/soc/sof/ipc.c:787]:
(style) Clarify calculation precedence for '&' and '?'.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/ipc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index f3eb46bc808b..20dfca9c93b7 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -780,11 +780,11 @@ int snd_sof_ipc_valid(struct snd_sof_dev *sdev)
 			 " lock debug: %s\n"
 			 " lock vdebug: %s\n",
 			 v->build, v->date, v->time,
-			 ready->flags & SOF_IPC_INFO_GDB ?
+			 (ready->flags & SOF_IPC_INFO_GDB) ?
 				"enabled" : "disabled",
-			 ready->flags & SOF_IPC_INFO_LOCKS ?
+			 (ready->flags & SOF_IPC_INFO_LOCKS) ?
 				"enabled" : "disabled",
-			 ready->flags & SOF_IPC_INFO_LOCKSV ?
+			 (ready->flags & SOF_IPC_INFO_LOCKSV) ?
 				"enabled" : "disabled");
 	}
 
-- 
2.20.1
