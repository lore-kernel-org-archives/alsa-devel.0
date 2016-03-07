From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: dice: enable to handle several
	streams
Date: Mon,  7 Mar 2016 22:35:41 +0900
Message-ID: <1457357745-24756-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id B2089261584
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 14:35:49 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset updates my previous RFT, and goes for merging.
[alsa-devel] [RFT][PATCH 0/4] ALSA: dice: enabled to handle several streams
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105387.html

For the previous one, Stefan Richter worked as a tester with his devices
(Focusrite Saffire Pro 24 and 40), while current patchset includes changes
related to userspace interface. Therefore, I don't add Tested-by.


In previous one, ALSA dice driver uses subdevice for userspace to access
any PCM substreams. On the other hand, the design of PCM subdevice leaves
a bit cumbersome for userspace to handle several subdevices simultaneously
in one process. These PCM substreams on a batch of AMDTP streams and it's
better for ALSA dice driver to enable one process to handle them with
simpler way.

Based on this concept, this patchset adds PCM character devices, instead of
PCM subdevice. Thus, userspace applications can utilize PCM substreams via
individual PCM character devices. In configuration space of alsa-lib, via
'hw:0,0' and 'hw:0,1' if available, like:

$ arecord -l
...
card 1: Pro26000f5a [Pro26-000f5a], device 0: DICE [Pro26-000f5a]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Pro26000f5a [Pro26-000f5a], device 1: DICE [Pro26-000f5a]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


For the other parts, there's no code changes. Therefore, Stefan's result
still has meanings.

Changes:
 * Add additional PCM character device instead of PCM subdevice
 * Correct string entries to force-pcm
 * Improve comments

Takashi Sakamoto (4):
  ALSA: dice: have two sets of isochronous resources/streams
  ALSA: dice: handle whole available isochronous streams
  ALSA: dice: handle several PCM substreams when any isochronous streams
    are available
  ALSA: dice: force to add two pcm devices for listed models

 sound/firewire/dice/dice-midi.c   |   8 +-
 sound/firewire/dice/dice-pcm.c    | 147 +++++++++-----
 sound/firewire/dice/dice-stream.c | 398 ++++++++++++++++++++++++--------------
 sound/firewire/dice/dice.c        |  41 ++++
 sound/firewire/dice/dice.h        |  33 +++-
 5 files changed, 424 insertions(+), 203 deletions(-)

-- 
2.7.0
