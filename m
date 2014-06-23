From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 5/6] ASoC: Intel: byt-max98090: Do not change
	speaker and DMIC with jack state
Date: Mon, 23 Jun 2014 16:29:41 +0300
Message-ID: <1403530182-5400-5-git-send-email-jarkko.nikula@linux.intel.com>
References: <1403530182-5400-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6387F261A83
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 15:30:15 +0200 (CEST)
In-Reply-To: <1403530182-5400-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Strasser <kevin.strasser@intel.com>
List-Id: alsa-devel@alsa-project.org

Kernel should not enable/disable speakers and digital microphone whenever
jack is inserted/removed. This is more use-case than kernel specific
decision. For instance one may want to play VoIP ring tones using both
speakers and headphone but play music only from one of them.

Because of above reason remove "Ext Spk" and "Int Mic" update when jack
state is changed. Also this update was illogical anyway: "Ext Spk" was
enabled when jack was inserted and disabled when jack was removed.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-max98090.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/intel/byt-max98090.c b/sound/soc/intel/byt-max98090.c
index 3e2e7152ae66..deb1db9a9a97 100644
--- a/sound/soc/intel/byt-max98090.c
+++ b/sound/soc/intel/byt-max98090.c
@@ -63,14 +63,6 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
 		.pin	= "Headset Mic",
 		.mask	= SND_JACK_MICROPHONE,
 	},
-	{
-		.pin	= "Ext Spk",
-		.mask	= SND_JACK_LINEOUT,
-	},
-	{
-		.pin	= "Int Mic",
-		.mask	= SND_JACK_LINEIN,
-	},
 };
 
 static struct snd_soc_jack_gpio hs_jack_gpios[] = {
-- 
2.0.0
