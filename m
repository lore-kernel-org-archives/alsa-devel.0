From: han.lu@intel.com
Subject: [PATCH v2 1/2] ucm: document some standard values
Date: Thu,  5 Mar 2015 08:38:54 +0800
Message-ID: <1425515935-12604-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, "Lu, Han" <han.lu@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

add standard value JackDev, JackControl and JackHWMute for speaker
mute control on jack insertion. These values will be applied on
pulseaudio.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/include/use-case.h b/include/use-case.h
index 697377a..3728906 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -284,6 +284,10 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *   PlaybackMixerID	- mixer playback ID
  *   CaptureMixer	- name of capture mixer
  *   CaptureMixerID	- mixer capture ID
+ *   JackDev		- jack device name
+ *   JackControl	- jack control name
+ *   JackHWMute		- indicate if the HW mutes a device on jack insertion
+ *			  or not.
  */
 int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
                      const char *identifier,
-- 
2.1.0
