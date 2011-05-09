From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.40
Date: Mon, 09 May 2011 19:51:56 +0100
Message-ID: <1304967116.3192.22.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AB6D71037EA
	for <alsa-devel@alsa-project.org>;
	Mon,  9 May 2011 20:52:00 +0200 (CEST)
Received: by wyg36 with SMTP id 36so4652036wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 09 May 2011 11:51:59 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmciro.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 333802e90d3f0366c4a1cb767e2783d2e1df73a8:

  ASoC: Support !REGULATOR build for sgtl5000 (2011-03-22 18:26:30 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.40

Peter Ujfalusi (2):
      ASoC: tlv320dac33: Move codec power up to DAPM
      ASoC: tlv320dac33: Lower the OSC calibration time

 sound/soc/codecs/tlv320dac33.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)
