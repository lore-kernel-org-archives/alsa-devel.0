From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sound: fix kernel-doc build warning
Date: Sun, 29 Oct 2017 17:08:52 -0700
Message-ID: <b23981e7-655c-f99e-82cf-0082084774d6@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: moderated for non-subscribers <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc build error. A symbol that ends with an underscore
character ('_') has special meaning in reST (reStructuredText), so add
a '*' to prevent this error and to indicate that there are several of
these values to choose from.

../sound/core/jack.c:312: ERROR: Unknown target name: "snd_jack_btn".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Jaroslav Kysela <perex@perex.cz>
Cc:	Takashi Iwai <tiwai@suse.com>
Cc:	alsa-devel@alsa-project.org
---
 sound/core/jack.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-414-rc7.orig/sound/core/jack.c
+++ lnx-414-rc7/sound/core/jack.c
@@ -310,7 +310,7 @@ EXPORT_SYMBOL(snd_jack_set_parent);
  * @type:    Jack report type for this key
  * @keytype: Input layer key type to be reported
  *
- * Map a SND_JACK_BTN_ button type to an input layer key, allowing
+ * Map a SND_JACK_BTN_* button type to an input layer key, allowing
  * reporting of keys on accessories via the jack abstraction.  If no
  * mapping is provided but keys are enabled in the jack type then
  * BTN_n numeric buttons will be reported.
