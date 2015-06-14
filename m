From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/11] ALSA: bebob: improve support for
	DM1500/BeBoBv3
Date: Sun, 14 Jun 2015 12:49:26 +0900
Message-ID: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 625E32604D6
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 05:49:44 +0200 (CEST)
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

This patchset updates my previous one.

[alsa-devel] [RFC][PATCH 00/11] improve support for DM1500/BeBoBv3
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093320.html

Changes since the RFC:
 * re-gain missing enumerator member
 * update commit comments

I hope them to be merged into upstream.


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
 sound/firewire/bebob/bebob.h           |  20 +++--
 sound/firewire/bebob/bebob_focusrite.c |  33 +++++---
 sound/firewire/bebob/bebob_maudio.c    |  23 +++--
 sound/firewire/bebob/bebob_midi.c      |   8 +-
 sound/firewire/bebob/bebob_pcm.c       |  14 +--
 sound/firewire/bebob/bebob_proc.c      |  22 ++---
 sound/firewire/bebob/bebob_stream.c    | 150 ++++++++++++++++++++++++---------
 sound/firewire/bebob/bebob_terratec.c  |  30 +++++--
 sound/firewire/bebob/bebob_yamaha.c    |  20 ++++-
 11 files changed, 235 insertions(+), 100 deletions(-)

-- 
2.1.4
