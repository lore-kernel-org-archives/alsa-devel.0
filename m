From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: fireworks/bebob/dice/oxfw: fix kernel oops at
	unplugging during streaming
Date: Sat, 21 Feb 2015 23:54:56 +0900
Message-ID: <1424530500-9116-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Each FireWire sound driver causes kernel oops at unplugging during
streaming. This bug affects:
 - snd-bebob (in 3.16 or later)
 - snd-fireworks (in 3.16 or later)
 - snd-dice (in 3.19 or later)
 - snd-oxfw (in 3.19 or later)

When streaming, any ALSA character devices are opened and sound card
object is referred. Then 'struct snd_card.private_free()' is not executed
in a context of 'struct fw_driver.remove()'. It's executed in a context of
an application process in which the last ALSA character device is closed.
In this case, any operation to instances of FireWire unit is invalid
because it's already released, and causes kernel oops. I confirm GPF or
Null-pointer-dereference.

To fix this problem, this patchset do:
1.delegate reference counting of an instance of FireWire unit from AMDTP
  helper functions to each driver, then do it in
  'struct snd_card.private_free()'.
2.move stream or transaction destructor from 'struct fw_driver.remove()'
  to 'struct snd_card.private_free()'.

With this patchset, each driver keeps a reference to FireWire unit till
all of ALSA applications close its character devices. This may be against
IEEE 1394 bus driver developers' expectation to high-level drivers.

Takashi Sakamoto (4):
  ALSA: fireworks/bebob/dice/oxfw: add reference-counting for FireWire
    unit
  ALSA: firewire-lib: remove reference counting
  ALSA: fireworks/bebob/dice/oxfw: allow stream destructor after
    releasing runtime
  ALSA: fireworks/bebob/dice/oxfw: make it possible to shutdown safely

 sound/firewire/amdtp.c                      |  3 +--
 sound/firewire/bebob/bebob.c                | 20 ++++++++++++++++----
 sound/firewire/bebob/bebob_stream.c         | 16 ++++------------
 sound/firewire/dice/dice-stream.c           | 18 ++++++++++++------
 sound/firewire/dice/dice.c                  | 16 +++++++++++-----
 sound/firewire/fireworks/fireworks.c        | 20 ++++++++++++++------
 sound/firewire/fireworks/fireworks_stream.c | 19 ++++++++++---------
 sound/firewire/oxfw/oxfw-stream.c           |  6 ++++--
 sound/firewire/oxfw/oxfw.c                  | 21 ++++++++++++++-------
 9 files changed, 86 insertions(+), 53 deletions(-)

-- 
2.1.0


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
