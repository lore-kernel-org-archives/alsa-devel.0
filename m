From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: firewire: use .ack callback of PCM
	operation for packet processing
Date: Wed,  7 Jun 2017 09:38:04 +0900
Message-ID: <20170607003806.27196-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C79D626718D
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 02:38:11 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

In recent work for ALSA PCM core, driver-side implementation for
'struct snd_pcm_ops.ack'  is called when appl_ptr in intermediate PCM
buffer is changed, except for a case that mapped page frame is used
for the buffer and userspace applications doesn't voluntarily notify
the change.

In packet-oriented drivers, this callback is useful for the timing to
queue packets for data transmission with burstness. If things works well,
reduction of latency between PCM frame queueing and actual data
transmission. This patchset is for the purpose, additionally including
minor code refactoring. 

Major use case of ALSA PCM interface is memory mapped I/O and this
patchset adds no advantage in this case due to design of the .ack
callback, as I described.

Takashi Sakamoto (2):
  ALSA: firewire: process packets in 'struct snd_pcm_ops.ack' callback
  ALSA: fireface: constify ALSA specific operations

 sound/firewire/amdtp-stream.c            | 19 ++++++++++
 sound/firewire/amdtp-stream.h            |  1 +
 sound/firewire/bebob/bebob_pcm.c         | 16 +++++++++
 sound/firewire/dice/dice-pcm.c           | 18 ++++++++++
 sound/firewire/digi00x/digi00x-pcm.c     | 16 +++++++++
 sound/firewire/fireface/ff-midi.c        | 22 ++++++------
 sound/firewire/fireface/ff-pcm.c         | 62 +++++++++++++++++++-------------
 sound/firewire/fireworks/fireworks_pcm.c | 16 +++++++++
 sound/firewire/motu/motu-pcm.c           | 16 +++++++++
 sound/firewire/oxfw/oxfw-pcm.c           | 16 +++++++++
 sound/firewire/tascam/tascam-pcm.c       | 16 +++++++++
 11 files changed, 182 insertions(+), 36 deletions(-)

-- 
2.11.0
