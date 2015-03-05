From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH v2 1/2] ucm: reformat snd_use_case_get() doc
Date: Thu,  5 Mar 2015 14:51:57 +0200
Message-ID: <1425559918-23075-2-git-send-email-tanu.kaskinen@linux.intel.com>
References: <1425559918-23075-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 76F5026047B
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 13:52:03 +0100 (CET)
In-Reply-To: <1425559918-23075-1-git-send-email-tanu.kaskinen@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, han.lu@intel.com
List-Id: alsa-devel@alsa-project.org

Doxygen doesn't preserve formatting that relies only on indentation.
This fixes it by using lists more liberally.

There are probably more places to fix than just
snd_use_case_get_list(), but I only have motivation for fixing this
function's documentation formatting (the next patch will add some more
content to the function's documentation).

Signed-off-by: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
---
 include/use-case.h | 111 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 46 deletions(-)

diff --git a/include/use-case.h b/include/use-case.h
index 3728906..d309522 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -229,10 +229,10 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  * "const", but it's too late to fix it, sorry about that.)
  *
  * Known identifiers:
- *   NULL 		- return current card
- *   _verb		- return current verb
+ *   - NULL 		- return current card
+ *   - _verb		- return current verb
  *
- *   [=]{NAME}[/[{modifier}|{/device}][/{verb}]]
+ *   - [=]{NAME}[/[{modifier}|{/device}][/{verb}]]
  *                      - value identifier {NAME}
  *                      - Search starts at given modifier or device if any,
  *                          else at a verb
@@ -243,51 +243,70 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *                        device/modifier/verb specified, and not search
  *                        through each object in turn.
  *                      - Examples:
- *                          "PlaybackPCM/Play Music"
- *                          "CapturePCM/SPDIF"
- *                        From ValueDefaults only:
- *                          "=Variable"
- *                        From current active verb:
- *                          "=Variable//"
- *                        From verb "Verb":
- *                          "=Variable//Verb"
- *                        From "Modifier" in current active verb:
- *                          "=Variable/Modifier/"
- *                        From "Modifier" in "Verb":
- *                          "=Variable/Modifier/Verb"
+ *                          - "PlaybackPCM/Play Music"
+ *                          - "CapturePCM/SPDIF"
+ *                          - From ValueDefaults only:
+ *                              "=Variable"
+ *                          - From current active verb:
+ *                              "=Variable//"
+ *                          - From verb "Verb":
+ *                              "=Variable//Verb"
+ *                          - From "Modifier" in current active verb:
+ *                              "=Variable/Modifier/"
+ *                          - From "Modifier" in "Verb":
+ *                              "=Variable/Modifier/Verb"
  *
  * Recommended names for values:
- *   TQ			- Tone Quality
- *   PlaybackPCM	- full PCM playback device name
- *   PlaybackPCMIsDummy	- Valid values: "yes" and "no". If set to "yes", the
- *			  PCM named by the PlaybackPCM value is a dummy device,
- *			  meaning that opening it enables an audio path in the
- *			  hardware, but writing to the PCM device has no
- *			  effect.
- *   CapturePCM		- full PCM capture device name
- *   CapturePCMIsDummy	- Valid values: "yes" and "no". If set to "yes", the
- *			  PCM named by the CapturePCM value is a dummy device,
- *			  meaning that opening it enables an audio path in the
- *			  hardware, but reading from the PCM device has no
- *			  effect.
- *   PlaybackRate	- playback device sample rate
- *   PlaybackChannels	- playback device channel count
- *   PlaybackCTL	- playback control device name
- *   PlaybackVolume	- playback control volume ID string
- *   PlaybackSwitch	- playback control switch ID string
- *   CaptureRate	- capture device sample rate
- *   CaptureChannels	- capture device channel count
- *   CaptureCTL		- capture control device name
- *   CaptureVolume	- capture control volume ID string
- *   CaptureSwitch	- capture control switch ID string
- *   PlaybackMixer	- name of playback mixer
- *   PlaybackMixerID	- mixer playback ID
- *   CaptureMixer	- name of capture mixer
- *   CaptureMixerID	- mixer capture ID
- *   JackDev		- jack device name
- *   JackControl	- jack control name
- *   JackHWMute		- indicate if the HW mutes a device on jack insertion
- *			  or not.
+ *   - TQ
+ *      - Tone Quality
+ *   - PlaybackPCM
+ *      - full PCM playback device name
+ *   - PlaybackPCMIsDummy
+ *      - Valid values: "yes" and "no". If set to "yes", the PCM named by the
+ *        PlaybackPCM value is a dummy device, meaning that opening it enables
+ *        an audio path in the hardware, but writing to the PCM device has no
+ *        effect.
+ *   - CapturePCM
+ *      - full PCM capture device name
+ *   - CapturePCMIsDummy
+ *      - Valid values: "yes" and "no". If set to "yes", the PCM named by the
+ *        CapturePCM value is a dummy device, meaning that opening it enables
+ *        an audio path in the hardware, but reading from the PCM device has no
+ *        effect.
+ *   - PlaybackRate
+ *      - playback device sample rate
+ *   - PlaybackChannels
+ *      - playback device channel count
+ *   - PlaybackCTL
+ *      - playback control device name
+ *   - PlaybackVolume
+ *      - playback control volume ID string
+ *   - PlaybackSwitch
+ *      - playback control switch ID string
+ *   - CaptureRate
+ *      - capture device sample rate
+ *   - CaptureChannels
+ *      - capture device channel count
+ *   - CaptureCTL
+ *      - capture control device name
+ *   - CaptureVolume
+ *      - capture control volume ID string
+ *   - CaptureSwitch
+ *      - capture control switch ID string
+ *   - PlaybackMixer
+ *      - name of playback mixer
+ *   - PlaybackMixerID
+ *      - mixer playback ID
+ *   - CaptureMixer
+ *      - name of capture mixer
+ *   - CaptureMixerID
+ *      - mixer capture ID
+ *   - JackDev
+ *      - jack device name
+ *   - JackControl
+ *      - jack control name
+ *   - JackHWMute
+ *      - indicate if the HW mutes a device on jack insertion or not.
  */
 int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
                      const char *identifier,
-- 
1.9.3
