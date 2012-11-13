From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v3 2/2] ac3dec: Show usage if no parameter is
	passed
Date: Tue, 13 Nov 2012 10:05:40 -0200
Message-ID: <1352808340-10561-2-git-send-email-fabio.estevam@freescale.com>
References: <1352808340-10561-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1352808340-10561-1-git-send-email-fabio.estevam@freescale.com>
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
Cc: tiwai@suse.de, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, patch@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

When ac3dec is called without any argument the application hangs forever.

Instead of hanging, print the usage and exit.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- No changes
Changes since v1:
- Also check for isatty, so that 'ac3dec < file.wav' can still work
 ac3dec/ac3dec.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ac3dec/ac3dec.c b/ac3dec/ac3dec.c
index 00c4f1a..ce6c507 100644
--- a/ac3dec/ac3dec.c
+++ b/ac3dec/ac3dec.c
@@ -130,6 +130,11 @@ int main(int argc,char *argv[])
 	out_config.spdif = SPDIF_NONE;
 	out_config.hdmi = 0;
 
+	if (isatty(fileno(stdin)) && (argc == 1)) {
+		help();
+		return 0;
+	}
+
 	morehelp = 0;
 	while (1) {
 		int c;
-- 
1.7.9.5
