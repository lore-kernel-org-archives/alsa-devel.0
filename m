From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC updates for 2.6.37
Date: Thu, 02 Dec 2010 16:29:24 +0000
Message-ID: <1291307364.3262.78.camel@odin>
References: <20101202132810.GF859@rakim.wolfsonmicro.main>
	<s5hlj48w3na.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E267103AD7
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 17:29:29 +0100 (CET)
Received: by wyi11 with SMTP id 11so8387370wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2010 08:29:28 -0800 (PST)
In-Reply-To: <s5hlj48w3na.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-12-02 at 17:17 +0100, Takashi Iwai wrote:
> At Thu, 2 Dec 2010 13:28:10 +0000,
> Mark Brown wrote:
> > 
> > The following changes since commit 649e5fb033bbadbfa78aba5e2711f1faf2affaf0:
> > 
> >   Merge branch 'for-2.6.37' into for-2.6.38 (2010-11-29 18:33:47 +0000)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37
> > 
> > All isolated bug fixes in drivers, and in the case of s6000 the fact
> > that it won't build anyway does lower the risk :)
> 
> Thanks, pulled now.
> Will send a pull request to Linus tomorrow, once after checking
> linux-next integration.

oh, in that case I have one fix for 2.6.37 :-

The following changes since commit 39a545559f8d5f13e8a4a7dfddcaad0e2ba9bcfb:

  ASoC: Add missing dev_set_drvdata in p1022_ds_probe (2010-11-29 18:28:53 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.37

Jarkko Nikula (1):
      ASoC: omap: N810: Don't select CONFIG_OMAP_MUX but make it as dependency

 sound/soc/omap/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


Thanks

Liam
