From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.6
Date: Thu, 27 Sep 2012 17:43:35 +0100
Message-ID: <20120927164334.GC4428@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5F6D261658
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 18:51:42 +0200 (CEST)
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:

  Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.6

for you to fetch changes up to d0e12f3ff3472cbd8f52d3c0e6ee07a841787c40:

  ASoC: wm2000: Correct register size (2012-09-26 12:06:20 +0100)

Takashi is on vacation now so he asked me to send directly, it's a
pretty bad bug with low regression risk.

----------------------------------------------------------------
ASoC: Updates for 3.6

One small and obvious driver-specific fix.

----------------------------------------------------------------
Mark Brown (1):
      ASoC: wm2000: Correct register size

 sound/soc/codecs/wm2000.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
