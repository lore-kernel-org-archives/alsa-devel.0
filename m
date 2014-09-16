From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH RFC 0/7] Allow multiple callbacks for
	hda_jack
Date: Tue, 16 Sep 2014 10:33:30 +0200
Message-ID: <5417F5DA.5050105@canonical.com>
References: <1410445157-23198-1-git-send-email-tiwai@suse.de>	<5411BC38.5020503@canonical.com>	<s5hr3zdw9zm.wl-tiwai@suse.de>
 <s5hsijtulpz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070201020906040601090500"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 930CE2658B3
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 10:33:30 +0200 (CEST)
In-Reply-To: <s5hsijtulpz.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070201020906040601090500
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 2014-09-15 14:11, Takashi Iwai wrote:
> At Mon, 15 Sep 2014 10:42:21 +0200,
> Takashi Iwai wrote:
>>
>> At Thu, 11 Sep 2014 17:14:00 +0200,
>> David Henningsson wrote:
>>>
>>>
>>>
>>> On 2014-09-11 16:19, Takashi Iwai wrote:
>>>> Hi,
>>>>
>>>> this is a series of patches I quickly cooked up after the discussion
>>>> in this morning: the support of multiple callbacks per jack.
>>>>
>>>> The series is applied on top of the previous fix patch (ALSA: hda -
>>>> Fix invalid pin powermap without jack detection).  It begins with
>>>> a couple of cleanups, then introduces the new hda_jack_callback
>>>> struct and the changes along with it, then ends with another
>>>> couple of cleanup patches based on the new infrastructure.
>>>>
>>>> I've tested only with a small set of devices, so far.
>>>
>>> In general I like this idea and I remember thinking along the same lines.
>>>
>>> I'm pondering whether we could use a more memory efficient layout for
>>> the callback list. Like allocating a snd_array on codec level and have
>>> indices to that list instead of pointers. Then the kernel would have
>>> less memory blocks to worry about. What do you think?
>>
>> I don't think the memory usage would be any problem in this case as
>> it's just a few numbers of small blocks.  The only question is which
>> is better manageable in the source code level.  Let's see...
>
> I tried hacking with snd_array, but this ended up more complexity in
> the code (either adding an extra stuff into struct hda_codec or
> obviously more overhead than the simple kmalloc).  So, I decided to
> keep the code as it was.
>
> If you find a better solution, let me know.  In anyway, I'll submit v2
> patches.

The attached version is a quick write-up of what I was thinking. 
(Untested, apply on top of patch 4/7.) Whether its better or worse is a 
matter of taste I suppose - the iterating over the callbacks is a little 
less compact, but OTOH the freeing is slightly simpler, and there are 
also less calls to malloc.

Btw, in your version, the current free in snd_hda_jack_tbl_clear is 
within CONFIG_SND_HDA_INPUT_JACK ifdef. Looks like a memory leak if 
CONFIG_SND_HDA_INPUT_JACK is not defined.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------070201020906040601090500
Content-Type: text/x-patch;
 name="jack.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jack.diff"

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0aa2e1e..5a88776 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1471,6 +1471,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	snd_array_init(&codec->cvt_setups, sizeof(struct hda_cvt_setup), 8);
 	snd_array_init(&codec->spdif_out, sizeof(struct hda_spdif_out), 16);
 	snd_array_init(&codec->jacktbl, sizeof(struct hda_jack_tbl), 16);
+	snd_array_init(&codec->jack_cb_tbl, sizeof(struct hda_jack_callback), 16);
 	snd_array_init(&codec->verbs, sizeof(struct hda_verb *), 8);
 	INIT_LIST_HEAD(&codec->conn_list);
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 9c8820f..746cb7c 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -390,6 +390,7 @@ struct hda_codec {
 
 	/* jack detection */
 	struct snd_array jacktbl;
+	struct snd_array jack_cb_tbl;
 	unsigned long jackpoll_interval; /* In jiffies. Zero means no poll, rely on unsol events */
 	struct delayed_work jackpoll_work;
 
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index cbaa5bf..9336f41 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -105,6 +105,7 @@ snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid)
 		return NULL;
 	jack->nid = nid;
 	jack->jack_dirty = 1;
+	jack->callback_idx = -1;
 	jack->tag = codec->jacktbl.used;
 	return jack;
 }
@@ -118,17 +119,13 @@ void snd_hda_jack_tbl_clear(struct hda_codec *codec)
 		struct hda_jack_tbl *jack = codec->jacktbl.list;
 		int i;
 		for (i = 0; i < codec->jacktbl.used; i++, jack++) {
-			struct hda_jack_callback *cb, *next;
 			if (jack->jack)
 				snd_device_free(codec->bus->card, jack->jack);
-			for (cb = jack->callback; cb; cb = next) {
-				next = cb->next;
-				kfree(cb);
-			}
 		}
 	}
 #endif
 	snd_array_free(&codec->jacktbl);
+	snd_array_free(&codec->jack_cb_tbl);
 }
 
 #define get_jack_plug_state(sense) !!(sense & AC_PINSENSE_PRESENCE)
@@ -237,13 +234,13 @@ snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 	if (!jack)
 		return ERR_PTR(-ENOMEM);
 	if (func) {
-		callback = kzalloc(sizeof(*callback), GFP_KERNEL);
+		callback = snd_array_new(&codec->jack_cb_tbl);
 		if (!callback)
 			return ERR_PTR(-ENOMEM);
 		callback->func = func;
 		callback->tbl = jack;
-		callback->next = jack->callback;
-		jack->callback = callback;
+		callback->next = jack->callback_idx;
+		jack->callback_idx = snd_array_index(&codec->jack_cb_tbl, callback);
 	}
 
 	if (jack->jack_detect)
@@ -519,16 +516,24 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_add_kctls);
 static void call_jack_callback(struct hda_codec *codec,
 			       struct hda_jack_tbl *jack)
 {
+	int cb_idx = jack->callback_idx;
 	struct hda_jack_callback *cb;
 
-	for (cb = jack->callback; cb; cb = cb->next)
+	while (cb_idx != -1) {
+		cb = snd_array_elem(&codec->jack_cb_tbl, cb_idx);
 		cb->func(codec, cb);
+		cb_idx = cb->next;
+	}
 	if (jack->gated_jack) {
 		struct hda_jack_tbl *gated =
 			snd_hda_jack_tbl_get(codec, jack->gated_jack);
 		if (gated) {
-			for (cb = gated->callback; cb; cb = cb->next)
+			cb_idx = gated->callback_idx;
+			while (cb_idx != -1) {
+				cb = snd_array_elem(&codec->jack_cb_tbl, cb_idx);
 				cb->func(codec, cb);
+				cb_idx = cb->next;
+			}
 		}
 	}
 }
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 2784cf5..c634f4e 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -22,13 +22,13 @@ struct hda_jack_callback {
 	struct hda_jack_tbl *tbl;
 	hda_jack_callback_fn func;
 	unsigned int private_data;	/* arbitrary data */
-	struct hda_jack_callback *next;
+	int next;
 };
 
 struct hda_jack_tbl {
 	hda_nid_t nid;
 	unsigned char tag;		/* unsol event tag */
-	struct hda_jack_callback *callback;
+	int callback_idx;
 	/* jack-detection stuff */
 	unsigned int pin_sense;		/* cached pin-sense value */
 	unsigned int jack_detect:1;	/* capable of jack-detection? */

--------------070201020906040601090500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070201020906040601090500--
