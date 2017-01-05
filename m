From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 0/6] ALSA: firewire: enclose identifiers
	reffered by single function
Date: Thu,  5 Jan 2017 21:48:06 +0900
Message-ID: <20170105124812.11283-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id EDAA22673C2
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 13:48:17 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset update my previous one:

[alsa-devel] [PATCH 0/6] ALSA: firewire: simplify symbol space for local linkage
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-January/116180.html

Changes from v1:
 - Rewrite commit comments with proper explanation of its aim.

Takashi Sakamoto (6):
  ALSA: bebob: enclose identifiers referred by single function
  ALSA: fireworks: enclose identifiers referred by single function
  ALSA: oxfw: enclose identifiers referred by single function
  ALSA: dice: enclose identifiers referred by single function
  ALSA: firewire-digi00x: enclose identifiers referred by single
    function
  ALSA: firewire-tascam: enclose identifiers referred by single function

 sound/firewire/bebob/bebob_hwdep.c         | 17 +++++-----
 sound/firewire/bebob/bebob_midi.c          | 26 +++++++--------
 sound/firewire/bebob/bebob_pcm.c           | 51 ++++++++++++++---------------
 sound/firewire/dice/dice-midi.c            | 22 ++++++-------
 sound/firewire/digi00x/digi00x-hwdep.c     | 17 +++++-----
 sound/firewire/digi00x/digi00x-midi.c      | 52 ++++++++++++++----------------
 sound/firewire/digi00x/digi00x-pcm.c       | 52 ++++++++++++++----------------
 sound/firewire/fireworks/fireworks_hwdep.c | 19 ++++++-----
 sound/firewire/fireworks/fireworks_midi.c  | 26 +++++++--------
 sound/firewire/fireworks/fireworks_pcm.c   | 52 ++++++++++++++----------------
 sound/firewire/oxfw/oxfw-midi.c            | 26 +++++++--------
 sound/firewire/tascam/tascam-hwdep.c       | 17 +++++-----
 sound/firewire/tascam/tascam-midi.c        | 26 +++++++--------
 sound/firewire/tascam/tascam-pcm.c         | 52 ++++++++++++++----------------
 14 files changed, 215 insertions(+), 240 deletions(-)

-- 
2.9.3
