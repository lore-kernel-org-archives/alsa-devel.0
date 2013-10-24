From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD multi-channel
	and HBR support
Date: Thu, 24 Oct 2013 21:10:33 +0300
Message-ID: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id B2A1F2615C0
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 20:10:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org, =?UTF-8?q?Peter=20Fr=C3=BChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

Hi all!

Here's another revision of the ATI/AMD multichannel+HBR patchset.

Changes:
- added customizable callbacks instead of polluting generic code
- fixed wrong codec id in rev3+ check (as previously noted)
- cosmetics

I've only tested this on NVIDIA/Intel, but I'd guess at least Peter
should be able to test this on AMD in a few days or so. The earlier
revisions were tested to fully work.

Combined patch can be found at: http://onse.fi/files/atihdmi5.patch
However, this patchset is on top recent sound-next commits so it does not
directly apply on older kernels.

Olivier, I hope you will be able to test this at some point as well
(same things as last time), even though it will be a bit more work :)

Anssi Hannula (5):
      ALSA: hda - hdmi: Allow HDA patches to customize more operations
      ALSA: hda - hdmi: Add ATI/AMD multi-channel audio support
      ALSA: hda - hdmi: Add ELD emulation for ATI/AMD codecs
      ALSA: hda - hdmi: Add HBR bitstreaming support for ATI/AMD HDMI codecs
      ALSA: hda - hdmi: Disable ramp-up/down for non-PCM on AMD codecs

 sound/pci/hda/hda_eld.c    | 151 +++++++++++
 sound/pci/hda/hda_local.h  |   4 +
 sound/pci/hda/patch_hdmi.c | 643 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 689 insertions(+), 109 deletions(-)

-- 
Anssi Hannula
