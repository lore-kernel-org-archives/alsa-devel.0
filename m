From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH] ucm: improve jack configuration documentation
Date: Thu,  5 Mar 2015 12:30:05 +0200
Message-ID: <1425551405-14066-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 52DD226044D
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 11:30:09 +0100 (CET)
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

Signed-off-by: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
---

I worked with Han Lu on enabling jack detection in PulseAudio with UCM
on Broadwell-rt286. Due to less-than-perfect coordination, we both
independently wrote documentation for the new UCM values. Han sent his
patch first, and it got applied already, but my patch has more
detailed documentation, so it might make sense to replace the
documentation with my version.


 include/use-case.h | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/use-case.h b/include/use-case.h
index 3728906..6c1fe70 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -284,10 +284,28 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *   PlaybackMixerID	- mixer playback ID
  *   CaptureMixer	- name of capture mixer
  *   CaptureMixerID	- mixer capture ID
- *   JackDev		- jack device name
- *   JackControl	- jack control name
- *   JackHWMute		- indicate if the HW mutes a device on jack insertion
- *			  or not.
+ *   JackControl,
+ *   JackDev,
+ *   JackHWMute		- Jack information for a device. The jack status can be
+ *			  reported via a kcontrol and/or via an input device.
+ *			  JackControl is the kcontrol name of the jack, and
+ *			  JackDev is the input device id of the jack (if the
+ *			  full input device path is /dev/input/by-id/foo, the
+ *			  JackDev value should be "foo"). UCM configuration
+ *			  files should contain both JackControl and JackDev
+ *			  when possible, because applications are likely to
+ *			  support only one or the other. If JackHWMute is set,
+ *			  it indicates that when the jack is plugged in, the
+ *			  hardware automatically mutes some other device. The
+ *			  JackHWMute value is the name of the muted device.
+ *			  Note that JackHWMute should be used only when the
+ *			  hardware enforces the automatic muting. If the
+ *			  hardware doesn't enforce any muting, it may still be
+ *			  tempting to set JackHWMute to trick upper software
+ *			  layers to e.g. automatically mute speakers when
+ *			  headphones are plugged in, but that's application
+ *			  policy configuration that doesn't belong to UCM
+ *			  configuration files.
  */
 int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
                      const char *identifier,
-- 
1.9.3
