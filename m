From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH v5 2/2] amidi: use GNU getopt_long() proper
	argument names
Date: Mon, 15 Aug 2016 17:37:34 +0100
Message-ID: <20160815163734.17658-3-eu@felipetonello.com>
References: <20160815163734.17658-1-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E4E4266C1E
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 18:37:40 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id q128so11997405wma.1
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 09:37:40 -0700 (PDT)
Received: from localhost.localdomain ([81.145.202.106])
 by smtp.gmail.com with ESMTPSA id b123sm17297045wmg.17.2016.08.15.09.37.38
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Aug 2016 09:37:38 -0700 (PDT)
In-Reply-To: <20160815163734.17658-1-eu@felipetonello.com>
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
List-Id: alsa-devel@alsa-project.org

This has no affect besides more clarity to the code.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 amidi/amidi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/amidi/amidi.c b/amidi/amidi.c
index bdb04c50a50b..0be5e63119c0 100644
--- a/amidi/amidi.c
+++ b/amidi/amidi.c
@@ -410,18 +410,18 @@ int main(int argc, char *argv[])
 {
 	static const char short_options[] = "hVlLp:s:r:S::dt:aD:";
 	static const struct option long_options[] = {
-		{"help", 0, NULL, 'h'},
-		{"version", 0, NULL, 'V'},
-		{"list-devices", 0, NULL, 'l'},
-		{"list-rawmidis", 0, NULL, 'L'},
-		{"port", 1, NULL, 'p'},
-		{"send", 1, NULL, 's'},
-		{"receive", 1, NULL, 'r'},
-		{"send-hex", 2, NULL, 'S'},
-		{"dump", 0, NULL, 'd'},
-		{"timeout", 1, NULL, 't'},
-		{"active-sensing", 0, NULL, 'a'},
-		{"delay", 1, NULL, 'D'},
+		{"help", no_argument, NULL, 'h'},
+		{"version", no_argument, NULL, 'V'},
+		{"list-devices", no_argument, NULL, 'l'},
+		{"list-rawmidis", no_argument, NULL, 'L'},
+		{"port", required_argument, NULL, 'p'},
+		{"send", required_argument, NULL, 's'},
+		{"receive", required_argument, NULL, 'r'},
+		{"send-hex", optional_argument, NULL, 'S'},
+		{"dump", no_argument, NULL, 'd'},
+		{"timeout", required_argument, NULL, 't'},
+		{"active-sensing", no_argument, NULL, 'a'},
+		{"delay", required_argument, NULL, 'D'},
 		{ }
 	};
 	int c, err, ok = 0;
-- 
2.9.3
