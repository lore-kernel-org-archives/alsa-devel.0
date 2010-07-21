From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.36
Date: Wed, 21 Jul 2010 13:38:44 +0100
Message-ID: <1279715924.3072.54.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E9CF410392B
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 14:38:49 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2121462ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 05:38:49 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 66b47fdb851924956b6e4696fb43a3496ae2c462:
  Mark Brown (1):
        ASoC: Implement WM8994 OPCLK support

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.36

Jorge Eduardo Candelaria (1):
      ASoC: TWL6040: Correct widget handling for drivers

Peter Ujfalusi (3):
      ASoC: TWL4030: Fix for digital loopback gain range
      ASoC: TWL4030: DAC power optimization
      ASoC: TWL4030: Add configurable delay after digimic enable

 sound/soc/codecs/twl4030.c |   47 ++++++++++++++++++++++++++----------
 sound/soc/codecs/twl4030.h |    1 +
 sound/soc/codecs/twl6040.c |   56 ++++++++++++++++++++++----------------------
 3 files changed, 63 insertions(+), 41 deletions(-)
