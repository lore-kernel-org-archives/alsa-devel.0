From: Mark Brown <broonie@sirena.org.uk>
Subject: ASoC updates for 2.6.31
Date: Fri, 8 May 2009 13:57:11 +0100
Message-ID: <20090508125711.GA16335@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D3F81038F1
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 14:57:18 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit bbd993077d788589a86a718ba7a7895ba5e71a17:
  Mark Brown (1):
        ASoC: Remove redundant codec pointer from DAIs

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

(git:// doesn't seem to be updating so...).

Daniel Mack (2):
      ASoC: cs4270: introduce CS4270_I2C_INCR
      ASoC: cs4270: add power management support

Mark Brown (2):
      ASoC: Add headers to match patterns in MAINTAINERS
      ASoC: Fix file patterns for PXA sound drivers

Peter Ujfalusi (1):
      ASoC: TWL4030: Fix typo in twl4030_codec_mute function

 MAINTAINERS                |    4 ++-
 sound/soc/codecs/cs4270.c  |   61 ++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/twl4030.c |    2 +-
 3 files changed, 63 insertions(+), 4 deletions(-)
