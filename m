From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] amixer no-range-checking option
Date: Thu, 3 Feb 2005 21:20:33 +0100
Message-ID: <20050203212033.0a47e70b.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



This patch adds the --nocheck option that disables range checking. It helps
debugging drivers.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-utils/amixer/amixer.c_old	Thu Feb  3 19:39:35 2005
+++ alsa-utils/amixer/amixer.c	Thu Feb  3 21:08:06 2005
@@ -38,6 +38,7 @@
 #define HELPID_INACTIVE		1004
 #define HELPID_DEBUG            1005
 #define HELPID_VERSION		1006
+#define HELPID_NOCHECK		1007
 
 #define LEVEL_BASIC		(1<<0)
 #define LEVEL_INACTIVE		(1<<1)
@@ -45,6 +46,7 @@
 
 int quiet = 0;
 int debugflag = 0;
+int no_check = 0;
 char card[64] = "default";
 
 static void error(const char *fmt,...)
@@ -66,6 +68,7 @@
 	printf("  -c,--card N     select the card\n");
 	printf("  -D,--device N   select the device, default '%s'\n", card);
 	printf("  -d,--debug      debug mode\n");
+	printf("  -n,--nocheck    do not perform range checking\n");
 	printf("  -v,--version    print version of this program\n");
 	printf("  -q,--quiet      be quiet\n");
 	printf("  -i,--inactive   show also inactive controls\n");
@@ -161,6 +164,8 @@
 
 static int check_range(int val, int min, int max)
 {
+	if (no_check)
+		return val;
 	if (val < min)
 		return min;
 	if (val > max)
@@ -1456,6 +1461,7 @@
 		{"quiet", 0, NULL, HELPID_QUIET},
 		{"inactive", 0, NULL, HELPID_INACTIVE},
 		{"debug", 0, NULL, HELPID_DEBUG},
+		{"nocheck", 0, NULL, HELPID_NOCHECK},
 		{"version", 0, NULL, HELPID_VERSION},
 		{NULL, 0, NULL, 0},
 	};
@@ -1464,7 +1470,7 @@
 	while (1) {
 		int c;
 
-		if ((c = getopt_long(argc, argv, "hc:D:qidv", long_option, NULL)) < 0)
+		if ((c = getopt_long(argc, argv, "hc:D:qidnv", long_option, NULL)) < 0)
 			break;
 		switch (c) {
 		case 'h':
@@ -1501,6 +1507,10 @@
 		case HELPID_DEBUG:
 			debugflag = 1;
 			break;
+		case 'n':
+		case HELPID_NOCHECK:
+			no_check = 1;
+			break;
 		case 'v':
 		case HELPID_VERSION:
 			printf("amixer version " SND_UTIL_VERSION_STR "\n");


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
