From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/21] ALSA: Remove always NULL parameters
Date: Fri,  2 Jan 2015 12:24:34 +0100
Message-ID: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id B8BAA260453
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:24:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

There is a bit of a anti-pattern in some of the (mostly older) driver. In
these drivers functions which allocate PCMs, timers, etc. take a parameter
which is a pointer to a pointer of the allocated object and if the pointer
is provided it is set to the newly allocate object. The code essentially
looks like this.

	int foobar_allocate(..., struct snd_pcm **rpcm)
	{
		struct snd_pcm *pcm;
		
		if (rpcm)
			*rpcm = NULL;

		... /* Create and initialize object */

		if (rpcm)
			*rpcm = pcm;

		return 0;
	}

But then all callers to these functions always pass NULL for the pointer. So
the code that checks and initializes the pointer becomes dead code. While it
can be argued that such a pattern makes sense for library functions where
there might be new users which want to provide a valid pointer (at least in
the absence of PTR_ERR and friends), it makes less sense for functions that
are only used internally in a driver which hasn't seen any new hardware
support in the last 10 years.

This series goes through these drivers and removes the pointer parameter
from functions which follow this pattern.

There is one exception which is the wss driver, which is kind of a library
driver, where some of the users actually pass a valid pointer. But the same
PCM object that is stored in that pointer can also be accessed through the
wss chip state struct. So that driver is update as well.

- Lars

Lars-Peter Clausen (21):
  ALSA: ml403-ac97cr: Remove always NULL parameter
  ALSA: ad1816a: Remove always NULL parameters
  ALSA: es1688: Remove almost always NULL parameter
  ALSA: es18xx: Remove always NULL parameter
  ALSA: gus: Remove always NULL parameters
  ALSA: msnd: Remove always NULL parameter
  ALSA: sb8: Remove always NULL parameters
  ASoC: sb16: Simplify snd_sb16dsp_pcm()
  ALSA: wss: Remove (almost) always NULL parameters
  ASLA: ad1889: Remove always NULL parameter
  ALSA: asihpi: Remove always NULL parameter
  ALSA: cs4281: Remove always NULL parameters
  ALSA: cs46xx: Remove always NULL parameters
  ALSA: ens1370: Remove always NULL parameters
  ALSA: emu10k1: Remove always NULL parameters
  ALSA: fm801: Remove always NULL parameter
  ALSA: ice1712: Remove always NULL parameters
  ALSA: riptide: Remove always NULL parameter
  ALSA: sonicvibes: Remove always NULL parameter
  ALSA: trident: Remove always NULL parameters
  ALSA: ymfpci: Remove always NULL parameters

 include/sound/ad1816a.h            |  5 ++---
 include/sound/emu10k1.h            | 14 ++++++-------
 include/sound/es1688.h             |  3 +--
 include/sound/gus.h                |  4 ++--
 include/sound/sb.h                 |  6 +++---
 include/sound/wss.h                |  6 +++---
 sound/drivers/ml403-ac97cr.c       |  9 ++-------
 sound/isa/ad1816a/ad1816a.c        |  5 ++---
 sound/isa/ad1816a/ad1816a_lib.c    |  9 ++-------
 sound/isa/ad1848/ad1848.c          |  7 +++----
 sound/isa/als100.c                 |  2 +-
 sound/isa/azt2320.c                |  4 ++--
 sound/isa/cmi8328.c                |  4 ++--
 sound/isa/cs423x/cs4231.c          |  9 ++++-----
 sound/isa/cs423x/cs4236.c          | 13 ++++++-------
 sound/isa/cs423x/cs4236_lib.c      |  9 +++------
 sound/isa/es1688/es1688.c          |  7 +++----
 sound/isa/es1688/es1688_lib.c      |  6 +-----
 sound/isa/es18xx.c                 | 10 ++--------
 sound/isa/galaxy/galaxy.c          |  4 ++--
 sound/isa/gus/gus_pcm.c            |  6 +-----
 sound/isa/gus/gus_uart.c           |  6 +-----
 sound/isa/gus/gusclassic.c         |  4 ++--
 sound/isa/gus/gusextreme.c         |  4 ++--
 sound/isa/gus/gusmax.c             |  8 ++++----
 sound/isa/gus/interwave.c          | 14 ++++++-------
 sound/isa/msnd/msnd.c              |  6 +-----
 sound/isa/msnd/msnd.h              |  2 +-
 sound/isa/msnd/msnd_pinnacle.c     |  2 +-
 sound/isa/opl3sa2.c                |  4 ++--
 sound/isa/opti9xx/miro.c           | 12 +++++-------
 sound/isa/opti9xx/opti92x-ad1848.c | 13 +++++--------
 sound/isa/sb/jazz16.c              |  2 +-
 sound/isa/sb/sb16.c                |  2 +-
 sound/isa/sb/sb16_main.c           |  8 ++------
 sound/isa/sb/sb8.c                 |  4 ++--
 sound/isa/sb/sb8_main.c            |  6 +-----
 sound/isa/sb/sb8_midi.c            |  6 +-----
 sound/isa/sc6000.c                 |  2 +-
 sound/isa/sscape.c                 |  5 ++---
 sound/isa/wavefront/wavefront.c    |  4 ++--
 sound/isa/wss/wss_lib.c            |  8 ++------
 sound/pci/ad1889.c                 | 10 ++--------
 sound/pci/asihpi/asihpi.c          |  9 ++-------
 sound/pci/cs4281.c                 | 18 ++++-------------
 sound/pci/cs46xx/cs46xx.c          | 10 +++++-----
 sound/pci/cs46xx/cs46xx.h          | 10 +++++-----
 sound/pci/cs46xx/cs46xx_lib.c      | 40 +++++---------------------------------
 sound/pci/cs5530.c                 |  2 +-
 sound/pci/emu10k1/emu10k1.c        | 12 ++++++------
 sound/pci/emu10k1/emu10k1x.c       | 19 +++++-------------
 sound/pci/emu10k1/emufx.c          |  7 +------
 sound/pci/emu10k1/emupcm.c         | 33 ++++---------------------------
 sound/pci/emu10k1/p16v.c           |  7 +------
 sound/pci/ens1370.c                | 37 ++++++++---------------------------
 sound/pci/fm801.c                  | 14 +++----------
 sound/pci/ice1712/ice1712.c        | 26 ++++++-------------------
 sound/pci/riptide/riptide.c        |  9 ++-------
 sound/pci/sonicvibes.c             |  7 ++-----
 sound/pci/trident/trident.c        |  6 +++---
 sound/pci/trident/trident.h        |  6 +++---
 sound/pci/trident/trident_main.c   | 21 +++-----------------
 sound/pci/ymfpci/ymfpci.c          |  8 ++++----
 sound/pci/ymfpci/ymfpci.h          |  8 ++++----
 sound/pci/ymfpci/ymfpci_main.c     | 38 ++++++------------------------------
 65 files changed, 185 insertions(+), 436 deletions(-)

-- 
1.8.0
