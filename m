From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/24] ALSA: Mandate to pass a device pointer
	at card creation time
Date: Wed, 12 Feb 2014 11:35:18 +0100
Message-ID: <1392201340-27113-3-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B4069264F8D
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7C327ABF8
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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

This is a part of preliminary works for modernizing the ALSA device
structure.  So far, we set card->dev at later point after the object
creation.  Because of this, the core layer doesn't always know which
device is being handled before it's actually registered, and it makes
impossible to show the device in error messages, for example.  The
first goal is to achieve a proper struct device initialization at the
very beginning of probing.

As a first step, this patch introduces snd_card_new() function (yes
there was the same named function in the very past), in order to
receive the parent device pointer from the very beginning.
snd_card_create() is marked as deprecated.

At this point, there is no functional change other than that.  The
actual change of the device creation scheme will follow later.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/DocBook/writing-an-alsa-driver.tmpl | 72 +++++++++--------------
 include/sound/core.h                              | 13 +++-
 sound/core/init.c                                 |  8 ++-
 3 files changed, 42 insertions(+), 51 deletions(-)

diff --git a/Documentation/DocBook/writing-an-alsa-driver.tmpl b/Documentation/DocBook/writing-an-alsa-driver.tmpl
index 06741e925985..d0056a4e9c53 100644
--- a/Documentation/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/DocBook/writing-an-alsa-driver.tmpl
@@ -468,8 +468,6 @@
                   return err;
           }
 
-          snd_card_set_dev(card, &pci->dev);
-
           *rchip = chip;
           return 0;
   }
@@ -492,7 +490,8 @@
           }
 
           /* (2) */
-          err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+          err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+                             0, &card);
           if (err < 0)
                   return err;
 
@@ -591,7 +590,8 @@
   struct snd_card *card;
   int err;
   ....
-  err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+  err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+                     0, &card);
 ]]>
             </programlisting>
           </informalexample>
@@ -809,28 +809,34 @@
 
       <para>
         As mentioned above, to create a card instance, call
-      <function>snd_card_create()</function>.
+      <function>snd_card_new()</function>.
 
         <informalexample>
           <programlisting>
 <![CDATA[
   struct snd_card *card;
   int err;
-  err = snd_card_create(index, id, module, extra_size, &card);
+  err = snd_card_new(&pci->dev, index, id, module, extra_size, &card);
 ]]>
           </programlisting>
         </informalexample>
       </para>
 
       <para>
-        The function takes five arguments, the card-index number, the
-        id string, the module pointer (usually
+        The function takes six arguments: the parent device pointer,
+        the card-index number, the id string, the module pointer (usually
         <constant>THIS_MODULE</constant>),
         the size of extra-data space, and the pointer to return the
         card instance.  The extra_size argument is used to
         allocate card-&gt;private_data for the
         chip-specific data.  Note that these data
-        are allocated by <function>snd_card_create()</function>.
+        are allocated by <function>snd_card_new()</function>.
+      </para>
+
+      <para>
+	The first argument, the pointer of struct
+	<structname>device</structname>, specifies the parent device.
+	For PCI devices, typically &amp;pci-&gt; is passed there.
       </para>
     </section>
 
@@ -916,16 +922,16 @@
       </para>
 
       <section id="card-management-chip-specific-snd-card-new">
-        <title>1. Allocating via <function>snd_card_create()</function>.</title>
+        <title>1. Allocating via <function>snd_card_new()</function>.</title>
         <para>
           As mentioned above, you can pass the extra-data-length
-	  to the 4th argument of <function>snd_card_create()</function>, i.e.
+	  to the 5th argument of <function>snd_card_new()</function>, i.e.
 
           <informalexample>
             <programlisting>
 <![CDATA[
-  err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-                        sizeof(struct mychip), &card);
+  err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+                     sizeof(struct mychip), &card);
 ]]>
             </programlisting>
           </informalexample>
@@ -954,7 +960,7 @@
 
         <para>
           After allocating a card instance via
-          <function>snd_card_create()</function> (with
+          <function>snd_card_new()</function> (with
           <constant>0</constant> on the 4th arg), call
           <function>kzalloc()</function>. 
 
@@ -963,7 +969,8 @@
 <![CDATA[
   struct snd_card *card;
   struct mychip *chip;
-  err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+  err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+                     0, &card);
   .....
   chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 ]]>
@@ -1170,8 +1177,6 @@
                   return err;
           }
 
-          snd_card_set_dev(card, &pci->dev);
-
           *rchip = chip;
           return 0;
   }        
@@ -1526,30 +1531,6 @@
 
     </section>
 
-    <section id="pci-resource-device-struct">
-      <title>Registration of Device Struct</title>
-      <para>
-	At some point, typically after calling <function>snd_device_new()</function>,
-	you need to register the struct <structname>device</structname> of the chip
-	you're handling for udev and co.  ALSA provides a macro for compatibility with
-	older kernels.  Simply call like the following:
-        <informalexample>
-          <programlisting>
-<![CDATA[
-  snd_card_set_dev(card, &pci->dev);
-]]>
-          </programlisting>
-        </informalexample>
-	so that it stores the PCI's device pointer to the card.  This will be
-	referred by ALSA core functions later when the devices are registered.
-      </para>
-      <para>
-	In the case of non-PCI, pass the proper device struct pointer of the BUS
-	instead.  (In the case of legacy ISA without PnP, you don't have to do
-	anything.)
-      </para>
-    </section>
-
     <section id="pci-resource-entries">
       <title>PCI Entries</title>
       <para>
@@ -5740,7 +5721,8 @@ struct _snd_pcm_runtime {
           struct mychip *chip;
           int err;
           ....
-          err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+          err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+                             0, &card);
           ....
           chip = kzalloc(sizeof(*chip), GFP_KERNEL);
           ....
@@ -5752,7 +5734,7 @@ struct _snd_pcm_runtime {
       </informalexample>
 
 	When you created the chip data with
-	<function>snd_card_create()</function>, it's anyway accessible
+	<function>snd_card_new()</function>, it's anyway accessible
 	via <structfield>private_data</structfield> field.
 
       <informalexample>
@@ -5766,8 +5748,8 @@ struct _snd_pcm_runtime {
           struct mychip *chip;
           int err;
           ....
-          err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-                                sizeof(struct mychip), &card);
+          err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
+                             sizeof(struct mychip), &card);
           ....
           chip = card->private_data;
           ....
diff --git a/include/sound/core.h b/include/sound/core.h
index d0cee2c8c04f..e946b2428ea0 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -283,9 +283,16 @@ int snd_card_locked(int card);
 extern int (*snd_mixer_oss_notify_callback)(struct snd_card *card, int cmd);
 #endif
 
-int snd_card_create(int idx, const char *id,
-		    struct module *module, int extra_size,
-		    struct snd_card **card_ret);
+int snd_card_new(struct device *parent, int idx, const char *xid,
+		 struct module *module, int extra_size,
+		 struct snd_card **card_ret);
+
+static inline int __deprecated
+snd_card_create(int idx, const char *id, struct module *module, int extra_size,
+		struct snd_card **ret)
+{
+	return snd_card_new(NULL, idx, id, module, extra_size, ret);
+}
 
 int snd_card_disconnect(struct snd_card *card);
 int snd_card_free(struct snd_card *card);
diff --git a/sound/core/init.c b/sound/core/init.c
index a16d765cdf47..f4d3ac633ff8 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -157,7 +157,8 @@ static int get_slot_from_bitmask(int mask, int (*check)(struct module *, int),
 }
 
 /**
- *  snd_card_create - create and initialize a soundcard structure
+ *  snd_card_new - create and initialize a soundcard structure
+ *  @parent: the parent device object
  *  @idx: card index (address) [0 ... (SNDRV_CARDS-1)]
  *  @xid: card identification (ASCII string)
  *  @module: top level module for locking
@@ -172,7 +173,7 @@ static int get_slot_from_bitmask(int mask, int (*check)(struct module *, int),
  *
  *  Return: Zero if successful or a negative error code.
  */
-int snd_card_create(int idx, const char *xid,
+int snd_card_new(struct device *parent, int idx, const char *xid,
 		    struct module *module, int extra_size,
 		    struct snd_card **card_ret)
 {
@@ -213,6 +214,7 @@ int snd_card_create(int idx, const char *xid,
 	if (idx >= snd_ecards_limit)
 		snd_ecards_limit = idx + 1; /* increase the limit */
 	mutex_unlock(&snd_card_mutex);
+	card->dev = parent;
 	card->number = idx;
 	card->module = module;
 	INIT_LIST_HEAD(&card->devices);
@@ -251,7 +253,7 @@ int snd_card_create(int idx, const char *xid,
 	kfree(card);
   	return err;
 }
-EXPORT_SYMBOL(snd_card_create);
+EXPORT_SYMBOL(snd_card_new);
 
 /* return non-zero if a card is already locked */
 int snd_card_locked(int card)
-- 
1.8.5.2
