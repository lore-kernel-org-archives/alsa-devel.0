From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFT][PATCH 0/4] ALSA: dice: enabled to handle several
	streams
Date: Sat,  5 Mar 2016 20:58:03 +0900
Message-ID: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E97F260881
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 12:58:11 +0100 (CET)
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

This patchset adds support for whole available isochronous streams to ALSA
dice driver. As a result, for some models, additional PCM substreams are
available via subdevice of ALSA PCM character device. In configuration space
of alsa-lib, it's represented like 'hw:0,0,1'(card/device/subdevice).

It's soon in the last week of this developing cycle, while I hope to finish
my work for ALSA dice driver by this patchset. Unfortunately, this patchset
adds huge changes and includes possibilities of regression. I'm happy to
receive your reports to test with any of your Dice units.

For testers, I push whole patches to 'dice-several-streams' branch in my
private repository. The changed driver is available from this branch. I
recommend to use DKMS to maintain the driver, instead of installing by your
own.
https://github.com/takaswie/snd-firewire-improve/tree/dice-several-streams

To check whether your units support several isochronous streams, please
read output from /proc/asound/cardX/dice. When seeing 'tx1' (input) or
'rx1' (output), the additional subdevices are available. For example,

$ arecord -l
...
card 1: Pro26000f5a [Pro26-000f5a], device 0: DICE [Pro26-000f5a]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

In above case, you can use two subdevices for PCM capture, thus:
 * arecord -D plughw:1,0,0 file1.wav
 * arecord -D plughw:1,0,1 file2.wav

In the middle of next week, I plan to post this patchset again for
merging. So it's nice to test till then.


Regards

Takashi Sakamoto (4):
  ALSA: dice: have two sets of isochronous resources/streams
  ALSA: dice: handle whole available isochronous streams
  ALSA: dice: handle several PCM substreams when any isochronous streams
    are available
  ALSA: dice: force to add two pcm devices for listed models

 sound/firewire/dice/dice-midi.c   |   8 +-
 sound/firewire/dice/dice-pcm.c    | 110 +++++++----
 sound/firewire/dice/dice-stream.c | 400 ++++++++++++++++++++++++--------------
 sound/firewire/dice/dice.c        |  41 ++++
 sound/firewire/dice/dice.h        |  33 +++-
 5 files changed, 401 insertions(+), 191 deletions(-)

-- 
2.7.0
