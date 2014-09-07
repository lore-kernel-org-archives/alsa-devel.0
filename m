From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 0/5] ALSA: pcm: snd_interval_step: fix
	changes of open	intervals
Date: Sun, 07 Sep 2014 21:43:41 +0200
Message-ID: <540CB56D.6080708@ladisch.de>
References: <540CB520.50909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 3363A2608C7
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 21:42:53 +0200 (CEST)
In-Reply-To: <540CB520.50909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Changing an interval boundary to a multiple of the step size makes that
boundary exact.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/core/pcm_lib.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 6fd5e1c..b03c7ae 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1120,11 +1120,13 @@ static int snd_interval_step(struct snd_interval *i, unsigned int step)
 	n = i->min % step;
 	if (n != 0 || i->openmin) {
 		i->min += step - n;
+		i->openmin = 0;
 		changed = 1;
 	}
 	n = i->max % step;
 	if (n != 0 || i->openmax) {
 		i->max -= n;
+		i->openmax = 0;
 		changed = 1;
 	}
 	if (snd_interval_checkempty(i)) {
