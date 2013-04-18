From: lkasam@codeaurora.org
Subject: ALSA framework problem: FE disconnected,
	BE still connected!
Date: Thu, 18 Apr 2013 09:56:25 -0700
Message-ID: <7e576a6bf7cb6ca6a9be95b0d14e3a87.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 by alsa0.perex.cz (Postfix) with ESMTP id EBA0E260309
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 18:56:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lgirdwood@gmail.com
Cc: asishb@codeaurora.org, plai@codeaurora.org, broonie@kernel.org, gsantosh@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Hi Liam,
We have a problem encountered in ALSA framework wrt FE/BE disconnection and
fix to it is mentioned in below code change. please check it and provide
your valuable comments.


----------------------
From: Laxminath Kasam <lkasam@codeaurora.org>
Date: Wed, 3 Apr 2013 14:03:17 +0530
Subject: [PATCH] ASoC: audio: Fix BE not disconnected even codec teardown

Scenario:
When FE1(LowLatency) comes in which opens BE1 and puts it in state
SND_SOC_DPCM_STATE_START. Similarly FE2(LPA) comes in with
connecting to same BE. Now FE2 is in SND_SOC_DPCM_STATE_PREPARE
state and waits for TRIGGER_START. Meanwhile FE1 is closed which
doesn't affect BE1 and FE2 which are connected.
Also, for FE2 pcm_close is called before TRIGGER_START itself.
In such a case, BE1 is not getting disconnected  while Codec is teared
down resulting in failures.

Fix:
Whenever BE1 is found to be in SND_SOC_DPCM_STATE_START state
and FE1 being connected is not started yet, and close sequence
happens for this FE, then allow hw_free to happen for BE1 if
this is the only FE connected to this BE1. This allows BE to be
disconnected which calls afe_close then followed by Codec teardown
not resulting in any failures.

Signed-off-by: Laxminath Kasam <lkasam@codeaurora.org>
---
sound/soc/soc-pcm.c |    7 ++++++-
1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 915c3c2..ed0ea86 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1765,7 +1765,12 @@ static int soc_dpcm_be_dai_hw_free(struct
snd_soc_pcm_runtime *fe, int stream)
                    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
                        (be->dpcm[stream].state !=
SND_SOC_DPCM_STATE_HW_FREE) &&
                    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED) &&
-                   (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+                   (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+                   !((be->dpcm[stream].state == SND_SOC_DPCM_STATE_START)&&
+                     ((fe->dpcm[stream].state !=
SND_SOC_DPCM_STATE_START) &&
+                       (fe->dpcm[stream].state !=
SND_SOC_DPCM_STATE_PAUSED) &&
+                       (fe->dpcm[stream].state !=
+
SND_SOC_DPCM_STATE_SUSPEND))))
                        continue;

                dev_dbg(be->dev, "dpcm: hw_free BE %s\n",
--
-----------------------------------------


Please let me know if you are looking for more details.

Thanks
Kasam
