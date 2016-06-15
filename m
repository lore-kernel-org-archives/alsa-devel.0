From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Change structure initialisation to C99 style
Date: Wed, 15 Jun 2016 18:56:34 +0530
Message-ID: <20160615132634.GA20438@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr, michael.leibowitz@intel.com, keescook@chromium.org
List-Id: alsa-devel@alsa-project.org

Replace the in order struct initialisation style with explicit field
style.

The Coccinelle semantic patch used to make this change is as follows:

@decl@
identifier i1,fld;
type T;
field list[n] fs;
@@

struct i1 {
 fs
 T fld;
 ...};

@@
identifier decl.i1,i2,decl.fld;
expression e;
position bad.p, bad.fix;
@@

struct i1 i2@p = { ...,
+ .fld = e
- e@fix
 ,...};

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 sound/usb/mixer_maps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 1f8fb0d9..9038b2e 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -107,8 +107,10 @@ static struct usbmix_name_map extigy_map[] = {
  * e.g. no Master and fake PCM volume
  *			Pavel Mihaylov <bin@bash.info>
  */
-static struct usbmix_dB_map mp3plus_dB_1 = {-4781, 0};	/* just guess */
-static struct usbmix_dB_map mp3plus_dB_2 = {-1781, 618}; /* just guess */
+static struct usbmix_dB_map mp3plus_dB_1 = {.min = -4781, .max = 0};
+						/* just guess */
+static struct usbmix_dB_map mp3plus_dB_2 = {.min = -1781, .max = 618};
+						/* just guess */
 
 static struct usbmix_name_map mp3plus_map[] = {
 	/* 1: IT pcm */
-- 
1.9.1
