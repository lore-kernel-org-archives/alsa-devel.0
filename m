From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/8] ALSA: dice: constrain PCM substreams
	to current sampling transfer frequency
Date: Sun, 15 Nov 2015 18:25:28 +0900
Message-ID: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 74A052605A1
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:25:41 +0100 (CET)
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

This patchset adds a constrain to ALSA dice driver to start PCM
substreams and AMDTP packet transferring just at current sampling
transfer frequency.

Dice hardware doesn't allow drivers to get supported combinations
between sampling rate and PCM channels. ALSA dice driver should follow
to the hardware design, though current ALSA driver has some
over-specifications. As a result, the driver has several issue and
brings inconvenience to users.

This patchset consists of two parts:
 * 01-05: to add constrain to current sampling transfer frequency and related
	  code cleanup
 * 06-08: to ensure and stabilize AMDTP packet transmission

As a result, userspace applications can request PCM substreams at current
sampling transfer frequency. Therefore, when users want to start PCM
substreams at different rate, they should set the rate in advance by the
other ways (i.e. ffado-dbus-server/ffado-mixer).

Takashi Sakamoto (8):
  ALSA: dice: limit to current sampling transfer frequency
  ALSA: dice: limit stream to current sampling transfer frequency.
  ALSA: dice: add MIDI ports according to current number of MIDI
    substreams
  ALSA: dice: get the number of MBLA data channel at opening PCM
    substream
  ALSA: dice: purge generating channel cache
  ALSA: dice: ensure phase lock before starting streaming
  ALSA: dice: expand timeout to wait for Dice notification
  ALSA: dice: wait for ensuring phase lock

 sound/firewire/dice/dice-midi.c        |  25 +++-
 sound/firewire/dice/dice-pcm.c         | 205 ++++++++++-----------------------
 sound/firewire/dice/dice-stream.c      | 118 +++++++++++++------
 sound/firewire/dice/dice-transaction.c | 109 ------------------
 sound/firewire/dice/dice.c             |  67 +----------
 sound/firewire/dice/dice.h             |  14 +--
 6 files changed, 162 insertions(+), 376 deletions(-)

-- 
2.5.0
