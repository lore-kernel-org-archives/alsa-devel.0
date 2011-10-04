From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Tue, 4 Oct 2011 14:47:36 +0100
Message-ID: <20111004134736.GD6934@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1987B103856
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 15:47:38 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 9058020cd9ae3423d6fe7de591698dc96b6701aa:

  ASoC: ssm2602: Re-enable oscillator after suspend (2011-09-27 11:20:38 +0100)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.1

None of these should be super critical so no need to rush them out but
if there's an opportunity to send stuff they're small, local fixes which
are nice to have.

Arnd Bergmann (2):
      ASoC: use a valid device for dev_err() in Zylonite
      ASoC: omap_mcpdm_remove cannot be __devexit

Axel Lin (1):
      ASoC: Fix setting update bits for WM8753_LADC and WM8753_RADC

 sound/soc/codecs/wm8753.c |    4 ++--
 sound/soc/omap/mcpdm.c    |    2 +-
 sound/soc/omap/mcpdm.h    |    2 +-
 sound/soc/pxa/zylonite.c  |    8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)
