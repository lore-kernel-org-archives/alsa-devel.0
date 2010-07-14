From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH] Kconfig: SND_AC97_POWER_SAVE description
	improvement
Date: Wed, 14 Jul 2010 23:54:21 +0000
Message-ID: <1279192374-7190-1-git-send-email-mfwitten@gmail.com>
References: <1279153142-3114-1-git-send-email-mfwitten@gmail.com>
	<alpine.LNX.2.00.1007150935280.4741@pobox.suse.cz>
	<s5hk4ox2lp5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CE2F7103803
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 13:40:59 +0200 (CEST)
Received: by bwz4 with SMTP id 4so545431bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 04:40:59 -0700 (PDT)
In-Reply-To: <s5hk4ox2lp5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: iri Kosina <jkosina@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The description has been expanded to explain the time-out
value provided by the power_save module parameter.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 sound/drivers/Kconfig |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 84714a6..3264600 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -170,9 +170,25 @@ config SND_AC97_POWER_SAVE
 	  AC97 codecs.  In this mode, the power-mode is dynamically
 	  controlled at each open/close.
 
-	  The mode is activated by passing power_save=1 option to
-	  snd-ac97-codec driver.  You can toggle it dynamically over
-	  sysfs, too.
+	  The mode is activated by passing 'power_save=X' to the
+	  snd-ac97-codec driver module, where 'X' is the time-out
+	  value, a nonnegative integer that specifies how many
+	  seconds of idle time the driver must count before it may
+	  put the AC97 into power-save mode;  a value of 0 (zero)
+	  disables the use of this power-save mode.
+
+	  After the snd-ac97-codec driver module has been loaded,
+	  the 'power_save' parameter can be set via sysfs as follows:
+
+	    echo 10 > /sys/module/snd_ac97_codec/parameters/power_save
+
+	  In this case, the time-out is set to 10 seconds; setting
+	  the time-out to 1 second (the minimum activation value)
+	  isn't recommended because many applications try to reopen
+	  the device frequently.  A value of 10 seconds would be a
+	  good choice for normal operations.
+
+	  See Documentation/sound/alsa/powersave.txt for more details.
 
 config SND_AC97_POWER_SAVE_DEFAULT
 	int "Default time-out for AC97 power-save mode"
@@ -182,4 +198,6 @@ config SND_AC97_POWER_SAVE_DEFAULT
 	  The default time-out value in seconds for AC97 automatic
 	  power-save mode.  0 means to disable the power-save mode.
 
+	  See SND_AC97_POWER_SAVE for more details.
+
 endif	# SND_DRIVERS
-- 
1.7.2.rc1.9.g5b527
