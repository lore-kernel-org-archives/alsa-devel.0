From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.36
Date: Mon, 07 Jun 2010 11:14:58 +0100
Message-ID: <1275905698.3045.32.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 88D201037F7
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 12:15:03 +0200 (CEST)
Received: by fxm18 with SMTP id 18so1990298fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2010 03:15:02 -0700 (PDT)
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

Some mainly OMAP McBSP specific patches to reduce power from Peter. We
have Tony's Ack on all the arch/arm/omap stuff.

Thanks

Liam

The following changes since commit 1fab79b8a1bf0d46a7c7e6a1c06dbed1803f403c:
  Takashi Iwai (1):
        Merge branch 'for-2.6.36' of git://git.kernel.org/.../broonie/sound-2.6 into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.36

Peter Ujfalusi (6):
      OMAP: McBSP: Function to query the FIFO size
      OMAP3: McBSP: Change the way how the FIFO is handled
      OMAP3: McBSP: Use the port's buffer_size when calculating tx delay
      ASoC: omap-mcbsp: Save, and use wlen for threshold configuration
      ASoC: omap-mcbsp: Place correct constraints for streams
      ASoC: tlv320dac33: Add support for changing upper threshold

 arch/arm/mach-omap2/mcbsp.c             |   10 ++--
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 +
 arch/arm/plat-omap/mcbsp.c              |   51 ++++++++++-----
 sound/soc/codecs/tlv320dac33.c          |   57 +++++++++++++---
 sound/soc/omap/omap-mcbsp.c             |  112 +++++++++++++++++++++++-------
 5 files changed, 176 insertions(+), 56 deletions(-)
