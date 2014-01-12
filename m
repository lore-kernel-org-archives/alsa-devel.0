From: Daniel Matuschek <daniel@matuschek.net>
Subject: [PATCH] ASoC: wm8804: Cleanup of post_table
Date: Sun, 12 Jan 2014 12:31:21 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1401121222180.3093@parallels-Parallels-Virtual-Platform>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zhhdzmsp-nwas14.bluewin.ch (nwas14.bluewin.ch [195.186.228.231])
 by alsa0.perex.cz (Postfix) with ESMTP id F09E02616FE
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 12:31:32 +0100 (CET)
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
Cc: Dimitris.Papastamos@wolfsonmicro.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, info@crazy-audio.com
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Daniel 
Matuschek <inof@crazy-audio.com>

  Existing post_table has duplicate settings for some PLL settings.
  Only the first setting was used with mclk_div=1
  With the updated post_table, the driver
  uses mclk_div=0 whenever it is possible. This allows the WM8804
  to work at 256xfs internal clock and only use 128xfs
  internal clock for high sample rates where 256xfs is not
  supported anymore.

---
  sound/soc/codecs/wm8804.c |    2 --
  1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 1704b1e..f605b8b 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -307,9 +307,7 @@ static struct {
  	unsigned int mclkdiv;
  } post_table[] = {
  	{  2,  0, 0 },
-	{  4,  0, 1 },
  	{  4,  1, 0 },
-	{  8,  1, 1 },
  	{  8,  2, 0 },
  	{ 16,  2, 1 },
  	{ 12,  3, 0 },
-- 
1.7.9.5
