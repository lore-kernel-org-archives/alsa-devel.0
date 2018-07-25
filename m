From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/10] ALSA: yet more PCM format type
	conversion fixes
Date: Wed, 25 Jul 2018 23:19:35 +0200
Message-ID: <20180725211945.19222-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E731267766
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:19:54 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 985D7B062
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:19:53 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of similar fixes as the previous patchset for ASoC,
covering other ALSA drivers to deal with PCM format type properly.


Takashi

===

Takashi Iwai (10):
  ALSA: hda: Fix implicit PCM format type conversion
  ALSA: riptide: Fix PCM format type conversion
  ALSA: pcm: Fix sparse warning wrt PCM format type
  ALSA: ad1816a: Fix sparse warning wrt PCM format type
  ALSA: au88x0: Fix sparse warning wrt PCM format type
  ALSA: asihpi: Fix PCM format notations
  ALSA: wss: Fix sparse warning wrt PCM format type
  ALSA: sb: Fix PCM format bit calculation
  ALSA: sb: Fix sparse warning wrt PCM format type
  ALSA: xen: Use standard pcm_format_to_bits() for ALSA format bits

 include/sound/hdaudio.h         |  3 ++-
 include/sound/sb16_csp.h        |  2 +-
 sound/core/oss/pcm_oss.c        |  2 +-
 sound/hda/hdac_device.c         |  2 +-
 sound/isa/ad1816a/ad1816a_lib.c |  3 ++-
 sound/isa/sb/sb16_csp.c         |  6 +++---
 sound/isa/sb/sb16_main.c        |  9 ++++++---
 sound/isa/wss/wss_lib.c         |  2 +-
 sound/pci/asihpi/asihpi.c       | 24 +++++++++++++-----------
 sound/pci/au88x0/au88x0.h       |  2 +-
 sound/pci/au88x0/au88x0_core.c  |  2 +-
 sound/pci/riptide/riptide.c     |  2 +-
 sound/xen/xen_snd_front_alsa.c  |  4 ++--
 13 files changed, 35 insertions(+), 28 deletions(-)

-- 
2.18.0
