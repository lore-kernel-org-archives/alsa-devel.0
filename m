From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH] ucm: add another sequence 'msleep'
Date: Mon, 22 Aug 2011 09:25:44 +0800
Message-ID: <20110822012544.5379.75207.stgit@localhost6.localdomain6>
References: <4E4E8B84.1070700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id F2259103821
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 03:25:45 +0200 (CEST)
In-Reply-To: <4E4E8B84.1070700@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Thus, we have two sleep statements:
    msleep <milliseconds>
    usleep <microseconds>

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 src/ucm/parser.c    |   11 +++++++++++
 src/ucm/ucm_local.h |    2 +-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 23b67bc..b93d832 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -316,6 +316,17 @@ static int parse_sequence(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
 			continue;
 		}
 
+		if (strcmp(cmd, "msleep") == 0) {
+			curr->type = SEQUENCE_ELEMENT_TYPE_SLEEP;
+			err = snd_config_get_integer(n, &curr->data.sleep);
+			if (err < 0) {
+				uc_error("error: msleep requires integer!");
+				return err;
+			}
+			curr->data.sleep *= 1000L;
+			continue;
+		}
+
 		if (strcmp(cmd, "exec") == 0) {
 			curr->type = SEQUENCE_ELEMENT_TYPE_EXEC;
 			err = parse_string(n, &curr->data.exec);
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index 0522bf5..aa4d493 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -57,7 +57,7 @@ struct sequence_element {
 	struct list_head list;
 	unsigned int type;
 	union {
-		long sleep; /* Sleep time in msecs if sleep element, else 0 */
+		long sleep; /* Sleep time in macroseconds if sleep element, else 0 */
 		char *cdev;
 		char *cset;
 		char *exec;
