From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 6/7] dmasound_core: Move two assignments for the variable
 "ret" in state_open()
Date: Tue, 24 Jan 2017 11:26:15 +0100
Message-ID: <b4d0b274-23ac-4369-7119-a77e5108578b@users.sourceforge.net>
References: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Martin Koegler <martin.koegler@chello.at>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Jan 2017 10:05:29 +0100

A local variable was set to an error code in two cases before a concrete
error situation was detected. Thus move the corresponding assignments into
if branches to indicate a software failure there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/oss/dmasound/dmasound_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index f4ee85a4c42f..2bdd1d619a7f 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -1269,13 +1269,15 @@ static int state_open(struct inode *inode, struct file *file)
 	int ret;
 
 	mutex_lock(&dmasound_core_mutex);
-	ret = -EBUSY;
-	if (state.busy)
+	if (state.busy) {
+		ret = -EBUSY;
 		goto out;
+	}
 
-	ret = -ENODEV;
-	if (!try_module_get(dmasound.mach.owner))
+	if (!try_module_get(dmasound.mach.owner)) {
+		ret = -ENODEV;
 		goto out;
+	}
 
 	state.ptr = 0;
 	state.busy = 1;
-- 
2.11.0

