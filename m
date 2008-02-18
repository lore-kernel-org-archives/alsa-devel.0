From: "George Spelvin" <linux@horizon.com>
Subject: Re: 2.6.25-rc2 compile error: 'OPL3_PATCH_HASH_SIZE'
	undeclared
Date: Sun, 17 Feb 2008 22:04:47 -0500
Message-ID: <20080218030447.1147.qmail@science.horizon.com>
References: <20080218015816.32301.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from science.horizon.com (science.horizon.com [192.35.100.1])
	by alsa0.perex.cz (Postfix) with SMTP id 40CA42443E
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 04:04:48 +0100 (CET)
In-Reply-To: <20080218015816.32301.qmail@science.horizon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux@horizon.com
List-Id: alsa-devel@alsa-project.org

In case it helps, here's a patch that at least compiles.  It still leaves
the declarations in the headers, so you might want to reorganize it.
I'm not sure if the reference to CONFIG_SND_SEQUENCER_MODULE is actually
required; doesn't that imply CONFIG_SND_SEQUENCER?


diff --git a/sound/drivers/opl3/opl3_synth.c b/sound/drivers/opl3/opl3_synth.c
index a7bf7a4..2c0a8fd 100644
--- a/sound/drivers/opl3/opl3_synth.c
+++ b/sound/drivers/opl3/opl3_synth.c
@@ -178,6 +178,8 @@ int snd_opl3_release(struct snd_hwdep * hw, struct file *file)
 	return 0;
 }
 
+#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
+
 /*
  * write the device - load patches
  */
@@ -341,6 +343,25 @@ void snd_opl3_clear_patches(struct snd_opl3 *opl3)
 	}
 	memset(opl3->patch_table, 0, sizeof(opl3->patch_table));
 }
+#else /* SND_SEQUENCER not configured */
+
+/* Stub functions to avoid #ifdef in opl3_lib.c */
+long snd_opl3_write(struct snd_hwdep *hw, const char __user *buf, long count,
+		    loff_t *offset)
+{
+	(void)hw;
+	(void)buf;
+	(void)count;
+	(void)offset;
+	return -ENXIO;
+}
+void snd_opl3_clear_patches(struct snd_opl3 *opl3)
+{
+	(void)opl3;
+}
+
+#endif
+
 
 /* ------------------------------ */
