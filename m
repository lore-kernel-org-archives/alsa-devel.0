From: Antonio Ospite <ao2@ao2.it>
Subject: [alsa-lib][PATCHv2] ucm: docs: typeset lists of
	identifiers explicitly
Date: Fri, 23 Sep 2016 18:18:57 +0200
Message-ID: <20160923161857.26573-1-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp207.alice.it (smtp207.alice.it [82.57.200.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 8736C2665D9
 for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2016 18:19:15 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Antonio Ospite <ao2@ao2.it>
List-Id: alsa-devel@alsa-project.org

Doxygen doesn't preserve formatting that relies only on indentation,
typeset lists of identifiers explicitly.

This makes the HTML docs a lot more readable.

This change comes along the lines of commit 72aa0f8332fb ("ucm: reformat
snd_use_case_get() doc").

Some TABs has been added too in order to preserve the aligned look when
reading the source code.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---

Changes since v1:

  * fix a typo where a '=' (equal) was used instead of a '-' (minus) at the
    start of one line.

Thanks,
   Antonio

 include/use-case.h | 57 +++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/include/use-case.h b/include/use-case.h
index 9aac6e2..8911645 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -192,20 +192,21 @@ int snd_use_case_free_list(const char *list[], int items);
  * \return Number of list entries if success, otherwise a negative error code
  *
  * Defined identifiers:
- *   NULL 		- get card list
- *			  (in pair cardname+comment)
- *   _verbs		- get verb list
- *			  (in pair verb+comment)
- *   _devices[/{verb}]	- get list of supported devices
- *			  (in pair device+comment)
- *   _modifiers[/{verb}]- get list of supported modifiers
- *			  (in pair modifier+comment)
- *   TQ[/{verb}]	- get list of TQ identifiers
- *   _enadevs		- get list of enabled devices
- *   _enamods		- get list of enabled modifiers
+ *   - NULL			- get card list
+ *				 (in pair cardname+comment)
+ *   - _verbs			- get verb list
+ *				  (in pair verb+comment)
+ *   - _devices[/{verb}]	- get list of supported devices
+ *				  (in pair device+comment)
+ *   - _modifiers[/{verb}]	- get list of supported modifiers
+ *				  (in pair modifier+comment)
+ *   - TQ[/{verb}]		- get list of TQ identifiers
+ *   - _enadevs			- get list of enabled devices
+ *   - _enamods			- get list of enabled modifiers
+ *
+ *   - _supporteddevs/{modifier}|{device}[/{verb}]   - list of supported devices
+ *   - _conflictingdevs/{modifier}|{device}[/{verb}] - list of conflicting devices
  *
- *   _supporteddevs/{modifier}|{device}[/{verb}]   - list of supported devices
- *   _conflictingdevs/{modifier}|{device}[/{verb}] - list of conflicting devices
  *   Note that at most one of the supported/conflicting devs lists has
  *   any entries, and when neither is present, all devices are supported.
  *
@@ -331,8 +332,8 @@ int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
  * \return Zero if success, otherwise a negative error code
  *
  * Known identifiers:
- *   _devstatus/{device}	- return status for given device
- *   _modstatus/{modifier}	- return status for given modifier
+ *   - _devstatus/{device}	- return status for given device
+ *   - _modstatus/{modifier}	- return status for given modifier
  */
 int snd_use_case_geti(snd_use_case_mgr_t *uc_mgr,
 		      const char *identifier,
@@ -346,19 +347,19 @@ int snd_use_case_geti(snd_use_case_mgr_t *uc_mgr,
  * \return Zero if success, otherwise a negative error code
  *
  * Known identifiers:
- *   _verb 		- set current verb = value
- *   _enadev		- enable given device = value
- *   _disdev		- disable given device = value
- *   _swdev/{old_device} - new_device = value
- *			- disable old_device and then enable new_device
- *			- if old_device is not enabled just return
- *			- check transmit sequence firstly
- *   _enamod		- enable given modifier = value
- *   _dismod		- disable given modifier = value
- *   _swmod/{old_modifier} - new_modifier = value
- *			- disable old_modifier and then enable new_modifier
- *			- if old_modifier is not enabled just return
- *			- check transmit sequence firstly
+ *   - _verb			- set current verb = value
+ *   - _enadev			- enable given device = value
+ *   - _disdev			- disable given device = value
+ *   - _swdev/{old_device}	- new_device = value
+ *				  - disable old_device and then enable new_device
+ *				  - if old_device is not enabled just return
+ *				  - check transmit sequence firstly
+ *   - _enamod			- enable given modifier = value
+ *   - _dismod			- disable given modifier = value
+ *   - _swmod/{old_modifier}	- new_modifier = value
+ *				  - disable old_modifier and then enable new_modifier
+ *				  - if old_modifier is not enabled just return
+ *				  - check transmit sequence firstly
  */
 int snd_use_case_set(snd_use_case_mgr_t *uc_mgr,
                      const char *identifier,
-- 
2.9.3
