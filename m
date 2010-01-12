From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Tue, 12 Jan 2010 14:08:35 +0000
Message-ID: <20100112140834.GG1418@rakim.wolfsonmicro.main>
References: <20100112132002.GC1418@rakim.wolfsonmicro.main>
	<s5hzl4jmp1e.wl%tiwai@suse.de> <s5htyurmoof.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E77141037EE
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 15:08:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htyurmoof.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 12, 2010 at 02:35:12PM +0100, Takashi Iwai wrote:

> I got a build error quickly:

>   sound/soc/codecs/ad1836.c: In function 'ad1836_soc_resume':
>   sound/soc/codecs/ad1836.c:247: error: 'AD1836_ADC_AUX' undeclared (first use in this function)
>   sound/soc/codecs/ad1836.c:247: error: (Each undeclared identifier is reported only once
>   sound/soc/codecs/ad1836.c:247: error: for each function it appears in.)

> This must be one of Barry's patches.

Yes, it's afe1c2cd71eb4e0fade720b5709722e7124f29c0.  None of my build
test configs appear to manage to cover both SPI and PM at the minute
which is why I didn't hit it.  This'll do for now, Barry could you
please submit a new patch?

The following changes since commit 163849ea9b4c5d50fbd324692461983d18faadad:
  Mark Brown (1):
        Merge branch 'for-2.6.33' into for-2.6.34

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Mark Brown (1):
      Revert "ASoC: ad1836: reset and restore clock control mode in suspend/resume entry"

 sound/soc/codecs/ad1836.c |   32 --------------------------------
 1 files changed, 0 insertions(+), 32 deletions(-)
