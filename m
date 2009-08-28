From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Fri, 28 Aug 2009 10:48:59 +0100
Message-ID: <20090828094858.GA4889@sirena.org.uk>
References: <20090826181546.GA7914@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 64AF9245E3
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 11:49:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090826181546.GA7914@rakim.wolfsonmicro.main>
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

The following changes since commit f1e887de2d24d50286709912ddc4a91ead21ff81:
  Mark Brown (1):
        ASoC: Don't reconfigure WM8350 FLL if not needed

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Chaithrika U S (1):
      ASoC: davinci: i2c device creation moved into board files

 sound/soc/davinci/davinci-evm.c |   32 +++++---------------------------
 1 files changed, 5 insertions(+), 27 deletions(-)
