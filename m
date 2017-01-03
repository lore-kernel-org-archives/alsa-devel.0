From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/6] ALSA: firewire: simplify symbol space for
	local linkage
Date: Tue,  3 Jan 2017 21:41:15 +0900
Message-ID: <20170103124121.17143-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C2D55266E3D
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 13:41:30 +0100 (CET)
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

This patchset is just for code improvements, without adding features.

Modules in ALSA firewire stack have some implementations for operation
structures which sound subsystem defines. All of them are referred just by
each local function to register corresponding operations. In this case, it's
better to put them into the function local so that symbol space in local
linkage of translation unit is kept to be simple.

Takashi Sakamoto (6):
  ALSA: bebob: simplify symbol space for local linkage
  ALSA: fireworks: simplify symbol space for local linkage
  ALSA: oxfw: simplify symbol space for local linkage
  ALSA: dice: simplify symbol space for local linkage
  ALSA: firewire-digi00x: simplify symbol space for local linkage
  ALSA: firewire-tascam: simplify symbol space for local linkage

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
