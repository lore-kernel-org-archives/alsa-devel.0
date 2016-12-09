From: Antonio Ospite <ao2@ao2.it>
Subject: [alsa-utils][PATCH 1/5] alsaucm: mention the "list1"
	command in the usage output
Date: Fri,  9 Dec 2016 14:02:28 +0100
Message-ID: <20161209130232.19457-2-ao2@ao2.it>
References: <20161209130232.19457-1-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp207.alice.it (smtp207.alice.it [82.57.200.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FF702677A4
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 14:02:52 +0100 (CET)
In-Reply-To: <20161209130232.19457-1-ao2@ao2.it>
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

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 alsaucm/usecase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/alsaucm/usecase.c b/alsaucm/usecase.c
index 1c94680..fbbe73a 100644
--- a/alsaucm/usecase.c
+++ b/alsaucm/usecase.c
@@ -117,7 +117,8 @@ static void dump_help(struct context *context)
 "  reset                      reset sound card to default state\n"
 "  reload                     reload configuration\n"
 "  listcards                  list available cards\n"
-"  list IDENTIFIER            list command\n"
+"  list IDENTIFIER            list command, for items with value + comment\n"
+"  list1 IDENTIFIER           list command, for items without comments\n"
 "  get IDENTIFIER             get string value\n"
 "  geti IDENTIFIER            get integer value\n"
 "  set IDENTIFIER VALUE       set string value\n"
-- 
2.11.0
