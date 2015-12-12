From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 00/10 v2] ALSA: dice: stabiliza packet
	streaming
Date: Sat, 12 Dec 2015 12:06:00 +0900
Message-ID: <1449889570-26641-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DEAC2654B7
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 04:06:15 +0100 (CET)
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

This patchset updates my previous one:
[alsa-devel] [RFC][PATCH 0/8] ALSA: dice: constrain PCM substreams to current sampling transfer frequency
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100670.html

I hope more users to test this patchset in this developing cycle.

[Background]
I've frequently got private messages from owners of dice-based models
since below patchset was merged to mainline:

[alsa-devel] [PATCH 00/15 v5] ALSA: Enhancement for existed FireWire drivers
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-December/085142.html

Some of them addressed that ALSA dice driver fails to handle their
models, while their experiences are not the same. The summary:
 * ETIMEOUT at starting streaming
 * detecting packet discontinuity at starting streaming
 * ETIMEOUT at probing snd-dice
 * no sound even if starting streaming

This patchset is my solutions for these issues. It consists of four parts;

[Patch 01]
ETIMEDOUT at starting streaming means that ALSA dice driver has never received
dice notification within current timeout (200 msec).
This patch expands the timeout up to 2 sec. There's some disadvantages of this
change in usage of ALSA PCM API, see commit comment.

[Patch 02]
Packet discontinuity at starting streaming means that the device fail to get
constant clock signals from phase lock loop (PLL) circuit. In this case, ALSA
dice driver successfully starts streaming and receives AMDTP packet from the
device, therefore any dice notifications are already transferred. It's
reasonable to judge that the device has a quirk to transfer the notification
before set its PLL circuit steadily.
This patch continue to check a register so that the device get phase lock after
receiving dice notification.

[Patch 03-04]
When connected to IEEE 1394 bus, some models generate bus reset after appearing
on bus topology. Usually, boot processing of Dice based models consists of
three stages; boot loader (RedBoot) is loaded, it loads eCos, the operating
system executes vendor's configurations for hardware initialization. It's
reasonable to assume that bus reset occurs at each of these stages.
Furthermore, I observed that ImpactTwin (TC Electronic produced) changes some
registers before/after ALSA dice driver is probed with my RFC v1. This means
that the hardware initialization requires a bit time.
These patches postpone unit probe processing after continuous bus resets. These
patches have advantages to start communication to the device after the hardware
initialization. These patches may improve handling Dice II based models such as
ImpactTwin and IO26 (Alesis produces).

[Patch 05-10]
When seeing sound/firewire/dice/dice-interface.h, Dice interface gives no ways
for drivers to get all formats of AMDTP stream. Current ALSA dice driver manage
to generate 'format cache' at unit probing processing, while this requires to
change the state of actual clock on devices. This idea is not good because of
ignoring hardware design. This idea is not good in a case that users save their
favorite configuration to the device. Furthermore, this is not also good in a
case that the stream format is not decided according to sampling transfer
frequency only, i.e. data format of digital interface is also dominant to the
stream format.
These patches add limitation to constrain PCM substream at current sampling
transfer frequency. As a result, userspace applications are allowed to request
according to current sampling transfer frequency. When users change the
frequency, they should use userspace applications with fw character devices to
set it in advance. ALSA dice driver gives no way to achieve it in describes
reasons. Although ALSA dice driver goes backward with these patchset, we don't
beat any actual hardware designs.


[Changes from RFC v1]
 * Patch 03-04 are newly added. This enables to handle bus reset at unit probe
   processing, and drops one of reasons to constrain PCM substreams at current
   sampling transfer frequency.
 * Minor arrangements

Takashi Sakamoto (10):
  ALSA: dice: expand timeout to wait for Dice notification
  ALSA: dice: wait for ensuring phase lock
  ALSA: dice: split subaddress check from category check
  ALSA: dice: postpone probe processing
  ALSA: dice: limit to current sampling transfer frequency
  ALSA: dice: limit stream to current sampling transfer frequency.
  ALSA: dice: add MIDI ports according to current number of MIDI
    substreams
  ALSA: dice: get the number of MBLA data channel at opening PCM
    substream
  ALSA: dice: purge generating channel cache
  ALSA: dice: ensure phase lock before starting streaming

 sound/firewire/dice/dice-midi.c        |  25 +++-
 sound/firewire/dice/dice-pcm.c         | 201 ++++++++-------------------
 sound/firewire/dice/dice-stream.c      |  84 ++++++++----
 sound/firewire/dice/dice-transaction.c | 158 ++++++++++-----------
 sound/firewire/dice/dice.c             | 242 ++++++++++++---------------------
 sound/firewire/dice/dice.h             |  11 +-
 6 files changed, 293 insertions(+), 428 deletions(-)

-- 
2.5.0
