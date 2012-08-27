From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 07/11] [media] media: add entity types for
	ALSA
Date: Tue, 28 Aug 2012 00:33:07 +0200
Message-ID: <503BF5A3.1030908@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C30B1265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:34:04 +0200 (CEST)
In-Reply-To: <503BF48E.1090100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add entity types for describing the topology of sound devices.

JACK entities represent connections to the outside world.  Properties of
the jack will be described by a TLV on the jack entity.

MIXER entities add their inputs together, while SELECTOR entities route
on of their inputs to the output.  PROCESSING entities represent volume/
mute controls or other effects processing units.  These entities may
have ALSA controls associated with them, which is indicated by those
controls having a TLV containing the entity ID and the control type.

SPLIT and MERGE entities are needed for HDA codecs, whose topology is
constructed of stereo channel pairs.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/linux/media.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/linux/media.h b/include/linux/media.h
index 0ef8833..9d2ad75 100644
--- a/include/linux/media.h
+++ b/include/linux/media.h
@@ -57,6 +57,15 @@ struct media_device_info {
 #define MEDIA_ENT_T_V4L2_SUBDEV_FLASH	(MEDIA_ENT_T_V4L2_SUBDEV + 2)
 #define MEDIA_ENT_T_V4L2_SUBDEV_LENS	(MEDIA_ENT_T_V4L2_SUBDEV + 3)

+#define MEDIA_ENT_T_JACK		(3 << MEDIA_ENT_TYPE_SHIFT)
+
+#define MEDIA_ENT_T_ALSA		(4 << MEDIA_ENT_TYPE_SHIFT)
+#define MEDIA_ENT_T_ALSA_MIXER		(MEDIA_ENT_T_ALSA + 1)
+#define MEDIA_ENT_T_ALSA_SELECTOR	(MEDIA_ENT_T_ALSA + 2)
+#define MEDIA_ENT_T_ALSA_PROCESSING	(MEDIA_ENT_T_ALSA + 3)
+#define MEDIA_ENT_T_ALSA_SPLIT		(MEDIA_ENT_T_ALSA + 4)
+#define MEDIA_ENT_T_ALSA_MERGE		(MEDIA_ENT_T_ALSA + 5)
+
 #define MEDIA_ENT_FL_DEFAULT		(1 << 0)

 struct media_entity_desc {
