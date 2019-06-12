From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/5] ASoC: SOF: ipc: clarify operator precedence
Date: Wed, 12 Jun 2019 11:57:05 -0500
Message-ID: <20190612165705.1858-6-pierre-louis.bossart@linux.intel.com>
References: <20190612165705.1858-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF3B5F80791
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 18:57:15 +0200 (CEST)
In-Reply-To: <20190612165705.1858-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Cppcheck complains about the following warning, fix by adding
parentheses

[sound/soc/sof/ipc.c:783]:
(style) Clarify calculation precedence for '&' and '?'.
[sound/soc/sof/ipc.c:785]:
(style) Clarify calculation precedence for '&' and '?'.
[sound/soc/sof/ipc.c:787]:
(style) Clarify calculation precedence for '&' and '?'.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
