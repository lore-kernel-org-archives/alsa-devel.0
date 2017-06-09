From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] ASoC: Intel: byt-max98090 Fix GPIOs lookup
Date: Fri, 9 Jun 2017 09:50:17 -0700
Message-ID: <20170609165017.GA2612@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 7070326765B
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 18:50:21 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id u26so9094242pfd.2
 for <alsa-devel@alsa-project.org>; Fri, 09 Jun 2017 09:50:21 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Nicolas Porcel <nicolasporcel06@gmail.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Nicolas Porcel <nicolasporcel06@gmail.com>

Commit 9c3c9bc9cc98 ("gpiolib: tighten up ACPI legacy gpio lookups")
changed the way fallback to _CRS-defined GPIOs is executed by requiring
drivers use common connection ID for all GPIOs fetched from _CRS. This
broke byt-max98090 driver, which expected GPIO core to ignore the names
it supplied and simply give GPIOs 0 and 1 from whatever block it finds.

By giving the same name to both GPIOs 0 and 1, the driver will perform
the lookup for both of them instead of the first requested. This is the
same behavior than before the commit.

Signed-off-by: Nicolas Porcel <nicolasporcel06@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/intel/boards/byt-max98090.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/byt-max98090.c b/sound/soc/intel/boards/byt-max98090.c
index d9f81b8d915d..a6e57d95c1e2 100644
--- a/sound/soc/intel/boards/byt-max98090.c
+++ b/sound/soc/intel/boards/byt-max98090.c
@@ -67,13 +67,13 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
 
 static struct snd_soc_jack_gpio hs_jack_gpios[] = {
 	{
-		.name		= "hp-gpio",
+		.name		= "byt_max98090",
 		.idx		= 0,
 		.report		= SND_JACK_HEADPHONE | SND_JACK_LINEOUT,
 		.debounce_time	= 200,
 	},
 	{
-		.name		= "mic-gpio",
+		.name		= "byt_max98090",
 		.idx		= 1,
 		.invert		= 1,
 		.report		= SND_JACK_MICROPHONE,
-- 
2.13.0.506.g27d5fe0cd-goog


-- 
Dmitry
