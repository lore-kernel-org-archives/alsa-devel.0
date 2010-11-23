From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC Fixes for 2.6.37
Date: Tue, 23 Nov 2010 11:06:21 +0000
Message-ID: <1290510381.3449.49.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D7D251038F1
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 12:06:24 +0100 (CET)
Received: by wyg36 with SMTP id 36so8160308wyg.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 03:06:24 -0800 (PST)
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

Hi Takashi,

One fix for 2.6.37 now that you are back from vacation.

Thanks

Liam

---

The following changes since commit 8f987768eb99631374f4ab0bb19cd062baf1397d:

  Merge commit 'v2.6.37-rc1' into for-2.6.37 (2010-11-03 14:11:27 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.37

Janusz Krzysztofik (1):
      ASoC: OMAP: fix OMAP1 compilation problem

 sound/soc/omap/omap-mcbsp.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)
