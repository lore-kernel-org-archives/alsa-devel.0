From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] aplay: Show usage if no parameter is passed
Date: Mon, 12 Nov 2012 16:02:32 -0200
Message-ID: <1352743353-7568-1-git-send-email-festevam@gmail.com>
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
To: perex@perex.cz
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When aplay/arecord are called without any argument the application hangs forever.

Instead of hanging, print the usage and exit.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 aplay/aplay.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 741979a..9cc5063 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -519,6 +519,11 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	if (argc == 1) {
+		usage(command);
+		return 0;
+	}
+
 	chunk_size = -1;
 	rhwparams.format = DEFAULT_FORMAT;
 	rhwparams.rate = DEFAULT_SPEED;
-- 
1.7.9.5
