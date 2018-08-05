From: net147@gmail.com
Subject: [PATCH] alsabat: Allow custom sample format for round
	trip latency test
Date: Sun,  5 Aug 2018 13:59:35 +1000
Message-ID: <5b6676ab.1c69fb81.29f70.d84d@mx.google.com>
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
Cc: alsa-devel@alsa-project.org, Jonathan Liu <net147@gmail.com>, Zhang Vivian <vivian.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jonathan Liu <net147@gmail.com>

Setting the format to BAT_PCM_FORMAT_S16_LE in the round trip latency
test initialization is redundant as it is already set by default to
BAT_PCM_FORMAT_S16_LE unless a sample format is specified on the command
line.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 bat/latencytest.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bat/latencytest.c b/bat/latencytest.c
index fae191c..ec3abe2 100644
--- a/bat/latencytest.c
+++ b/bat/latencytest.c
@@ -178,7 +178,6 @@ void roundtrip_latency_init(struct bat *bat)
 	bat->latency.is_playing = false;
 	bat->latency.error = 0;
 	bat->latency.xrun_error = false;
-	bat->format = BAT_PCM_FORMAT_S16_LE;
 	bat->frames = LATENCY_TEST_TIME_LIMIT * bat->rate;
 	bat->periods_played = 0;
 }
-- 
2.18.0
