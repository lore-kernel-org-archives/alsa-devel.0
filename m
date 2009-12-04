From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.33
Date: Fri, 4 Dec 2009 11:00:03 +0000
Message-ID: <20091204110003.GB28498@opensource.wolfsonmicro.com>
References: <20091203110505.GE13165@rakim.wolfsonmicro.main>
	<s5hzl60urmf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 863041038A4
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 12:00:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzl60urmf.wl%tiwai@suse.de>
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

On Thu, Dec 03, 2009 at 02:14:16PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Very last minute but these would qualify as bug fixes during the release
> > cycle so I feel comfortable merging them now.

> Great.  I pulled this now.

Sorry, a couple more updates.  The arch/arm change is a bug fix on top
of patches queued in ASoC due to cross tree issues.  Neither of these is
terribly urgent so you may want to hold off on pulling until after Linus
has taken your initial pull request.

The following changes since commit efd9eb96d5604c2c133e500f7b8c7b3f3fbdece8:
  Manuel Lauss (1):
        ASoC: au1x: dbdma2: plug memleak in pcm device creation error path

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

Joonyoung Shim (1):
      ASoC: Rename controls with a / in wm_hubs

Mark Brown (1):
      S3C64XX: Staticise platform data for PCM devices

 arch/arm/plat-s3c64xx/dev-audio.c |    4 ++--
 sound/soc/codecs/wm_hubs.c        |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)
