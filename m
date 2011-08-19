From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH] ucm: change msleep to usleep
Date: Fri, 19 Aug 2011 15:22:17 +0800
Message-ID: <20110819072217.4790.29949.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C25B1037FC
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 09:22:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

In file src/ucm/parser.c:
	if (strcmp(cmd, "usleep") == 0) {
string `usleep' is compared, however, in the comment and example conf file,
`msleep' is used, it's better to unify them all.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 src/ucm/parser.c              |    8 ++++----
 test/ucm/TestHDA/TestHDA.conf |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 23b67bc..a56f1e6 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -792,7 +792,7 @@ static int parse_modifier_name(snd_use_case_mgr_t *uc_mgr,
  *	EnableSequence [
  *		cset "name='Master Playback Switch',index=2 0,0"
  *		cset "name='Master Playback Volume',index=2 25,25"
- *		msleep 50
+ *		usleep 50
  *		cset "name='Master Playback Switch',index=2 1,1"
  *		cset "name='Master Playback Volume',index=2 50,50"
  *	]
@@ -800,14 +800,14 @@ static int parse_modifier_name(snd_use_case_mgr_t *uc_mgr,
  *	DisableSequence [
  *		cset "name='Master Playback Switch',index=2 0,0"
  *		cset "name='Master Playback Volume',index=2 25,25"
- *		msleep 50
+ *		usleep 50
  *		cset "name='Master Playback Switch',index=2 1,1"
  *		cset "name='Master Playback Volume',index=2 50,50"
  *	]
  *
  *      # Optional transition verb
  *      TransitionSequence."ToCaseName" [
- *		msleep 1
+ *		usleep 1
  *      ]
  *
  *	# Optional TQ and ALSA PCMs
@@ -1106,7 +1106,7 @@ static int parse_controls(snd_use_case_mgr_t *uc_mgr, snd_config_t *cfg)
  *	cset "name='Master Mono Playback Volume',index=1 0"
  *	cset "name='PCM Switch',index=2 1,1"
  *      exec "some binary here"
- *      msleep 50
+ *      usleep 50
  *	........
  * ]
  *
diff --git a/test/ucm/TestHDA/TestHDA.conf b/test/ucm/TestHDA/TestHDA.conf
index 41dd74c..0a75e21 100644
--- a/test/ucm/TestHDA/TestHDA.conf
+++ b/test/ucm/TestHDA/TestHDA.conf
@@ -7,7 +7,7 @@ SectionUseCase."Case1" {
 
 SectionDefaults [
 	exec "my prg"
-	msleep 1
+	usleep 1
 	cdev "hw:0"
 	cset "name='PCM Playback Volume' 50%"
 ]
