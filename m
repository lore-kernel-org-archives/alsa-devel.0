From: Michael Forney <mforney@mforney.org>
Subject: [PATCH 2/6] List cases in range explicitly
Date: Tue, 11 Jun 2019 23:08:10 -0700
Message-ID: <20190612060814.13534-3-mforney@mforney.org>
References: <20190612060814.13534-1-mforney@mforney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8503FF896EA
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 08:08:20 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id d21so6169350plr.3
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 23:08:20 -0700 (PDT)
In-Reply-To: <20190612060814.13534-1-mforney@mforney.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Case ranges are a GNU extension, and provide only a slight readability
improvement.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 src/conf.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/conf.c b/src/conf.c
index 3e4b76a3..77fd0da5 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -888,7 +888,8 @@ static int get_quotedchar(input_t *input)
 		return '\r';
 	case 'f':
 		return '\f';
-	case '0' ... '7':
+	case '0': case '1': case '2': case '3':
+	case '4': case '5': case '6': case '7':
 	{
 		int num = c - '0';
 		int i = 1;
@@ -1479,7 +1480,8 @@ static void string_print(char *str, int id, snd_output_t *out)
 	}
 	if (!id) {
 		switch (*p) {
-		case '0' ... '9':
+		case '0': case '1': case '2': case '3': case '4':
+		case '5': case '6': case '7': case '8': case '9':
 		case '-':
 			goto quoted;
 		}
@@ -1488,8 +1490,6 @@ static void string_print(char *str, int id, snd_output_t *out)
 	switch (*p) {
 	case 0:
 		goto nonquoted;
-	case 1 ... 31:
-	case 127 ... 255:
 	case ' ':
 	case '=':
 	case ';':
@@ -1501,6 +1501,8 @@ static void string_print(char *str, int id, snd_output_t *out)
 	case '"':
 		goto quoted;
 	default:
+		if (*p <= 31 || *p >= 127)
+			goto quoted;
 		p++;
 		goto loop;
 	}
@@ -1542,12 +1544,11 @@ static void string_print(char *str, int id, snd_output_t *out)
 			snd_output_putc(out, '\\');
 			snd_output_putc(out, c);
 			break;
-		case 32 ... '\'' - 1:
-		case '\'' + 1 ... 126:
-			snd_output_putc(out, c);
-			break;
 		default:
-			snd_output_printf(out, "\\%04o", c);
+			if (c >= 32 && c <= 126 && c != '\'')
+				snd_output_putc(out, c);
+			else
+				snd_output_printf(out, "\\%04o", c);
 			break;
 		}
 		p++;
@@ -4687,7 +4688,8 @@ static int parse_char(const char **ptr)
 	case 'f':
 		c = '\f';
 		break;
-	case '0' ... '7':
+	case '0': case '1': case '2': case '3':
+	case '4': case '5': case '6': case '7':
 	{
 		int num = c - '0';
 		int i = 1;
-- 
2.20.1
