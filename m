From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/3] ALSA: snd-usb: handle the bmFormats field
	as unsigned int
Date: Sun, 17 Mar 2013 20:07:24 +0800
Message-ID: <1363522047-7515-2-git-send-email-zonque@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 748DC265173
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2013 13:07:42 +0100 (CET)
In-Reply-To: <1363522047-7515-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

This field may use up to 32 bits, so it should be handled as unsigned
int.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Andreas Koch <andreas@akdesigninc.com>
---
 sound/usb/format.c |    9 +++++----
 sound/usb/format.h |    2 +-
 sound/usb/stream.c |    2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index e831ee4..b30d6fb 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -43,7 +43,7 @@
  */
 static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 				     struct audioformat *fp,
-				     int format, void *_fmt,
+				     unsigned int format, void *_fmt,
 				     int protocol)
 {
 	int sample_width, sample_bytes;
@@ -353,7 +353,7 @@ err:
  * parse the format type I and III descriptors
  */
 static int parse_audio_format_i(struct snd_usb_audio *chip,
-				struct audioformat *fp, int format,
+				struct audioformat *fp, unsigned int format,
 				struct uac_format_type_i_continuous_descriptor *fmt,
 				struct usb_host_interface *iface)
 {
@@ -473,8 +473,9 @@ static int parse_audio_format_ii(struct snd_usb_audio *chip,
 	return ret;
 }
 
-int snd_usb_parse_audio_format(struct snd_usb_audio *chip, struct audioformat *fp,
-			       int format, struct uac_format_type_i_continuous_descriptor *fmt,
+int snd_usb_parse_audio_format(struct snd_usb_audio *chip,
+			       struct audioformat *fp, unsigned int format,
+			       struct uac_format_type_i_continuous_descriptor *fmt,
 			       int stream, struct usb_host_interface *iface)
 {
 	int err;
diff --git a/sound/usb/format.h b/sound/usb/format.h
index 387924f..6f31522 100644
--- a/sound/usb/format.h
+++ b/sound/usb/format.h
@@ -2,7 +2,7 @@
 #define __USBAUDIO_FORMAT_H
 
 int snd_usb_parse_audio_format(struct snd_usb_audio *chip,
-			       struct audioformat *fp, int format,
+			       struct audioformat *fp, unsigned int format,
 			       struct uac_format_type_i_continuous_descriptor *fmt,
 			       int stream, struct usb_host_interface *iface);
 
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index ad181d5..ad07046 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -463,7 +463,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 	struct usb_host_interface *alts;
 	struct usb_interface_descriptor *altsd;
 	int i, altno, err, stream;
-	int format = 0, num_channels = 0;
+	unsigned int format = 0, num_channels = 0;
 	struct audioformat *fp = NULL;
 	int num, protocol, clock = 0;
 	struct uac_format_type_i_continuous_descriptor *fmt;
-- 
1.7.10.4
