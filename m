From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/30] ALSA: doc: ReSTize powersave document
Date: Thu, 10 Nov 2016 22:06:21 +0100
Message-ID: <20161110210641.5907-11-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BEA02673C1
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:55 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B65ABADE8
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:53 +0000 (UTC)
In-Reply-To: <20161110210641.5907-1-tiwai@suse.de>
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

A simple conversion from a text file.
Put into designs subdirectory, although it's mostly relevant with
HD-audio.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/designs/index.rst                    |  1 +
 .../sound/{alsa/powersave.txt => designs/powersave.rst}  | 16 +++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)
 rename Documentation/sound/{alsa/powersave.txt => designs/powersave.rst} (76%)

diff --git a/Documentation/sound/designs/index.rst b/Documentation/sound/designs/index.rst
index 82d19fe3c380..362e1c23d51f 100644
--- a/Documentation/sound/designs/index.rst
+++ b/Documentation/sound/designs/index.rst
@@ -5,3 +5,4 @@ Designs and Implementations
    :maxdepth: 2
 
    procfile
+   powersave
diff --git a/Documentation/sound/alsa/powersave.txt b/Documentation/sound/designs/powersave.rst
similarity index 76%
rename from Documentation/sound/alsa/powersave.txt
rename to Documentation/sound/designs/powersave.rst
index 9657e8099228..138157452eb9 100644
--- a/Documentation/sound/alsa/powersave.txt
+++ b/Documentation/sound/designs/powersave.rst
@@ -1,9 +1,10 @@
+==========================
 Notes on Power-Saving Mode
 ==========================
 
 AC97 and HD-audio drivers have the automatic power-saving mode.
-This feature is enabled via Kconfig CONFIG_SND_AC97_POWER_SAVE
-and CONFIG_SND_HDA_POWER_SAVE options, respectively.
+This feature is enabled via Kconfig ``CONFIG_SND_AC97_POWER_SAVE``
+and ``CONFIG_SND_HDA_POWER_SAVE`` options, respectively.
 
 With the automatic power-saving, the driver turns off the codec power
 appropriately when no operation is required.  When no applications use
@@ -11,20 +12,21 @@ the device and/or no analog loopback is set, the power disablement is
 done fully or partially.  It'll save a certain power consumption, thus
 good for laptops (even for desktops).
 
-The time-out for automatic power-off can be specified via power_save
+The time-out for automatic power-off can be specified via ``power_save``
 module option of snd-ac97-codec and snd-hda-intel modules.  Specify
 the time-out value in seconds.  0 means to disable the automatic
 power-saving.  The default value of timeout is given via
-CONFIG_SND_AC97_POWER_SAVE_DEFAULT and
-CONFIG_SND_HDA_POWER_SAVE_DEFAULT Kconfig options.  Setting this to 1
+``CONFIG_SND_AC97_POWER_SAVE_DEFAULT`` and
+``CONFIG_SND_HDA_POWER_SAVE_DEFAULT`` Kconfig options.  Setting this to 1
 (the minimum value) isn't recommended because many applications try to
 reopen the device frequently.  10 would be a good choice for normal
 operations.
 
-The power_save option is exported as writable.  This means you can
+The ``power_save`` option is exported as writable.  This means you can
 adjust the value via sysfs on the fly.  For example, to turn on the
 automatic power-save mode with 10 seconds, write to
-/sys/modules/snd_ac97_codec/parameters/power_save (usually as root):
+``/sys/modules/snd_ac97_codec/parameters/power_save`` (usually as root):
+::
 
 	# echo 10 > /sys/modules/snd_ac97_codec/parameters/power_save
 
-- 
2.10.2
