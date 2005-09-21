From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [alsa-lib patch] New @func - pcm_args_by_class
Date: Wed, 21 Sep 2005 23:58:34 +0300
Message-ID: <20050921205834.GA20158@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

This patch adds new run-time function 'pcm_args_by_class' for using in
configuration files. This returns "CARD=N,DEV=M" formatted string for
correspondent pcm device specified by class value and (absolute) index.
In other words this helps to represent pcm devices as plain (card, dev
independent) list for each pcm class.

Then we could define 'phoneline/modem' devices like this (example is not
tested):


pcm.hwmodem {
	@args [ CARD DEV ]
	....
	@func refer
	name {
		@func concat
		strings [
			"cards."
			{
				@func card_driver
				card $CARD
			}
			".pcm.modem." $DEV ":CARD=" $CARD
		]
	}
}

pcm.modem {
	@args [ INDEX ]
	....
	@func refer 
	name {
		@func concat
		strings [
			"pcm.hwmodem:"
			{
				@func pcm_args_by_class
				class 2
				index $INDEX
			}
		]
	}
}


Here "modem:0" will refer first available modem pcm device ("hw:1,0" in
most cases), etc..

With today's configuration card,device should be specified explicitly
(modem:1,0), and default (modem:0,0) is useless and refers pure audio pcm.

Of course the same could be applied for other pcm classes and then any
order of hw pcm devices could be mapped by those purposes (classes)
properly.

Ideas?

Sasha.


New 'pcm_args_by_class' @func available for using in configuration files.
Returns card, device args list formatted as "CARD=N,DEV=M" by specified
pcm class and index.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-lib/src/confmisc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/confmisc.c,v
retrieving revision 1.34
diff -u -p -r1.34 confmisc.c
--- alsa-lib/src/confmisc.c	30 May 2005 11:16:20 -0000	1.34
+++ alsa-lib/src/confmisc.c	21 Sep 2005 15:39:43 -0000
@@ -854,6 +854,123 @@ SND_DLSYM_BUILD_VERSION(snd_func_pcm_id,
 #endif
 
 /**
+ * \brief Returns the pcm card and device arguments (in form CARD=N,DEV=M)
+ *                for pcm specified by class and index.
+ * \param dst The function puts the handle to the result configuration node
+ *            (with type string) at the address specified by \p dst.
+ * \param root Handle to the root source node.
+ * \param src Handle to the source node, with definitions for \c class
+ *            and \c index.
+ * \param private_data Handle to the \c private_data node.
+ * \return A non-negative value if successful, otherwise a negative error code.
+ *
+ * Example:
+\code
+	{
+		@func pcm_args_by_class
+		class 0
+		index 0
+	}
+\endcode
+ */ 
+int snd_func_pcm_args_by_class(snd_config_t **dst, snd_config_t *root, snd_config_t *src, void *private_data)
+{
+	snd_config_t *n;
+	snd_ctl_t *ctl = NULL;
+	snd_pcm_info_t *info;
+	const char *id;
+	int card = -1, dev;
+	long class, index;
+	int idx = 0;
+	int err;
+
+	err = snd_config_search(src, "class", &n);
+	if (err < 0) {
+		SNDERR("field class not found");
+		goto __out;
+	}
+	err = snd_config_evaluate(n, root, private_data, NULL);
+	if (err < 0) {
+		SNDERR("error evaluating class");
+		goto __out;
+	}
+	err = snd_config_get_integer(n, &class);
+	if (err < 0) {
+		SNDERR("field class is not an integer");
+		goto __out;
+	}
+	err = snd_config_search(src, "index", &n);
+	if (err < 0) {
+		SNDERR("field index not found");
+		goto __out;
+	}
+	err = snd_config_evaluate(n, root, private_data, NULL);
+	if (err < 0) {
+		SNDERR("error evaluating index");
+		goto __out;
+	}
+	err = snd_config_get_integer(n, &index);
+	if (err < 0) {
+		SNDERR("field index is not an integer");
+		goto __out;
+	}
+
+	snd_pcm_info_alloca(&info);
+	while(1) {
+		err = snd_card_next(&card);
+		if (err < 0) {
+			SNDERR("could not get next card");
+			goto __out;
+		}
+		if (card < 0)
+			break;
+		err = open_ctl(card, &ctl);
+		if (err < 0) {
+			SNDERR("could not open control for card %li", card);
+			goto __out;
+		}
+		dev = -1;
+		memset(info, 0, snd_pcm_info_sizeof());
+		while(1) {
+			err = snd_ctl_pcm_next_device(ctl, &dev);
+			if (err < 0) {
+				SNDERR("could not get next pcm for card %li", card);
+				goto __out;
+			}
+			if (dev < 0)
+				break;
+			snd_pcm_info_set_device(info, dev);
+			err = snd_ctl_pcm_info(ctl, info);
+			if (err < 0)
+				continue;
+			if (snd_pcm_info_get_class(info) == (snd_pcm_class_t)class &&
+					index == idx++)
+				goto __out;
+		}
+      		snd_ctl_close(ctl);
+		ctl = NULL;
+	}
+	err = -ENODEV;
+
+      __out:
+      	if (ctl)
+      		snd_ctl_close(ctl);
+	if (err < 0)
+		return err;
+	if((err = snd_config_get_id(src, &id)) >= 0) {
+		char name[32], *s;
+		snprintf(name, sizeof(name), "CARD=%i,DEV=%i", card, dev);
+		if (!(s = strdup(name)))
+			return -ENOMEM;
+		err = snd_config_imake_string(dst, id, s);
+	}
+	return err;
+}
+#ifndef DOC_HIDDEN
+SND_DLSYM_BUILD_VERSION(snd_func_pcm_args_by_class, SND_CONFIG_DLSYM_VERSION_EVALUATE);
+#endif
+
+/**
  * \brief Returns the PCM subdevice from \c private_data.
  * \param dst The function puts the handle to the result configuration node
  *            (with type integer) at the address specified by \p dst.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
