From: cosoleto@gmail.com
Subject: [PATCH] pcm: fix typo in snd_pcm_recover() error
	message
Date: Sat, 22 Jan 2011 02:27:54 +0100
Message-ID: <4d3a329e.122ae30a.47a3.45d7@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Francesco Cosoleto <cosoleto@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Francesco Cosoleto <cosoleto@gmail.com>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 src/pcm/pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 906b502..02dea0d 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -7313,7 +7313,7 @@ int snd_pcm_recover(snd_pcm_t *pcm, int err, int silent)
                 else
                         s = "overrun";
                 if (!silent)
-                        SNDERR("%s occured", s);
+                        SNDERR("%s occurred", s);
                 err = snd_pcm_prepare(pcm);
                 if (err < 0) {
                         SNDERR("cannot recovery from %s, prepare failed: %s", s, snd_strerror(err));
-- 
1.7.1
