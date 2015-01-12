From: han.lu@intel.com
Subject: [PATCH - UCM 1/2] control: add hexadecimal parse
Date: Mon, 12 Jan 2015 13:21:16 +0800
Message-ID: <1421040077-3494-1-git-send-email-han.lu@intel.com>
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
Cc: "Lu, Han" <han.lu@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/src/control/ctlparse.c b/src/control/ctlparse.c
index 978977d..92e2f95 100644
--- a/src/control/ctlparse.c
+++ b/src/control/ctlparse.c
@@ -59,7 +59,10 @@ static long get_integer(const char **ptr, long min, long max)
 		goto out;
 
 	s = p;
-	val = strtol(s, &p, 10);
+	if (*p == '0' && (*(p+1) == 'x' || *(p+1) == 'X'))
+		val = strtol(s, &p, 16);
+	else
+		val = strtol(s, &p, 10);
 	if (*p == '.') {
 		p++;
 		strtol(p, &p, 10);
@@ -87,7 +90,10 @@ static long long get_integer64(const char **ptr, long long min, long long max)
 		goto out;
 
 	s = p;
-	val = strtol(s, &p, 10);
+	if (*p == '0' && (*(p+1) == 'x' || *(p+1) == 'X'))
+		val = strtol(s, &p, 16);
+	else
+		val = strtol(s, &p, 10);
 	if (*p == '.') {
 		p++;
 		strtol(p, &p, 10);
-- 
1.9.1
