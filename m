From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/14] ALSA: Proper endian notations
Date: Wed, 25 Jul 2018 23:24:00 +0200
Message-ID: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F14626778A
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:16 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1138FACCA
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
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

this is a patchset for correcting the integer types to the endian-wise
ones, as caught by sparse.  Just cosmetic fixes for catching future
bugs, no functional change by itself.


Takashi

===

Takashi Iwai (14):
  ALSA: ymfpci: Proper endian notations
  ALSA: trident: Proper endian notations
  ALSA: hda: Proper endian notations for BDL pointers
  ALSA: riptide: Properly endian notations
  ALSA: mixart: Proper endian notations
  ALSA: lola: Proper endian notations
  ALSA: intel8x0: Proper endian notations
  ALSA: intel8x0m: Proper endian notations
  ALSA: maestro3: Proper endian notations
  ALSA: echoaudio: Proper endian notations
  ALSA: bt87x: Proper endian notations
  ALSA: atiixp: Proper endian notations
  ALSA: atiixp_modem: Proper endian notations
  ALSA: sb: Proper endian notations

 sound/hda/hdac_stream.c             |  4 +-
 sound/isa/sb/sb16_csp.c             | 30 +++++------
 sound/pci/atiixp.c                  |  4 +-
 sound/pci/atiixp_modem.c            |  4 +-
 sound/pci/bt87x.c                   |  4 +-
 sound/pci/echoaudio/echoaudio.h     |  2 +-
 sound/pci/echoaudio/echoaudio_3g.c  | 14 +++---
 sound/pci/echoaudio/echoaudio_dsp.c |  6 +--
 sound/pci/echoaudio/echoaudio_dsp.h | 50 +++++++++---------
 sound/pci/echoaudio/echoaudio_gml.c |  8 +--
 sound/pci/intel8x0.c                |  6 +--
 sound/pci/intel8x0m.c               |  6 +--
 sound/pci/lola/lola.c               |  4 +-
 sound/pci/lola/lola.h               |  4 +-
 sound/pci/lola/lola_pcm.c           |  8 +--
 sound/pci/maestro3.c                |  6 +--
 sound/pci/mixart/mixart_core.c      |  4 +-
 sound/pci/mixart/mixart_hwdep.c     | 42 ++++++++--------
 sound/pci/mixart/mixart_hwdep.h     |  8 +--
 sound/pci/riptide/riptide.c         |  8 +--
 sound/pci/trident/trident.h         |  2 +-
 sound/pci/trident/trident_main.c    |  2 +-
 sound/pci/ymfpci/ymfpci.h           | 78 ++++++++++++++---------------
 sound/pci/ymfpci/ymfpci_main.c      |  6 +--
 24 files changed, 157 insertions(+), 153 deletions(-)

-- 
2.18.0
