From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Fri, 28 Aug 2009 19:00:34 +0100
Message-ID: <20090828180034.GA6632@sirena.org.uk>
References: <20090826181546.GA7914@rakim.wolfsonmicro.main>
	<20090828094858.GA4889@sirena.org.uk>
	<s5h4orrvpi9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C6F812442E
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 20:00:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4orrvpi9.wl%tiwai@suse.de>
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

On Fri, Aug 28, 2009 at 07:04:30PM +0200, Takashi Iwai wrote:

> Pulled now.  Thanks.

One more update from this afternoon:

The following changes since commit f4890b5c04b6301ef9c3c44ecbfe9955efdbaa17:
  Chaithrika U S (1):
        ASoC: davinci: i2c device creation moved into board files

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Jarkko Nikula (1):
      ASoC: OMAP: Add functionality to set CLKR and FSR sources in McBSP DAI

 sound/soc/omap/omap-mcbsp.c |   41 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-mcbsp.h |    4 ++++
 2 files changed, 45 insertions(+), 0 deletions(-)
