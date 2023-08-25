Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADBCC83F01
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Aug 2023 17:06:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBEE4DF8;
	Sun, 27 Aug 2023 19:06:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBEE4DF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693156012;
	bh=jtGPtnNovZrI/f//0jEhdbjbAaXAVtUPDp5InTJbXgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=h/yR4FmApqjxiN96IEe+Lqu1L/PjSCdyxKOViWKxPo08IyrYWf1yK4hyJIYJ+qhyi
	 nOdg9n3v3JB3+0KXOYl5sLmaJcn5XJBnhebQy8+kGvefNfmZzu2n/+9pO6YVCouASy
	 YxXSJedSSlBdS3MIjoAAxl3RYAr8SZaAg2mzoceY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 19F0FF80558; Sun, 27 Aug 2023 19:03:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D774F8023B;
	Sun, 27 Aug 2023 19:03:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF476F80552; Sat, 26 Aug 2023 00:22:12 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9A907F800D1
	for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2023 00:22:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A907F800D1
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id B13AA242C1;
	Fri, 25 Aug 2023 18:21:58 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qZfBm-iUZ-00; Sat, 26 Aug 2023 00:21:58 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v5 1/8] ALSA: add snd_ctl_add_locked() & export
 snd_ctl_remove_locked()
Date: Sat, 26 Aug 2023 00:21:51 +0200
Message-Id: <20230825222158.171007-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230825222158.171007-1-oswald.buddenhagen@gmx.de>
References: <20230825222158.171007-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: OPJD3GYMTUDQT2OFNWOZHBKVT5OMQNC5
X-Message-ID-Hash: OPJD3GYMTUDQT2OFNWOZHBKVT5OMQNC5
X-Mailman-Approved-At: Sun, 27 Aug 2023 17:03:08 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OPJD3GYMTUDQT2OFNWOZHBKVT5OMQNC5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This will be used to dynamically change the available controls from
another control's put() callback, which is already locked.

One might want to add snd_ctl_replace_locked() for completeness, but I
have no use for it now.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---

applying this upstream would simplify applying the emu10k1 high bit-rate
patchset locally, as it would limit the affected modules to the driver
itself.

v4:
- adjust to recent locking changes
- mark exports as internal

v3:
- fixed typo in commit message

v2:
- extended commit message
---
 include/sound/control.h |  2 ++
 sound/core/control.c    | 43 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 9a4f4f7138da..7729b4ee1509 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -133,7 +133,9 @@ void snd_ctl_notify_one(struct snd_card * card, unsigned int mask, struct snd_kc
 
 struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new * kcontrolnew, void * private_data);
 void snd_ctl_free_one(struct snd_kcontrol * kcontrol);
+int snd_ctl_add_locked(struct snd_card *card, struct snd_kcontrol *kcontrol);
 int snd_ctl_add(struct snd_card * card, struct snd_kcontrol * kcontrol);
+int snd_ctl_remove_locked(struct snd_card *card, struct snd_kcontrol *kcontrol);
 int snd_ctl_remove(struct snd_card * card, struct snd_kcontrol * kcontrol);
 int snd_ctl_replace(struct snd_card *card, struct snd_kcontrol *kcontrol, bool add_on_replace);
 int snd_ctl_remove_id(struct snd_card * card, struct snd_ctl_elem_id *id);
diff --git a/sound/core/control.c b/sound/core/control.c
index 59c8658966d4..9e807804e110 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -39,9 +39,6 @@ static LIST_HEAD(snd_control_compat_ioctls);
 #endif
 static struct snd_ctl_layer_ops *snd_ctl_layer;
 
-static int snd_ctl_remove_locked(struct snd_card *card,
-				 struct snd_kcontrol *kcontrol);
-
 static int snd_ctl_open(struct inode *inode, struct file *file)
 {
 	unsigned long flags;
@@ -509,6 +506,27 @@ static int __snd_ctl_add_replace(struct snd_card *card,
 	return 0;
 }
 
+static int snd_ctl_add_replace_locked(struct snd_card *card,
+				      struct snd_kcontrol *kcontrol,
+				      enum snd_ctl_add_mode mode)
+{
+	int err = -EINVAL;
+
+	if (! kcontrol)
+		return err;
+	if (snd_BUG_ON(!card || !kcontrol->info))
+		goto error;
+
+	err = __snd_ctl_add_replace(card, kcontrol, mode);
+	if (err < 0)
+		goto error;
+	return 0;
+
+ error:
+	snd_ctl_free_one(kcontrol);
+	return err;
+}
+
 static int snd_ctl_add_replace(struct snd_card *card,
 			       struct snd_kcontrol *kcontrol,
 			       enum snd_ctl_add_mode mode)
@@ -532,6 +550,16 @@ static int snd_ctl_add_replace(struct snd_card *card,
 	return err;
 }
 
+/**
+ * snd_ctl_add_locked - same as snd_ctl_add(), but card->controls_rwsem
+ * is expected to be already locked if necessary.
+ */
+int snd_ctl_add_locked(struct snd_card *card, struct snd_kcontrol *kcontrol)
+{
+	return snd_ctl_add_replace_locked(card, kcontrol, CTL_ADD_EXCLUSIVE);
+}
+EXPORT_SYMBOL_GPL(snd_ctl_add_locked);
+
 /**
  * snd_ctl_add - add the control instance to the card
  * @card: the card instance
@@ -596,11 +624,16 @@ static int __snd_ctl_remove(struct snd_card *card,
 	return 0;
 }
 
-static inline int snd_ctl_remove_locked(struct snd_card *card,
-					struct snd_kcontrol *kcontrol)
+/**
+ * snd_ctl_remove_locked - same as snd_ctl_remove(), but card->controls_rwsem
+ * is expected to be already locked if necessary.
+ */
+int snd_ctl_remove_locked(struct snd_card *card,
+			  struct snd_kcontrol *kcontrol)
 {
 	return __snd_ctl_remove(card, kcontrol, true);
 }
+EXPORT_SYMBOL_GPL(snd_ctl_remove_locked);
 
 /**
  * snd_ctl_remove - remove the control from the card and release it
-- 
2.40.0.152.g15d061e6df

