From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: AK4114 - listing regs in proc - PATCH
Date: Sun, 10 Feb 2008 21:17:08 +0100
Message-ID: <47AF5BC4.9000702@insite.cz>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>	<s5habmdknw0.wl%tiwai@suse.de>	<76366b180802070345u705c1a72ibebb27d909028405@mail.gmail.com>	<s5hhcglynw7.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010509070009040201010209"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A61E10387A
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2008 21:17:19 +0100 (CET)
In-Reply-To: <Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010509070009040201010209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

please find enclosed a simple patch for listing AK4114 regs in proc.

Thanks a lot.

Pavel Hofman.

Signed-off-by: Pavel Hofman <dustin@seznam.cz>

--------------010509070009040201010209
Content-Type: text/x-patch;
 name="patch-ak4114.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ak4114.diff"

diff -r b0d97ac73e0f i2c/other/ak4114.c
--- a/i2c/other/ak4114.c	Fri Jan 25 15:24:50 2008 +0100
+++ b/i2c/other/ak4114.c	Sun Feb 10 21:06:38 2008 +0100
@@ -27,6 +27,7 @@
 #include <sound/pcm.h>
 #include <sound/ak4114.h>
 #include <sound/asoundef.h>
+#include <sound/info.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("AK4114 IEC958 (S/PDIF) receiver by Asahi Kasei");
@@ -445,6 +446,26 @@ static struct snd_kcontrol_new snd_ak411
 	.private_value = (1<<31) | (4<<8) | AK4114_REG_RCS0,
 }
 };
+
+
+static void snd_ak4114_proc_regs_read(struct snd_info_entry *entry,
+		struct snd_info_buffer *buffer)
+{
+	struct ak4114 *ak4114 = (struct ak4114 *)entry->private_data;
+	int reg, val;
+	/* all ak4114 registers 0x00 - 0x1f */
+	for (reg = 0; reg < 0x20; reg++) {
+		val = reg_read(ak4114, reg);
+		snd_iprintf(buffer, "0x%02x = 0x%02x\n", reg, val);
+	}
+}
+
+static void snd_ak4114_proc_init(struct ak4114 *ak4114)
+{
+	struct snd_info_entry *entry;
+	if (!snd_card_proc_new(ak4114->card, "ak4114", &entry))
+		snd_info_set_text_ops(entry, ak4114, snd_ak4114_proc_regs_read);
+}
 
 int snd_ak4114_build(struct ak4114 *ak4114,
 		     struct snd_pcm_substream *ply_substream,
@@ -478,6 +499,7 @@ int snd_ak4114_build(struct ak4114 *ak41
 			return err;
 		ak4114->kctls[idx] = kctl;
 	}
+	snd_ak4114_proc_init(ak4114);
 	/* trigger workq */
 	schedule_delayed_work(&ak4114->work, HZ / 10);
 	return 0;

--------------010509070009040201010209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010509070009040201010209--
