From: Mark Brown <broonie@sirena.org.uk>
Subject: ASoC updates for 2.6.30
Date: Tue, 10 Feb 2009 22:12:10 +0000
Message-ID: <20090210221204.GA12282@sirena.org.uk>
References: <20090210215247.GB8957@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CAEED243F2
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 23:12:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090210215247.GB8957@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 44dd2b9168350b82a671ce71666b99208ab2d973:
  Philipp Zabel (1):
        ASoC: pxa2xx-i2s: remove I2S pin setup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Jarkko Nikula (2):
      ASoC: TLV320AIC3X: Fix volume ranges
      ASoC: TLV320AIC3X: Add TLV information for volume controls

Lopez Cruz, Misael (1):
      ASoC: Update SDP3430 machine driver for snd_soc_card

Mark Brown (1):
      Merge branch 'for-2.6.29' into for-2.6.30

 sound/soc/codecs/tlv320aic3x.c |  114 +++++++++++++++++++++++++--------------
 sound/soc/omap/sdp3430.c       |    4 +-
 2 files changed, 75 insertions(+), 43 deletions(-)
