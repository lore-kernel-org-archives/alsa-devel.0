From: Xiao Yang <YangX92@hotmail.com>
Subject: [PATCH] ALSA: control: Make sure that id->index does
 not overflow in function snd_ctl_replace
Date: Fri, 31 Aug 2018 11:00:02 +0000
Message-ID: <HK0PR01MB2163F85F844A29460C46A6F7AD0F0@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-oln040092254076.outbound.protection.outlook.com [40.92.254.76])
 by alsa0.perex.cz (Postfix) with ESMTP id 71E8C26781F
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 13:00:15 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.com" <tiwai@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "92siuyang@gmail.com" <92siuyang@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, Xiao Yang <YangX92@hotmail.com>
List-Id: alsa-devel@alsa-project.org

From: Young_X <YangX92@hotmail.com>

    The ALSA control code expects that the range of assigned indices to a 
    control is continuous and does not overflow. Currently there are no 
    checks to enforce this.
    If a control with a overflowing index range is created that control 
    becomes effectively inaccessible and unremovable since 
    snd_ctl_find_id() will not be able to find it. This patch adds a check 
    that makes sure that controls with a overflowing index range can not 
    be created.
    (same issue as CVE-2014-4656)

Signed-off-by: Young_X <YangX92@hotmail.com>
---
 sound/core/control.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 9aa15bf..6435772 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -441,6 +441,11 @@ int snd_ctl_replace(struct snd_card *card, struct snd_kcontrol *kcontrol,
 		goto error;
 	}
 	id = kcontrol->id;
+	if (id.index > UINT_MAX - kcontrol->count) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	down_write(&card->controls_rwsem);
 	old = snd_ctl_find_id(card, &id);
 	if (!old) {
-- 
2.7.4
