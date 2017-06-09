From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] ALSA: Reorganize kconfig for sequencer
	stuff
Date: Fri,  9 Jun 2017 17:12:47 +0200
Message-ID: <20170609151252.704-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F980267665
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 17:12:53 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 82BE1AE20
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 15:12:53 +0000 (UTC)
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

this is a patchset to rewrite Kconfig and Makefile for building ALSA
sequencer stuff.  The current code still contains quite a few hackish
code for enabling and selecting the features, and this patchset
simplifies to a standard way.  Also, this allows the mixture of
built-in and module in a more flexible way.


Takashi

===

Takashi Iwai (5):
  ALSA: Make CONFIG_SND_OSSEMUL user-selectable
  ALSA: seq: Allow the tristate build of OSS emulation
  ALSA: seq: Reorganize kconfig and build
  ALSA: synth: Select snd-emux-synth explicitly
  ALSA: seq: Allow the modular sequencer registration

 sound/Kconfig                   |  2 ++
 sound/core/Kconfig              | 56 ++++----------------------------
 sound/core/rawmidi.c            |  4 +--
 sound/core/seq/Kconfig          | 72 ++++++++++++++++++++++++++++++++++-------
 sound/core/seq/Makefile         | 21 +++++-------
 sound/core/seq/oss/Makefile     |  2 +-
 sound/drivers/Kconfig           | 15 +++++++++
 sound/drivers/opl3/opl3_lib.c   |  2 +-
 sound/drivers/opl3/opl3_seq.c   |  4 +--
 sound/drivers/opl3/opl3_voice.h |  5 ++-
 sound/drivers/opl4/opl4_lib.c   |  4 +--
 sound/drivers/opl4/opl4_local.h |  2 +-
 sound/isa/Kconfig               |  8 +++++
 sound/isa/sb/emu8000.c          |  2 +-
 sound/isa/sb/emu8000_callback.c |  6 ++--
 sound/isa/sb/sb16.c             |  2 +-
 sound/pci/Kconfig               |  8 +++++
 sound/pci/emu10k1/emu10k1.c     |  2 +-
 sound/synth/Kconfig             |  2 ++
 sound/synth/emux/Makefile       |  4 +--
 sound/synth/emux/emux.c         |  6 ++--
 sound/synth/emux/emux_effect.c  |  2 +-
 sound/synth/emux/emux_oss.c     |  4 ---
 23 files changed, 134 insertions(+), 101 deletions(-)
 create mode 100644 sound/synth/Kconfig

-- 
2.13.1
