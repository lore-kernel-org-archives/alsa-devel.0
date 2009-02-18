From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: Include I2C headers for
	corgi	and poodle
Date: Wed, 18 Feb 2009 14:56:57 +0000
Message-ID: <20090218145656.GC3867@sirena.org.uk>
References: <20090218125510.GA11978@opensource.wolfsonmicro.com>
	<1234961787-18435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hzlgjvr0s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BE8FD243B5
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 15:57:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzlgjvr0s.wl%tiwai@suse.de>
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

On Wed, Feb 18, 2009 at 02:00:35PM +0100, Takashi Iwai wrote:

> Better, but now get other errors.
> 
>   sound/soc/pxa/corgi.c:369: error: implicit declaration of function 'wm8731_i2c_setup'
>   sound/soc/pxa/poodle.c:334: error: implicit declaration of function 'wm8731_i2c_setup'

> Looks like a typo of wm8731_i2c_register().

Yes, it is.  Pushed out a fixed version - your .config worked, looks
like whatever caused me problems in the past has been fixed.

The following changes since commit 59544d33ff3118f22a484d8be06cdf5cfc2fdca5:
  Mark Brown (1):
        ASoC: Remove version display from the WM8753 driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Mark Brown (2):
      ASoC: Fix build for corgi and poodle
      ASoC: Implement SPI device unregistration for WM8731

 sound/soc/codecs/wm8731.c |    7 ++++++-
 sound/soc/pxa/corgi.c     |    3 ++-
 sound/soc/pxa/poodle.c    |    3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)
