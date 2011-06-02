From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/2] UCM: Fix typo in error message
Date: Thu,  2 Jun 2011 16:44:38 -0600
Message-ID: <1307054679-32175-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B8EC24499
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 00:44:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

parse_name_is_safe disallows dots in the name, so not is the correct
word to use

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 src/ucm/parser.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 38fdba0..f7de9bd 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -62,7 +62,7 @@ int parse_string(snd_config_t *n, char **res)
 int parse_is_name_safe(char *name)
 {
 	if (strchr(name, '.')) {
-		uc_error("char '.' now allowed in '%s'", name);
+		uc_error("char '.' not allowed in '%s'", name);
 		return 0;
 	}
 	return 1;
-- 
1.7.0.4
