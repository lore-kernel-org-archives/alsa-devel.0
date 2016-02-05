From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix static checker warning in
	patch_hdmi.c
Date: Fri,  5 Feb 2016 09:05:41 +0100
Message-ID: <1454659541-18065-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 74C202605D2
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 09:05:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, dan.carpenter@oracle.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The static checker warning is:

	sound/pci/hda/patch_hdmi.c:460 hdmi_eld_ctl_get()
	error: __memcpy() 'eld->eld_buffer' too small (256 vs 512)

I have a hard time figuring out if this can ever cause an information leak
(I don't think so), but nonetheless it does not hurt to increase the
robustness of the code.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 1f52b55..2191e235 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -448,7 +448,8 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 	eld = &per_pin->sink_eld;
 
 	mutex_lock(&per_pin->lock);
-	if (eld->eld_size > ARRAY_SIZE(ucontrol->value.bytes.data)) {
+	if (eld->eld_size > ARRAY_SIZE(ucontrol->value.bytes.data) ||
+	    eld->eld_size > ELD_MAX_SIZE) {
 		mutex_unlock(&per_pin->lock);
 		snd_BUG();
 		return -EINVAL;
-- 
1.9.1
