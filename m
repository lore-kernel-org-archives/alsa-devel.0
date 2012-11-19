From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Hung task with trace after resume on kernel
 v3.7-rc6
Date: Mon, 19 Nov 2012 13:15:04 +0100
Message-ID: <20121119131504.71f3151b@ilfaris>
References: <20121118161803.58ca707c@ilfaris>
 <CAEUnVG7bFqrzfVDG5-2uL6OHGEJR-Jf35mx-OLiTx-K84P+dmA@mail.gmail.com>
 <s5h3906gcfe.wl%tiwai@suse.de> <20121119115632.0c41386f@ilfaris>
 <s5hmwydg7mq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id D2E79261676
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 13:15:07 +0100 (CET)
In-Reply-To: <s5hmwydg7mq.wl%tiwai@suse.de>
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
Cc: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Could you try the patch below instead?
The patch did not apply against 3.7-rc6 but the patch below applied and
let the trace disappear.

> > By the way, it seems like I get the traces every 120 seconds and not
> > only once, forgot to mention that earlier.
> 
> The spurious call (or no proper reply for the verb) indicates that
> either the HD-audio controller or the HD-audio codec stalls.  Is yours
> a machine with a discrete GPU?  If so, and if you are using
> vga-switcheroo or anything manipulating the D-GPU, it's possibly the
> cause of the stall.
I just have an AMD-450 APU (an onboard GPU) with no vga-switcheroo or
other things involved.


With best regards,
Julian Wollrath

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 70d4848..cebe2dfd 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -228,7 +228,7 @@ static int codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
 	}
 	mutex_unlock(&bus->cmd_mutex);
 	snd_hda_power_down(codec);
-	if (res && *res == -1 && bus->rirb_error) {
+	if (!codec->in_pm && res && *res == -1 && bus->rirb_error) {
 		if (bus->response_reset) {
 			snd_printd("hda_codec: resetting BUS due to "
 				   "fatal communication error\n");
@@ -238,7 +238,7 @@ static int codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
 		goto again;
 	}
 	/* clear reset-flag when the communication gets recovered */
-	if (!err)
+	if (!err || codec->in_pm)
 		bus->response_reset = 0;
 	return err;
 }
@@ -3616,6 +3616,8 @@ static unsigned int hda_call_codec_suspend(struct hda_codec *codec, bool in_wq)
 {
 	unsigned int state;
 
+	codec->in_pm = 1;
+
 	if (codec->patch_ops.suspend)
 		codec->patch_ops.suspend(codec);
 	hda_cleanup_all_streams(codec);
@@ -3630,6 +3632,7 @@ static unsigned int hda_call_codec_suspend(struct hda_codec *codec, bool in_wq)
 	codec->power_transition = 0;
 	codec->power_jiffies = jiffies;
 	spin_unlock(&codec->power_lock);
+	codec->in_pm = 0;
 	return state;
 }
 
@@ -3638,6 +3641,8 @@ static unsigned int hda_call_codec_suspend(struct hda_codec *codec, bool in_wq)
  */
 static void hda_call_codec_resume(struct hda_codec *codec)
 {
+	codec->in_pm = 1;
+
 	/* set as if powered on for avoiding re-entering the resume
 	 * in the resume / power-save sequence
 	 */
@@ -3656,6 +3661,8 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 		snd_hda_codec_resume_cache(codec);
 	}
 	snd_hda_jack_report_sync(codec);
+
+	codec->in_pm = 0;
 	snd_hda_power_down(codec); /* flag down before returning */
 }
 #endif /* CONFIG_PM */
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 507fe8a..4f4e545 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -869,6 +869,7 @@ struct hda_codec {
 	unsigned int power_on :1;	/* current (global) power-state */
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
 	unsigned int pm_down_notified:1; /* PM notified to controller */
+	unsigned int in_pm:1;		/* suspend/resume being performed */
 	int power_transition;	/* power-state in transition */
 	int power_count;	/* current (global) power refcount */
 	struct delayed_work power_work; /* delayed task for powerdown */
