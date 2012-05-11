From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH] usb-audio: Fix comment
Date: Fri, 11 May 2012 18:31:55 +0100
Message-ID: <1336757515-22897-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

Explained by Takashi in <s5hfwbtmz0q.wl%tiwai@suse.de>

> The reason is because get_min_max*() isn't called in the place you
> created these controls, and get_min_max() would be called only for
> integer volumes later even if uninitialized.  A short cut for booleans.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 sound/usb/mixer_quirks.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 12125ca..41f4b69 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -79,16 +79,8 @@ static int snd_create_std_mono_ctl(struct usb_mixer_interface *mixer,
 	cval->control = control;
 	cval->cmask = cmask;
 
-	/* FIXME: Do we need this?
-	 * The following values are for compatibility with
-	 * Ebox-44 mixer.
-	 * But the corresponding ebox-44 function says:
-	 *    "Volume controls will override these values"
-	 *
-	 * These values don't have any effect at all for
-	 * M-Audio FTUs.
-	 * So I think, we can safely omit the range settings here.
-	 */
+	/* get_min_max() is called only for integer volumes later,
+	 * so provide a short-cut for booleans */
 	cval->min = 0;
 	cval->max = 1;
 	cval->res = 0;
-- 
1.7.4.4
