From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 8/8] ALSA: control: arrange snd_ctl_new() as a
	local function
Date: Wed, 11 Feb 2015 19:37:32 +0900
Message-ID: <1423651052-19593-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FAA52605DD
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:37:41 +0100 (CET)
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

The snd_ctl_new1() was added in 2001. I guess that snd_ctl_new() becames
a local function in this timing.

This commit arranges the function as a local helper function, remove
'snd_' prefix and comments, change comments to refer to the function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 04534f3..af95783 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -193,18 +193,8 @@ void snd_ctl_notify(struct snd_card *card, unsigned int mask,
 }
 EXPORT_SYMBOL(snd_ctl_notify);
 
-/**
- * snd_ctl_new - create a control instance from the template
- * @control: the control template
- * @access: the default control access
- *
- * Allocates a new struct snd_kcontrol instance and copies the given template 
- * to the new instance. It does not copy volatile data (access).
- *
- * Return: The pointer of the new instance, or %NULL on failure.
- */
-static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
-					unsigned int access)
+static struct snd_kcontrol *ctl_new(struct snd_kcontrol *control,
+				    unsigned int access)
 {
 	struct snd_kcontrol *kctl;
 	unsigned int size;
@@ -273,7 +263,7 @@ struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new *ncontrol,
 	kctl.tlv.p = ncontrol->tlv.p;
 	kctl.private_value = ncontrol->private_value;
 	kctl.private_data = private_data;
-	return snd_ctl_new(&kctl, access);
+	return ctl_new(&kctl, access);
 }
 EXPORT_SYMBOL(snd_ctl_new1);
 
@@ -281,9 +271,8 @@ EXPORT_SYMBOL(snd_ctl_new1);
  * snd_ctl_free_one - release the control instance
  * @kcontrol: the control instance
  *
- * Releases the control instance created via snd_ctl_new()
- * or snd_ctl_new1().
- * Don't call this after the control was added to the card.
+ * Releases the control instance created via ctl_new() or snd_ctl_new1(). Don't
+ * call this after the control was added to the card.
  */
 void snd_ctl_free_one(struct snd_kcontrol *kcontrol)
 {
@@ -334,9 +323,8 @@ static int snd_ctl_find_hole(struct snd_card *card, unsigned int count)
  * @card: the card instance
  * @kcontrol: the control instance to add
  *
- * Adds the control instance created via snd_ctl_new() or
- * snd_ctl_new1() to the given card. Assigns also an unique
- * numid used for fast search.
+ * Adds the control instance created via ctl_new() or snd_ctl_new1() to the
+ * given card. Assigns also an unique numid used for fast search.
  *
  * It frees automatically the control which cannot be added.
  *
@@ -1254,7 +1242,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		}
 	}
 	kctl.private_free = snd_ctl_elem_user_free;
-	_kctl = snd_ctl_new(&kctl, access);
+	_kctl = ctl_new(&kctl, access);
 	if (_kctl == NULL) {
 		kfree(ue->priv_data);
 		kfree(ue);
-- 
2.1.0
