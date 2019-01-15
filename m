From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/14] ALSA: doc: Update the description about
	PCM suspend procedure
Date: Tue, 15 Jan 2019 17:21:54 +0100
Message-ID: <20190115162155.6308-14-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C914267464
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:58 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The PCM suspend procedure was changed for drivers, so that they don't
have to call snd_pcm_suspend*() in each callback any longer.  Update
the documentation to adapt the changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../kernel-api/writing-an-alsa-driver.rst     | 25 ++++++-------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index b37234afdfa1..7c2f2032d30a 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -3924,15 +3924,12 @@ The scheme of the real suspend job is as follows.
 2. Call :c:func:`snd_power_change_state()` with
    ``SNDRV_CTL_POWER_D3hot`` to change the power status.
 
-3. Call :c:func:`snd_pcm_suspend_all()` to suspend the running
-   PCM streams.
-
-4. If AC97 codecs are used, call :c:func:`snd_ac97_suspend()` for
+3. If AC97 codecs are used, call :c:func:`snd_ac97_suspend()` for
    each codec.
 
-5. Save the register values if necessary.
+4. Save the register values if necessary.
 
-6. Stop the hardware if necessary.
+5. Stop the hardware if necessary.
 
 A typical code would be like:
 
@@ -3946,12 +3943,10 @@ A typical code would be like:
           /* (2) */
           snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
           /* (3) */
-          snd_pcm_suspend_all(chip->pcm);
-          /* (4) */
           snd_ac97_suspend(chip->ac97);
-          /* (5) */
+          /* (4) */
           snd_mychip_save_registers(chip);
-          /* (6) */
+          /* (5) */
           snd_mychip_stop_hardware(chip);
           return 0;
   }
@@ -3994,13 +3989,9 @@ A typical code would be like:
           return 0;
   }
 
-As shown in the above, it's better to save registers after suspending
-the PCM operations via :c:func:`snd_pcm_suspend_all()` or
-:c:func:`snd_pcm_suspend()`. It means that the PCM streams are
-already stopped when the register snapshot is taken. But, remember that
-you don't have to restart the PCM stream in the resume callback. It'll
-be restarted via trigger call with ``SNDRV_PCM_TRIGGER_RESUME`` when
-necessary.
+Note that, at the time this callback gets called, the PCM stream has
+been already suspended via its own PM ops calling
+:c:func:`snd_pcm_suspend_all()` internally.
 
 OK, we have all callbacks now. Let's set them up. In the initialization
 of the card, make sure that you can get the chip data from the card
-- 
2.20.1
