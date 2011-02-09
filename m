From: Pierre-Louis Bossart <bossart.nospam@gmail.com>
Subject: [PATCH] ALSA: usb - prevent kernel panic on disconnect
Date: Wed,  9 Feb 2011 13:13:24 -0600
Message-ID: <1297278804-21011-1-git-send-email-pierre-louis.bossart@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FAD410398F
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 20:14:56 +0100 (CET)
Received: by yib12 with SMTP id 12so254238yib.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2011 11:14:53 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sarah.a.sharp@linux.intel.com, bossart.nospam@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Fix 100% reproducible kernel panic when a USB audio device is
disconnected during playback. When the PCM substream is NULL, any
dereference causes a kernel panic. This isn't a recent problem, the crash
happened with a 2.6.35 kernel as well

Note that this is only a work-around, it does not address the
root cause of this inconsistency between urbs and PCM states. The
dmesg below shows two calls to snd_urb_complete, the substream is
NULL and the state is either running or stopped. This doesn't make
any sense.

Thanks to Sarah Sharp <sarah.a.sharp@linux.intel.com> for her
help.

usb 6-1: USB disconnect, address 16
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:186: NULL substream (subs->running 1) <- How is this possible?
ALSA urb.c:186: NULL substream (subs->running 0)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
---
 usb/urb.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/usb/urb.c b/usb/urb.c
index e184349..1a264c2 100644
--- a/usb/urb.c
+++ b/usb/urb.c
@@ -170,6 +170,12 @@ static void snd_complete_urb(struct urb *urb)
 	struct snd_pcm_substream *substream = ctx->subs->pcm_substream;
 	int err = 0;
 
+        if (substream == NULL) {
+                snd_printd(KERN_ERR "NULL substream (subs->running %d)\n", subs->running);
+                clear_bit(ctx->index, &subs->active_mask);
+                return;
+        }
+
 	if ((subs->running && subs->ops.retire(subs, substream->runtime, urb)) ||
 	    !subs->running || /* can be stopped during retire callback */
 	    (err = subs->ops.prepare(subs, substream->runtime, urb)) < 0 ||
@@ -193,6 +199,12 @@ static void snd_complete_sync_urb(struct urb *urb)
 	struct snd_pcm_substream *substream = ctx->subs->pcm_substream;
 	int err = 0;
 
+        if (substream == NULL) {
+                snd_printd(KERN_ERR "NULL substream (subs->running %d)\n", subs->running);
+                clear_bit(ctx->index + 16, &subs->active_mask);
+                return;
+        }
+
 	if ((subs->running && subs->ops.retire_sync(subs, substream->runtime, urb)) ||
 	    !subs->running || /* can be stopped during retire callback */
 	    (err = subs->ops.prepare_sync(subs, substream->runtime, urb)) < 0 ||
-- 
1.7.4
