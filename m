From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 00/11] improve support for DM1500/BeBoBv3
Date: Mon,  8 Jun 2015 23:30:57 +0900
Message-ID: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id DE0DA26040E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 16:31:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is to improve support for DM1500 and BeBoBv3; DM1500 is
an ASIC which ArchWave produced. BeBoB is an interface protocol for
DM series firmware.

Currently, Some devices are reported not to work with current ALSA
BeBoB driver.

[FFADO-user]
Support Behringer UFX1604
http://sourceforge.net/p/ffado/mailman/message/32846563/
    
[alsa-devel]
snd-bebob and PrismSound Orpheus fails with snd_pcm_hw_params_set_channels
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-April/090967.html

They commonly install BeBoB version 3 firmware. As long as seeing these
devices, they may have below quirks comparing to version 1 and 2.
Furthermore, DM1500 seems to have its own quirks.

The first half of this patchset is for improvement of clock detection, the
rest is for quirks. The latter is tested by Kim Tore Jensen (Thanks!), while
the first half is not widely tested. 

I hope someone to test it till opening next merge window (but just one week
rest!). I push these patches into my own repository. It's DKMS available.
https://github.com/takaswie/snd-firewire-improve/tree/bebob3

Regards

Takashi Sakamoto (11):
  ALSA: bebob: improve signal mode detection for clock source
  ALSA: bebob: apply new enumerator to normalize the type of clock
    source
  ALSA: bebob: preparation for replacing string literals by normalized
    representation for model-dependent structures
  ALSA: bebob: use normalized representation for the type of clock
    source
  ALSA: bebob: obsolete string literal expression for clock source
  ALSA: bebob: add SYT-Match support
  ALSA: bebob: add 'version' member for BeBoB protocol version
  ALSA: bebob: expand timeout for DM1500 quirk
  ALSA: bebob: loosen up severity of checking continuity for BeBoB v3
    quirk
  ALSA: bebob: keep duplex streams always to keep internal multiplexer
    properly
  ALSA: bebob: add support for Behringer FCA 610/1616

 sound/firewire/Kconfig                 |   1 +
 sound/firewire/bebob/bebob.c           |  14 ++-
 sound/firewire/bebob/bebob.h           |  17 ++--
 sound/firewire/bebob/bebob_focusrite.c |  33 +++++---
 sound/firewire/bebob/bebob_maudio.c    |  23 +++--
 sound/firewire/bebob/bebob_midi.c      |   8 +-
 sound/firewire/bebob/bebob_pcm.c       |  14 +--
 sound/firewire/bebob/bebob_proc.c      |  22 ++---
 sound/firewire/bebob/bebob_stream.c    | 150 ++++++++++++++++++++++++---------
 sound/firewire/bebob/bebob_terratec.c  |  30 +++++--
 sound/firewire/bebob/bebob_yamaha.c    |  20 ++++-
 11 files changed, 233 insertions(+), 99 deletions(-)

-- 
2.1.4
