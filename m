From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/31] Constify hw_constrains
Date: Thu,  8 Jun 2017 23:08:21 +0200
Message-ID: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CAE7266851
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:56 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5A20AAC39
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 21:08:56 +0000 (UTC)
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

this is a very trivial patchset for adding const prefix to some static
PCM hw constraints.  Just for hardening.

The similar patchset for ASoC will follow later.


thanks,

Takashi

===

Takashi Iwai (31):
  ALSA: cs423x: Constify hw_constraints
  ALSA: es1688: Constify hw_constraints
  ALSA: es18xx: Constify hw_constraints
  ALSA: gus: Constify hw_constraints
  ALSA: sb: Constify hw_constraints
  ALSA: wss: Constify hw_constraints
  ALSA: parisc: Constify hw_constraints
  ALSA: ali5451: Constify hw_constraints
  ALSA: atiixp: Constify hw_constraints
  ALSA: au88x0: Constify hw_constraints
  ALSA: azt3328: Constify hw_constraints
  ALSA: bt87x: Constify hw_constraints
  ALSA: cmipci: Constify hw_constraints
  ALSA: cs46xx: Constify hw_constraints
  ALSA: emu10k1: Constify hw_constraints
  ALSA: fm801: Constify hw_constraints
  ALSA: ens137x: Constify hw_constraints
  ALSA: es1938: Constify hw_constraints
  ALSA: hda: Constify hw_constraints
  ALSA: ice1712: Constify hw_constraints
  ALSA: ice1724: Constify hw_constraints
  ALSA: intel8x0: Constify hw_constraints
  ALSA: nm256: Constify hw_constraints
  ALSA: rme32: Constify hw_constraints
  ALSA: rme96: Constify hw_constraints
  ALSA: hdsp: Constify hw_constraints
  ALSA: hdspm: Constify hw_constraints
  ALSA: rme9652: Constify hw_constraints
  ALSA: sonicvibes: Constify hw_constraints
  ALSA: via82xx: Constify hw_constraints
  ALSA: sparc: Constify hw_constraints

 sound/isa/cs423x/cs4236_lib.c |  4 ++--
 sound/isa/es1688/es1688_lib.c |  4 ++--
 sound/isa/es18xx.c            |  8 ++++----
 sound/isa/gus/gus_pcm.c       |  4 ++--
 sound/isa/sb/sb8_main.c       |  6 +++---
 sound/isa/wss/wss_lib.c       |  4 ++--
 sound/parisc/harmony.c        |  6 +++---
 sound/pci/ali5451/ali5451.c   |  4 ++--
 sound/pci/atiixp_modem.c      |  4 ++--
 sound/pci/au88x0/au88x0_pcm.c |  4 ++--
 sound/pci/azt3328.c           |  4 ++--
 sound/pci/bt87x.c             |  4 ++--
 sound/pci/cmipci.c            | 12 ++++++------
 sound/pci/cs46xx/cs46xx_lib.c |  4 ++--
 sound/pci/emu10k1/emupcm.c    |  8 ++++----
 sound/pci/ens1370.c           | 16 ++++++++--------
 sound/pci/es1938.c            |  4 ++--
 sound/pci/fm801.c             |  8 ++++----
 sound/pci/hda/patch_hdmi.c    | 10 +++++-----
 sound/pci/hda/patch_si3054.c  |  4 ++--
 sound/pci/ice1712/ice1712.c   |  4 ++--
 sound/pci/ice1712/ice1712.h   |  2 +-
 sound/pci/ice1712/ice1724.c   |  8 ++++----
 sound/pci/ice1712/juli.c      |  6 +++---
 sound/pci/ice1712/maya44.c    |  4 ++--
 sound/pci/ice1712/quartet.c   |  6 +++---
 sound/pci/intel8x0.c          | 12 ++++++------
 sound/pci/intel8x0m.c         |  4 ++--
 sound/pci/nm256/nm256.c       |  4 ++--
 sound/pci/rme32.c             |  5 ++---
 sound/pci/rme96.c             |  4 ++--
 sound/pci/rme9652/hdsp.c      |  8 ++++----
 sound/pci/rme9652/hdspm.c     |  4 ++--
 sound/pci/rme9652/rme9652.c   |  4 ++--
 sound/pci/sonicvibes.c        |  4 ++--
 sound/pci/via82xx.c           |  4 ++--
 sound/pci/via82xx_modem.c     |  4 ++--
 sound/sparc/cs4231.c          |  4 ++--
 38 files changed, 106 insertions(+), 107 deletions(-)

-- 
2.13.0
