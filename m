From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/20] ALSA: Add SNDRV_DEV_CARD type
Date: Wed, 12 Feb 2014 11:52:09 +0100
Message-ID: <1392202347-11774-3-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CA178265079
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:47 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BD074ABB2
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:52:47 +0000 (UTC)
In-Reply-To: <1392202347-11774-1-git-send-email-tiwai@suse.de>
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

Define the new SNDRV_DEV_CARD that is used for managing the top-level
card (chip) object.  So far, we used SNDRV_DEV_LOWLEVEL for this
purpose, but it doesn't fit properly; the "lowlevel" doesn't match
with the object it's assigned (where the card/chip object is rather a
top-level one).  And since the device register/free order will be more
strictly ordered in the later patch, we should place this object in
the right order position.

This patch alone just adds SNDRV_DEV_CARD as equivalent as
SNDRV_DEV_LOWLEVEL.  In the later patch, the value will be adjusted
appropriately.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/DocBook/writing-an-alsa-driver.tmpl | 10 +++++-----
 include/sound/core.h                              |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/DocBook/writing-an-alsa-driver.tmpl b/Documentation/DocBook/writing-an-alsa-driver.tmpl
index d0056a4e9c53..c6119a30169b 100644
--- a/Documentation/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/DocBook/writing-an-alsa-driver.tmpl
@@ -462,7 +462,7 @@
            */
           ....
 
-          err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+          err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
           if (err < 0) {
                   snd_mychip_free(chip);
                   return err;
@@ -870,8 +870,8 @@
       callback pointers (<parameter>&amp;ops</parameter>). The
       device-level defines the type of components and the order of
       registration and de-registration.  For most components, the
-      device-level is already defined.  For a user-defined component,
-      you can use <constant>SNDRV_DEV_LOWLEVEL</constant>.
+      device-level is already defined.  For a user-defined card component,
+      you can use <constant>SNDRV_DEV_CARD</constant>.
       </para>
 
       <para>
@@ -1018,7 +1018,7 @@
           .dev_free =        snd_mychip_dev_free,
   };
   ....
-  snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+  snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 ]]>
             </programlisting>
           </informalexample>
@@ -1171,7 +1171,7 @@
           /* (2) initialization of the chip hardware */
           .... /*   (not implemented in this document) */
 
-          err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+          err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
           if (err < 0) {
                   snd_mychip_free(chip);
                   return err;
diff --git a/include/sound/core.h b/include/sound/core.h
index 7c407b588697..127b908a2422 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -64,6 +64,7 @@ enum snd_device_type {
 	SNDRV_DEV_JACK,
 	SNDRV_DEV_COMPRESS,
 	SNDRV_DEV_LOWLEVEL	= 0x2000,
+	SNDRV_DEV_CARD = SNDRV_DEV_LOWLEVEL,
 };
 
 enum snd_device_state {
-- 
1.8.5.2
