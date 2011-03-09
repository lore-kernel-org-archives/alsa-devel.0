From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC Fixes for 2.6.38
Date: Wed, 09 Mar 2011 17:14:44 +0000
Message-ID: <1299690884.3360.180.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 906822446B
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 18:14:48 +0100 (CET)
Received: by wyj26 with SMTP id 26so630832wyj.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 09:14:48 -0800 (PST)
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

Takashi,

If you are planning a final pull for 2.6.38 fixes please include this
one. If not, I'll add this for 2.6.39.

Thanks

Liam

---

The following changes since commit 04d286819ba499839d04cbf847f2ea28d5cf4296:

  ASoC: WM8994: Ensure late enable events are processed for the ADCs (2011-03-01 23:27:07 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.38

Abhilash K V (1):
      ASoC: AM3517: Update codec name after multi-component update

 sound/soc/omap/am3517evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
