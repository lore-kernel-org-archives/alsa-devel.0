From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH MC Next Gen 08/20] media: Move au8522_media_pads enum to au8522.h from au8522_priv.h
Date: Fri,  2 Oct 2015 16:07:20 -0600
Message-ID: <2d0214f44644c53e5180635d3fe8023b04449a5c.1443822799.git.shuahkh@osg.samsung.com>
References: <cover.1443822799.git.shuahkh@osg.samsung.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1443822799.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1443822799.git.shuahkh@osg.samsung.com>
References: <cover.1443822799.git.shuahkh@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@osg.samsung.com, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com, tiwai@suse.de, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, perex@perex.cz, dan.carpenter@oracle.com, tskd08@gmail.com, arnd@arndb.de, ruchandani.tina@gmail.com, corbet@lwn.net, k.kozlowski@samsung.com, chehabrafael@gmail.com, prabhakar.csengg@gmail.com, elfring@users.sourceforge.net, Julia.Lawall@lip6.fr, p.zabel@pengutronix.de, ricardo.ribalda@gmail.com, labbott@fedoraproject.org, chris.j.arges@canonical.com, pierre-louis.bossart@linux.intel.com, johan@oljud.se, wsa@the-dreams.de, jcragg@gmail.com, clemens@ladisch.de, daniel@zonque.org, gtmkramer@xs4all.nl, misterpib@gmail.com, takamichiho@gmail.com, pmatilai@laiskiainen.org, vladcatoi@gmail.com, damien@zamaudio.com, normalperson@yhbt.net, joe@oampo.co.uk, jussi@sonarnerd.netca
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Move the au8522_media_pads enum to au8522.h from au8522_priv.h.
This will allow au0828-core to use these defines instead of
hard-coding the pad values when it creates media graph linking
decode pads to other entities.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/dvb-frontends/au8522.h      | 7 +++++++
 drivers/media/dvb-frontends/au8522_priv.h | 8 --------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/media/dvb-frontends/au8522.h b/drivers/media/dvb-frontends/au8522.h
index dde6158..3c72f40 100644
--- a/drivers/media/dvb-frontends/au8522.h
+++ b/drivers/media/dvb-frontends/au8522.h
@@ -90,4 +90,11 @@ enum au8522_audio_input {
 	AU8522_AUDIO_SIF,
 };
 
+enum au8522_media_pads {
+	AU8522_PAD_INPUT,
+	AU8522_PAD_VID_OUT,
+	AU8522_PAD_VBI_OUT,
+
+	AU8522_NUM_PADS
+};
 #endif /* __AU8522_H__ */
diff --git a/drivers/media/dvb-frontends/au8522_priv.h b/drivers/media/dvb-frontends/au8522_priv.h
index d6209d9..4c2a6ed 100644
--- a/drivers/media/dvb-frontends/au8522_priv.h
+++ b/drivers/media/dvb-frontends/au8522_priv.h
@@ -39,14 +39,6 @@
 #define AU8522_DIGITAL_MODE 1
 #define AU8522_SUSPEND_MODE 2
 
-enum au8522_media_pads {
-	AU8522_PAD_INPUT,
-	AU8522_PAD_VID_OUT,
-	AU8522_PAD_VBI_OUT,
-
-	AU8522_NUM_PADS
-};
-
 struct au8522_state {
 	struct i2c_client *c;
 	struct i2c_adapter *i2c;
-- 
2.1.4
