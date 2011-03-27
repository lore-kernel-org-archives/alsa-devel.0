From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC fixes for 2.6.39
Date: Sun, 27 Mar 2011 20:26:02 +0100
Message-ID: <1301253962.3372.10.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AFCA51037FC
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 21:26:06 +0200 (CEST)
Received: by wwf26 with SMTP id 26so1927843wwf.20
	for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2011 12:26:05 -0700 (PDT)
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

Hi Takashi,

Some TI codec fixes for 2.6.39.

Thanks

Liam

---
The following changes since commit fa4d1f595a89234647b34a7f507436be873091bc:

  ASoC: omap: rx51: Enable McBSP2 sidetone (2011-03-09 10:52:28 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.39

Axel Lin (1):
      ASoC: twl6040: Return -ENOMEM if create_singlethread_workqueue fails

Peter Ujfalusi (2):
      ASoC: tlv320dac33: Fix inconsistent spinlock usage
      ASoC: tlv320dac33: Restore L/R DAC power control register

 sound/soc/codecs/tlv320dac33.c |   32 ++++++++++++++++++++------------
 sound/soc/codecs/twl6040.c     |    4 +++-
 2 files changed, 23 insertions(+), 13 deletions(-)
