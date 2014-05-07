From: Karl Bongers <karlbongers@gmail.com>
Subject: [PATCH - aconnect 1/1] fix aconnect -l option
Date: Tue,  6 May 2014 23:06:47 -0500
Message-ID: <1399435607-9730-1-git-send-email-karlbongers@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Karl Bongers <karlbongers@gmail.com>
List-Id: alsa-devel@alsa-project.org

aconnect -l would just print usage.
This fix makes it do what usage says it should do.

Signed-off-by: Karl Bongers <karlbongers@gmail.com>

diff --git a/seq/aconnect/aconnect.c b/seq/aconnect/aconnect.c
index 8c66cfd..8d6cebb 100644
--- a/seq/aconnect/aconnect.c
+++ b/seq/aconnect/aconnect.c
@@ -292,6 +292,7 @@ int main(int argc, char **argv)
 			convert_real = 0;
 			break;
 		case 'l':
+			command = LIST;
 			list_subs = 1;
 			break;
 		case 'x':
-- 
1.8.3.2
