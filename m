From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] create device symlink in snd-aoa
Date: Sat, 2 Dec 2006 11:15:26 +0100 (MET)
Message-ID: <20061202101526.GA15631@aepfle.de>
References: <20061202101445.GA15619@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7436A25C
	for <alsa-devel@alsa-project.org>; Sat,  2 Dec 2006 11:15:27 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20061202101445.GA15619@aepfle.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, johannes@sipsolutions.net
List-Id: alsa-devel@alsa-project.org


create sysfs device symlinks for snd-aoa in /sys/class/sound/controlC0
This allows hald to recognize the device as sound device.
Furthermore it allows the desktop user to actually access the sound 
device nodes. hald and related packages will modify the acl attributes.

Fixes https://bugzilla.novell.com/show_bug.cgi?id=106294

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 sound/aoa/aoa.h                           |    2 +-
 sound/aoa/core/snd-aoa-alsa.c             |    3 ++-
 sound/aoa/core/snd-aoa-alsa.h             |    2 +-
 sound/aoa/core/snd-aoa-core.c             |    4 ++--
 sound/aoa/fabrics/snd-aoa-fabric-layout.c |    2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

Index: linux-2.6/sound/aoa/aoa.h
===================================================================
--- linux-2.6.orig/sound/aoa/aoa.h
+++ linux-2.6/sound/aoa/aoa.h
@@ -99,7 +99,7 @@ struct aoa_fabric {
  * that are not assigned yet are passed to the fabric
  * again for reconsideration. */
 extern int
-aoa_fabric_register(struct aoa_fabric *fabric);
+aoa_fabric_register(struct aoa_fabric *fabric, struct device *dev);
 
 /* it is vital to call this when the fabric exits!
  * When calling, the remove_codec will be called
Index: linux-2.6/sound/aoa/fabrics/snd-aoa-fabric-layout.c
===================================================================
--- linux-2.6.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c
+++ linux-2.6/sound/aoa/fabrics/snd-aoa-fabric-layout.c
@@ -1014,7 +1014,7 @@ static int aoa_fabric_layout_probe(struc
 
 	ldev->gpio.methods->init(&ldev->gpio);
 
-	err = aoa_fabric_register(&layout_fabric);
+	err = aoa_fabric_register(&layout_fabric, &sdev->ofdev.dev);
 	if (err && err != -EALREADY) {
 		printk(KERN_INFO "snd-aoa-fabric-layout: can't use,"
 				 " another fabric is active!\n");
Index: linux-2.6/sound/aoa/core/snd-aoa-alsa.c
===================================================================
--- linux-2.6.orig/sound/aoa/core/snd-aoa-alsa.c
+++ linux-2.6/sound/aoa/core/snd-aoa-alsa.c
@@ -14,7 +14,7 @@ MODULE_PARM_DESC(index, "index for AOA s
 
 static struct aoa_card *aoa_card;
 
-int aoa_alsa_init(char *name, struct module *mod)
+int aoa_alsa_init(char *name, struct module *mod, struct device *dev)
 {
 	struct snd_card *alsa_card;
 	int err;
@@ -28,6 +28,7 @@ int aoa_alsa_init(char *name, struct mod
 		return -ENOMEM;
 	aoa_card = alsa_card->private_data;
 	aoa_card->alsa_card = alsa_card;
+	alsa_card->dev = dev;
 	strlcpy(alsa_card->driver, "AppleOnbdAudio", sizeof(alsa_card->driver));
 	strlcpy(alsa_card->shortname, name, sizeof(alsa_card->shortname));
 	strlcpy(alsa_card->longname, name, sizeof(alsa_card->longname));
Index: linux-2.6/sound/aoa/core/snd-aoa-alsa.h
===================================================================
--- linux-2.6.orig/sound/aoa/core/snd-aoa-alsa.h
+++ linux-2.6/sound/aoa/core/snd-aoa-alsa.h
@@ -10,7 +10,7 @@
 #define __SND_AOA_ALSA_H
 #include "../aoa.h"
 
-extern int aoa_alsa_init(char *name, struct module *mod);
+extern int aoa_alsa_init(char *name, struct module *mod, struct device *dev);
 extern void aoa_alsa_cleanup(void);
 
 #endif /* __SND_AOA_ALSA_H */
Index: linux-2.6/sound/aoa/core/snd-aoa-core.c
===================================================================
--- linux-2.6.orig/sound/aoa/core/snd-aoa-core.c
+++ linux-2.6/sound/aoa/core/snd-aoa-core.c
@@ -82,7 +82,7 @@ void aoa_codec_unregister(struct aoa_cod
 }
 EXPORT_SYMBOL_GPL(aoa_codec_unregister);
 
-int aoa_fabric_register(struct aoa_fabric *new_fabric)
+int aoa_fabric_register(struct aoa_fabric *new_fabric, struct device *dev)
 {
 	struct aoa_codec *c;
 	int err;
@@ -98,7 +98,7 @@ int aoa_fabric_register(struct aoa_fabri
 	if (!new_fabric)
 		return -EINVAL;
 
-	err = aoa_alsa_init(new_fabric->name, new_fabric->owner);
+	err = aoa_alsa_init(new_fabric->name, new_fabric->owner, dev);
 	if (err)
 		return err;
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
