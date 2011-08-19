From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH] alsaucm: exit when user wants 'help' and
	'version'
Date: Fri, 19 Aug 2011 14:00:35 +0800
Message-ID: <20110819060035.3879.44369.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 310DF24559
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 08:00:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

When user specifies option 'help' or 'version', the program exists immediately.
This is more expected way than the current one.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 alsaucm/usecase.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/alsaucm/usecase.c b/alsaucm/usecase.c
index 1c94680..14a4be0 100644
--- a/alsaucm/usecase.c
+++ b/alsaucm/usecase.c
@@ -395,10 +395,10 @@ int main(int argc, char *argv[])
 		switch (c) {
 		case 'h':
 			dump_help(context);
-			break;
+			my_exit(context, EXIT_SUCCESS);
 		case OPT_VERSION:
 			printf("%s: version " SND_UTIL_VERSION_STR "\n", command);
-			break;
+			my_exit(context, EXIT_SUCCESS);
 		case 'c':
 			if (context->card)
 				free(context->card);
