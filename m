From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 1/3] ALSA: core: trivial code style fix
Date: Wed, 24 Aug 2011 11:12:34 +0800
Message-ID: <20110824031234.5279.46501.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 91509245A4
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 05:12:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

remove trailing tab on the line.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/core/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index f8c5be4..7f2b3a7 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1072,7 +1072,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	long private_size;
 	struct user_element *ue;
 	int idx, err;
-	
+
 	if (card->user_ctl_count >= MAX_USER_CONTROLS)
 		return -ENOMEM;
 	if (info->count < 1)
