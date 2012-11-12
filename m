From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ac3dec: Show usage if no parameter is
	passed
Date: Mon, 12 Nov 2012 16:02:33 -0200
Message-ID: <1352743353-7568-2-git-send-email-festevam@gmail.com>
References: <1352743353-7568-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1352743353-7568-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When ac3dec is called without any argument the application hangs forever.

Instead of hanging, print the usage and exit.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 ac3dec/ac3dec.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ac3dec/ac3dec.c b/ac3dec/ac3dec.c
index 00c4f1a..f1423e3 100644
--- a/ac3dec/ac3dec.c
+++ b/ac3dec/ac3dec.c
@@ -130,6 +130,11 @@ int main(int argc,char *argv[])
 	out_config.spdif = SPDIF_NONE;
 	out_config.hdmi = 0;
 
+	if (argc == 1) {
+		help();
+		return 0;
+	}
+
 	morehelp = 0;
 	while (1) {
 		int c;
-- 
1.7.9.5
