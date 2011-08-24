From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH v2] ALSA: core: release the constraint check
	for replace ops
Date: Wed, 24 Aug 2011 14:45:10 +0800
Message-ID: <20110824064509.7162.39455.stgit@localhost6.localdomain6>
References: <20110824060854.GE3551@guanqun-laptop.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id A2B862467A
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 08:45:11 +0200 (CEST)
In-Reply-To: <20110824060854.GE3551@guanqun-laptop.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Suppose the ALSA card already has a number of MAX_USER_CONTROLS controls, and
the user wants to replace one, it should not fail at this condition check.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/core/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 7f2b3a7..dc2a440 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1073,7 +1073,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	struct user_element *ue;
 	int idx, err;
 
-	if (card->user_ctl_count >= MAX_USER_CONTROLS)
+	if (!replace && card->user_ctl_count >= MAX_USER_CONTROLS)
 		return -ENOMEM;
 	if (info->count < 1)
 		return -EINVAL;
