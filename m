From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] sound: oss: fix build warning
Date: Thu, 14 May 2015 16:42:59 +0530
Message-ID: <1431601979-24852-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

while building with allyesconfig it was giving a build warning about
unused variable. declare the variable only if the driver is built as a
module.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

build tested with allyesconfig and allmodconfig

 sound/oss/ad1848.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index ec1ee07..10c8de1 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -2860,6 +2860,7 @@ static struct {
 	{NULL}
 };
 
+#ifdef MODULE
 static struct isapnp_device_id id_table[] = {
 	{	ISAPNP_VENDOR('C','M','I'), ISAPNP_DEVICE(0x0001),
 		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001), 0 },
@@ -2877,6 +2878,7 @@ static struct isapnp_device_id id_table[] = {
 };
 
 MODULE_DEVICE_TABLE(isapnp, id_table);
+#endif
 
 static struct pnp_dev *activate_dev(char *devname, char *resname, struct pnp_dev *dev)
 {
-- 
1.8.1.2
