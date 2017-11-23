From: Jens Verwiebe <info@jensverwiebe.de>
Subject: Re: Focusrite Scarlett 6i6 gen1 - input handling fix
Date: Thu, 23 Nov 2017 12:59:29 +0100
Message-ID: <d8c83f1a-13d1-b600-681c-3c83eb374953@jensverwiebe.de>
References: <c306e7cf-6d8c-542d-bd51-66a92d17445a@jensverwiebe.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------0714C6E25815FCF1ED400B61"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id A4BD1266DF5
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 12:59:36 +0100 (CET)
Received: from [192.168.178.21] ([85.179.205.209]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MEKbo-1eONbj3stc-00FPKt for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017
 12:59:36 +0100
In-Reply-To: <c306e7cf-6d8c-542d-bd51-66a92d17445a@jensverwiebe.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------0714C6E25815FCF1ED400B61
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Ups, cleanup own indentation/formatting mistake.

Signed-off-by: Jens Verwiebe <info@jensverwiebe.de>



--------------0714C6E25815FCF1ED400B61
Content-Type: text/x-patch;
 name="scarlett6i6rev1_gain.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="scarlett6i6rev1_gain.patch"

diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 7438e7c..2c86d595 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -152,6 +152,7 @@ enum {
 	SCARLETT_OUTPUTS,
 	SCARLETT_SWITCH_IMPEDANCE,
 	SCARLETT_SWITCH_PAD,
+	SCARLETT_SWITCH_GAIN,
 };
 
 enum {
@@ -202,6 +203,15 @@ struct scarlett_device_info {
 	}
 };
 
+static const struct scarlett_mixer_elem_enum_info opt_gain = {
+	.start = 0,
+	.len = 2,
+	.offsets = {},
+	.names = (char const * const []){
+		"Lo", "Hi"
+	}
+};
+
 static const struct scarlett_mixer_elem_enum_info opt_impedance = {
 	.start = 0,
 	.len = 2,
@@ -664,8 +674,8 @@ static int add_output_ctls(struct usb_mixer_interface *mixer,
 		{ .num = 1, .type = SCARLETT_SWITCH_PAD, .name = NULL},
 		{ .num = 2, .type = SCARLETT_SWITCH_IMPEDANCE, .name = NULL},
 		{ .num = 2, .type = SCARLETT_SWITCH_PAD, .name = NULL},
-		{ .num = 3, .type = SCARLETT_SWITCH_PAD, .name = NULL},
-		{ .num = 4, .type = SCARLETT_SWITCH_PAD, .name = NULL},
+		{ .num = 3, .type = SCARLETT_SWITCH_GAIN, .name = NULL},
+		{ .num = 4, .type = SCARLETT_SWITCH_GAIN, .name = NULL},
 	},
 
 	.matrix_mux_init = {
@@ -895,6 +905,15 @@ static int scarlett_controls_create_generic(struct usb_mixer_interface *mixer,
 			if (err < 0)
 				return err;
 			break;
+		case SCARLETT_SWITCH_GAIN:
+			sprintf(mx, "Input %d Gain Switch", ctl->num);
+			err = add_new_ctl(mixer, &usb_scarlett_ctl_enum,
+					  scarlett_ctl_enum_resume, 0x01,
+					  0x08, ctl->num, USB_MIXER_S16, 1, mx,
+					  &opt_gain, &elem);
+			if (err < 0)
+				return err;
+			break;
 		}
 	}
 

--------------0714C6E25815FCF1ED400B61
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------0714C6E25815FCF1ED400B61--
