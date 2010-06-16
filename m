From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.36
Date: Wed, 16 Jun 2010 17:06:54 +0100
Message-ID: <20100616160653.GC31387@sirena.org.uk>
References: <20100616142335.GB24491@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BFD9D2415D
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 18:06:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100616142335.GB24491@rakim.wolfsonmicro.main>
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

On Wed, Jun 16, 2010 at 03:23:35PM +0100, Mark Brown wrote:
> The following changes since commit 67884e215bf24ad9c244cc8b9eb3c243e85385a1:
> 
>   Merge branch 'for-2.6.35' into for-2.6.36 (2010-06-15 11:55:35 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.36
> 
> Tweak to the WM2000 driver and a fix for the error reporting issues with
> volsw_2r_sx.

Sorry, forgot I'd sent a mail for this already.  Also added Peter
Huewe's I2C dependency patch:

Peter Huewe (1):
      ASoC: Fix I2C dependency for SND_FSI_AK4642 and SND_FSI_DA7210

 sound/soc/sh/Kconfig      |    4 ++--
