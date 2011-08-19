From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 2/2] ucm: tivial code style fix
Date: Fri, 19 Aug 2011 16:05:30 +0800
Message-ID: <20110819080530.9512.17272.stgit@localhost6.localdomain6>
References: <20110819080525.9512.90201.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FCD8103924
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 10:05:32 +0200 (CEST)
In-Reply-To: <20110819080525.9512.90201.stgit@localhost6.localdomain6>
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

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 src/ucm/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 9ecbe43..76ca151 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -173,7 +173,7 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
 	pos = strrchr(cset, ' ');
 	if (pos == NULL) {
 		uc_error("undefined value for cset >%s<", cset);
-		err =  -EINVAL;
+		err = -EINVAL;
 		goto __fail;
 	}
 	*pos = '\0';
