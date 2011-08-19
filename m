From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 1/2] ucm: fix seg fault in execute_cset()
Date: Fri, 19 Aug 2011 16:05:25 +0800
Message-ID: <20110819080525.9512.90201.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 31198103909
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 10:05:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

When there's no space in 'cset', 'pos' gets NULL, dereferencing 'pos' gets a
seg fault. We need to be more robust.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 src/ucm/main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 8e9a85d..9ecbe43 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -196,7 +196,8 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
 		goto __fail;
 	err = 0;
       __fail:
-	*pos = ' ';
+	if (pos != NULL)
+		*pos = ' ';
 
 	if (id != NULL)
 		free(id);
