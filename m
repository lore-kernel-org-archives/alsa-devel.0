From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/11] ALSA: dice: use cache of stream formats
	to generate PCM rules/constraints
Date: Wed, 25 Apr 2018 08:42:23 +0900
Message-ID: <20180424234234.6063-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 513482676AD
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 01:43:10 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id g14so13570238pfh.3
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 16:43:10 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Once, ALSA dice driver cached stream formats to generate PCM
constraints/rules. The cache is created by changing current
sampling transmission frequency step by step directly at unit
probing process. This feature was dropped because it changes
state of clock on target device thus it's against users'
expectation[1].

However this is not necessarily convenient because reconfiguration
of sampling rate is not available.

TC Applied Technologies (TCAT) has extended protocol for DICE
interface, a.k.a EAP (Extended Application Protocol). In this
extension, drivers can retrieve information of stream formats
without changing state of target unit. Fortunately, this protocol
is supported widely by many models.

This patchset regain the cache to generate PCM constraints/rules
by using this protocol. Userspace applications can reconfigure
sampling rate via ALSA PCM interface.

For units which doesn't support the extension, available set of
sampling rate is still restricted at current sampling transmission
frequency. This is also inconvenient and this patchset introduces a
solution.

Structure for unit entry (struct ieee1394_device_id) has a member
for unit-specific data. This patchset uses it for callback function
to handle hard-coded stream format. In this time, I adopt this way
for some known models produced by TC Electronic and Alesis. If users
find their models still have restrictions in a point of available
sampling transmission frequency, it's preferable to work for this
way.

[1] [alsa-devel] [PATCH 0/6 v2] ALSA: dice: constrain PCM substreams to current sampling transfer frequency
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/104065.html
[2] [alsa-devel] [PATCH] ALSA: dice: fix OUI for TC group
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-April/134804.html

Takashi Sakamoto (11):
  ALSA: dice: add cache of stream formats
  ALSA: dice: add 'firewire' directory for proc nodes
  ALSA: dice: add proc node for stream formation
  ALSA: dice: cache stream formats at current mode of sampling
    transmission frequency
  ALSA: dice: enable to change current sampling transmission frequency
  ALSA: dice: use cache for PCM constraints and rules
  ALSA: dice: use stream formats to add MIDI substreams
  ALSA: dice: add parameters of stream formats for models produced by TC
    Electronic
  ALSA: dice: add parameters of stream formats for models produced by
    Alesis
  ALSA: dice: use extended protocol to detect available stream formats
  ALSA: dice: remove local frag of force_two_pcms

 sound/firewire/dice/Makefile            |   3 +-
 sound/firewire/dice/dice-alesis.c       |  48 +++++++
 sound/firewire/dice/dice-extension.c    | 155 +++++++++++++++++++++
 sound/firewire/dice/dice-midi.c         |  23 +---
 sound/firewire/dice/dice-pcm.c          | 230 ++++++++++++++++++++++----------
 sound/firewire/dice/dice-proc.c         |  70 +++++++++-
 sound/firewire/dice/dice-stream.c       | 116 +++++++++++++++-
 sound/firewire/dice/dice-tcelectronic.c | 100 ++++++++++++++
 sound/firewire/dice/dice.c              | 137 ++++++++++++-------
 sound/firewire/dice/dice.h              |  17 ++-
 10 files changed, 753 insertions(+), 146 deletions(-)
 create mode 100644 sound/firewire/dice/dice-alesis.c
 create mode 100644 sound/firewire/dice/dice-extension.c
 create mode 100644 sound/firewire/dice/dice-tcelectronic.c

-- 
2.14.1
