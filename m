From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Wed, 3 Mar 2010 20:14:43 +0000
Message-ID: <20100303201443.GA15250@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C46C103801
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 21:14:45 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit a0b62329bb290c10d7278809af910ed115768991:
  Takashi Iwai (1):
        Merge branch 'for-2.6.34' of git://opensource.wolfsonmicro.com/linux-2.6-asoc into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Daniel Mack (1):
      ASoC: fix ak4104 register array access

Jassi Brar (1):
      ASoC: soc_pcm_open: Add missing bailout tag

 sound/soc/codecs/ak4104.c |    6 ++----
 sound/soc/soc-core.c      |   14 +++++++++-----
 2 files changed, 11 insertions(+), 9 deletions(-)
