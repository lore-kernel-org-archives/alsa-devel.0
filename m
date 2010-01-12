From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Tue, 12 Jan 2010 14:50:39 +0000
Message-ID: <20100112145039.GK1418@rakim.wolfsonmicro.main>
References: <20100112132002.GC1418@rakim.wolfsonmicro.main>
	<s5hzl4jmp1e.wl%tiwai@suse.de> <s5hockzmo1t.wl%tiwai@suse.de>
	<20100112140936.GH1418@rakim.wolfsonmicro.main>
	<s5hiqb7mmm6.wl%tiwai@suse.de>
	<20100112143748.GB17092@sirena.org.uk>
	<s5hd41fmllv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D45FC10383A
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 15:50:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd41fmllv.wl%tiwai@suse.de>
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

On Tue, Jan 12, 2010 at 03:41:32PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Looks like CONFIG_HOTPLUG not being set is the culprit.

> Looks so.  The remove path is deactivated only when no hotplug
> is used (i.e. also no dynamic binding).

Yes, I'd set up non-modular stuff but hadn't noticed the separate option
for hotplug support.

> That said, the warnings are very subtle and maybe never be any
> problem in reality.

It's just code bloat so only a problem if you run out of
flash/RAM/whatever which probably isn't an issue in realistic
configurations for these drivers.  Anyway, this appears to cover it:

The following changes since commit 03e7a35c0ef7a462385fb6a301dfc1b287cac6de:
  Mark Brown (1):
        Revert "ASoC: ad1836: reset and restore clock control mode in suspend/resume entry"

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Mark Brown (1):
      ASoC: Add missing __devexit and __devinit annotations

 sound/soc/codecs/da7210.c      |    6 +++---
 sound/soc/codecs/tlv320dac33.c |    6 +++---
 sound/soc/codecs/tpa6130a2.c   |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)
