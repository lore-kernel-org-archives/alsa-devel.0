From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/8] ALSA: control: add a comment about locking
	values after creating
Date: Wed, 11 Feb 2015 19:37:28 +0900
Message-ID: <1423651052-19593-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id CD3E12605D0
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:37:40 +0100 (CET)
In-Reply-To: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

All of created user controls are locked before added to system. This may
be against programmers or users expectation.

This commit adds a comment about this.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 0baff92..19f9f4e 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1255,8 +1255,11 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		return -ENOMEM;
 	}
 	_kctl->private_data = ue;
+
+	/* Lock values in this user controls. */
 	for (idx = 0; idx < _kctl->count; idx++)
 		_kctl->vd[idx].owner = file;
+
 	err = snd_ctl_add(card, _kctl);
 	if (err < 0)
 		return err;
-- 
2.1.0
