From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] sound/core: Convert timers to use timer_setup()
Date: Wed, 4 Oct 2017 17:53:33 -0700
Message-ID: <20171005005333.GA23782@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. This adds a pointer back to struct
snd_timer.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 sound/core/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 6cdd04a45962..09acaf2b2e57 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1028,15 +1028,17 @@ EXPORT_SYMBOL(snd_timer_global_register);
 
 struct snd_timer_system_private {
 	struct timer_list tlist;
+	struct snd_timer *snd_timer;
 	unsigned long last_expires;
 	unsigned long last_jiffies;
 	unsigned long correction;
 };
 
-static void snd_timer_s_function(unsigned long data)
+static void snd_timer_s_function(struct timer_list *t)
 {
-	struct snd_timer *timer = (struct snd_timer *)data;
-	struct snd_timer_system_private *priv = timer->private_data;
+	struct snd_timer_system_private *priv = from_timer(priv, t,
+								tlist);
+	struct snd_timer *timer = priv->snd_timer;
 	unsigned long jiff = jiffies;
 	if (time_after(jiff, priv->last_expires))
 		priv->correction += (long)jiff - (long)priv->last_expires;
@@ -1118,7 +1120,8 @@ static int snd_timer_register_system(void)
 		snd_timer_free(timer);
 		return -ENOMEM;
 	}
-	setup_timer(&priv->tlist, snd_timer_s_function, (unsigned long) timer);
+	priv->snd_timer = timer;
+	timer_setup(&priv->tlist, snd_timer_s_function, 0);
 	timer->private_data = priv;
 	timer->private_free = snd_timer_free_system;
 	return snd_timer_global_register(timer);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
