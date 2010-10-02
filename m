From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.37
Date: Sat, 02 Oct 2010 14:43:02 +0100
Message-ID: <1286026982.3125.32.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B83911037F1
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 15:43:03 +0200 (CEST)
Received: by wwb28 with SMTP id 28so3995341wwb.20
	for <alsa-devel@alsa-project.org>; Sat, 02 Oct 2010 06:43:03 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit fc38a8a11d332549e4de0537ba34f197cf42788b:
  Dimitris Papastamos (1):
        ASoC: WM8985: Remove unneeded declaration.

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.37

Jarkko Nikula (2):
      omap: zoom2: Fix ASoC multi-component build breakage by removing dead code
      omap: zoom: Move new code introduced by ASoC m-c to board-zoom-peripherals

 arch/arm/mach-omap2/board-zoom-peripherals.c |   12 ++++++
 arch/arm/mach-omap2/board-zoom2.c            |   56 --------------------------
 2 files changed, 12 insertions(+), 56 deletions(-)
