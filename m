From: dsvensson@gmail.com
Subject: [PATCH] pcm: fix typo,
	should be SND_PCM_STATE_PREPARED.
Date: Thu,  4 Apr 2013 23:47:19 +0200
Message-ID: <1365112039-87635-1-git-send-email-dsvensson@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Daniel Svensson <dsvensson@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Svensson <dsvensson@gmail.com>

Signed-off-by: Daniel Svensson <dsvensson@gmail.com>
---
 src/pcm/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 05737d9..0868dd5 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -162,7 +162,7 @@ The PCM device has accepted communication parameters and it is waiting
 for #snd_pcm_prepare() call to prepare the hardware for
 selected operation (playback or capture).
 
-\par SND_PCM_STATE_PREPARE
+\par SND_PCM_STATE_PREPARED
 The PCM device is prepared for operation. Application can use
 #snd_pcm_start() call, write or read data to start
 the operation.
-- 
1.7.12.4 (Apple Git-37)
