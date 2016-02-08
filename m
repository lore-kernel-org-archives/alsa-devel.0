From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/6 v2] ALSA: dice: constrain PCM substreams to
	current sampling transfer frequency
Date: Mon,  8 Feb 2016 22:54:14 +0900
Message-ID: <1454939660-21133-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id D280726071F
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 14:54:26 +0100 (CET)
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

This patchset is to update my former RFCv2 and for merge request to
upstream.

[alsa-devel][RFC][PATCH 00/10 v2] ALSA: dice: stabiliza packet streaming
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/101897.html

Current ALSA Dice driver is written with somewhat ignoring actual hardware
design to perform 'dynamic sample rate selection'. As a result, the driver
includes some behaviors against users' expectation or functional
misleading.

This patchset purges such over-engineering. As a result, userspace
applications can start PCM substreams just at current sampling
transfer frequency. If users want to start at different sampling
rate, they must set favorite rate in advance by tools. Currently,
ffado-mixer with ffado-dbus-server[1] and hinawa-dice-common-cui[2] are
available as such tool.

For technical details, please refer to the post or our discussion in RFCv1:

[alsa-devel] [RFC][PATCH 0/8] ALSA: dice: constrain PCM substreams to current sampling transfer frequency
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100525.html

[1] as a part of FFADO utility
http://subversion.ffado.org/
[2] in hinawa-utils repository
https://github.com/takaswie/hinawa-utils


Regards

Takashi Sakamoto (6):
  ALSA: dice: limit to current sampling transfer frequency
  ALSA: dice: limit stream to current sampling transfer frequency.
  ALSA: dice: add MIDI ports according to current number of MIDI
    substreams
  ALSA: dice: get the number of MBLA data channel at opening PCM
    substream
  ALSA: dice: purge generating channel cache
  ALSA: dice: ensure phase lock before starting streaming

 sound/firewire/dice/dice-midi.c        |  23 +++-
 sound/firewire/dice/dice-pcm.c         | 199 +++++++++------------------------
 sound/firewire/dice/dice-stream.c      |  69 +++++++-----
 sound/firewire/dice/dice-transaction.c |  54 ---------
 sound/firewire/dice/dice.c             |  67 +----------
 sound/firewire/dice/dice.h             |   8 --
 6 files changed, 116 insertions(+), 304 deletions(-)

-- 
2.5.0
