From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] Updates for 2.6.39
Date: Wed, 16 Mar 2011 09:42:34 +0000
Message-ID: <1300268554.3432.1.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2F65A24501
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 10:42:37 +0100 (CET)
Received: by fxm6 with SMTP id 6so1375596fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 02:42:37 -0700 (PDT)
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

These should be the last updates for 2.6.39. 

Thanks

Liam

---
The following changes since commit 273de37655369e57919f19e157fafb2b4b1e4472:

  Merge branch 'for-2.6.39' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into for-2.6.39 (2011-02-01 14:55:10 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.39

Jarkko Nikula (5):
      ASoC: omap: rx51: Use gpio_request_one to configure tvout_sel gpio
      ASoC: omap: rx51: Add headset support
      ASoC: omap: rx51: Report headset insertion instead of video out cable
      ASoC: omap: rx51: Add FM transmitter support
      ASoC: omap: rx51: Enable McBSP2 sidetone

 sound/soc/omap/rx51.c |   42 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 36 insertions(+), 6 deletions(-)
