From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix invalid function call in
	snd_hda_add_vmaster()
Date: Mon, 30 Jun 2014 14:12:22 +0200
Message-ID: <1404130342-2753-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EEC026554B
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 14:12:23 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 351CEABEB
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 12:12:23 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The recent commit [6194b99d: ALSA: hda - Kill the rest of snd_print*()
usages] changed the callback map_slaves(), but one call was forgotten
to be replaced due to the cast, which leads to kernel Oops due to
invalid function.  This patch replaces it with a proper function.

Fixes: 6194b99de9f5 ('ALSA: hda - Kill the rest of snd_print*() usages')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index d91cb7f5961a..47a617786fca 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2831,6 +2831,12 @@ static int init_slave_unmute(struct hda_codec *codec,
 	return put_kctl_with_value(slave, 1);
 }
 
+static int add_slave(struct hda_codec *codec,
+		     void *data, struct snd_kcontrol *slave)
+{
+	return snd_ctl_add_slave(data, slave);
+}
+
 /**
  * snd_hda_add_vmaster - create a virtual master control and add slaves
  * @codec: HD-audio codec
@@ -2873,8 +2879,7 @@ int __snd_hda_add_vmaster(struct hda_codec *codec, char *name,
 	if (err < 0)
 		return err;
 
-	err = map_slaves(codec, slaves, suffix,
-			 (map_slave_func_t)snd_ctl_add_slave, kctl);
+	err = map_slaves(codec, slaves, suffix, add_slave, kctl);
 	if (err < 0)
 		return err;
 
-- 
2.0.0
