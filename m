From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fix incorrect rounding direction in
	snd_interval_ratnum()
Date: Sat, 19 Dec 2009 18:31:04 +0100
Message-ID: <20091219183104.04f24a96.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id D43E52445E
	for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2009 18:28:40 +0100 (CET)
Received: from poczta.interia.pl (mi01.poczta.interia.pl [10.217.12.1])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 50522106A78
	for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2009 18:28:36 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id C455725A5A13
	for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2009 18:28:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The direction of rounding is incorrect in the snd_interval_ratnum()
It was detected with following parameters (sb8 driver playing
8kHz stereo file):
 - num is always 1000000
 - requested frequency rate is from 7999 to 7999 (single frequency)

The first loop calculates div_down(num, freq->min) which is 125.
Thus, a frequency range's minimum value is 1000000 / 125 = 8000 Hz.
The second loop calculates div_up(num, freq->max) which is 126
The frequency range's maximum value is 1000000 / 126 = 7936 Hz.
The range maximum is lower than the range minimum so the function
fails due to empty result range.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/core/pcm_lib.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 30f4108..a27545b 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -758,7 +758,7 @@ int snd_interval_ratnum(struct snd_interval *i,
 		int diff;
 		if (q == 0)
 			q = 1;
-		den = div_down(num, q);
+		den = div_up(num, q);
 		if (den < rats[k].den_min)
 			continue;
 		if (den > rats[k].den_max)
@@ -794,7 +794,7 @@ int snd_interval_ratnum(struct snd_interval *i,
 			i->empty = 1;
 			return -EINVAL;
 		}
-		den = div_up(num, q);
+		den = div_down(num, q);
 		if (den > rats[k].den_max)
 			continue;
 		if (den < rats[k].den_min)
-- 
1.6.4


----------------------------------------------------------------------
Co Ci sie dzisiaj snilo? Czy wiesz, co oznacza Twoj sen?
Sprawdz w senniku >> http://link.interia.pl/f2532
