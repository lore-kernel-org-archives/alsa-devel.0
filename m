From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/8] A new driver for OXFW970/971 based
	devices
Date: Sun,  5 Jan 2014 20:13:29 +0900
Message-ID: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D033265174
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 12:13:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This series of patch is based on my previous series below:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070424.html

This series of patch add a new driver, snd-oxfw, for OXFW970/971 based devices.
These chipsets are already supported by snd-firewire-speakers but this new
driver aim to support recording equipment.

Current supported devices:
 * Behringer F-Control Audio 202
 * Mackie Onyx-i series (former model)
 * Mackie Onyx Satellite

Devices possible to be supported if identifying IDs:
 * Mackie, d.2 pro
 * Mackie, d.4 pro
 * Mackie, U.420
 * Mackie, U.420d
 * Mackie, Tapco Link.Firewire

I worked with Behringer F-Control Audio 202. So I want someone to test with the other devices, especially about some quirks.


Clemens, would you gime me your opinions about issues below?
And if you know something about this chipset, would you share the information?

1.snd-firewire-speakers and snd-oxfw
With this series of patches, ALSA has two drivers for the same chipsets.
Merging these two drivers is a bit difficult because:
 - snd-firewire-speakers has control interface but snd-oxfw don't
 - snd-firewire-speakers don't support in-stream but snd-oxfw supports

2.currently snd-oxfw works with streams in SYT-Match
Due to invalid sequence of 'presentation timestamp' in transmitted packets.
In detail, please see 4th patch.

3.assumption of channnel formation
Some commands may not be implemented.
In detail, please see 3rd patch.

4.don't check source of clock
All of supported devices (including can be) don't have the functionality to switch source of clock. So I want to omit this.

For issue 3 and 4, Descriptor mechanism in 'Enhancements to the AV/C General
Specification 3.0 Version 1.1' may be a best solution but it costs much to implement against the number of available devices. I want to avoid this huge mechanism if possible.


Regards

Takashi Sakamoto

Takashi Sakamoto (8):
  oxfw: Add skelton for OXFW970/971 based devices
  oxfw: Read firmware version to name card
  oxfw: Add some AV/C commands for channel formation of AMDTP stream
  oxfw: Add connections and streams management
  oxfw: Add proc interface for debugging purpose
  oxfw: Add MIDI interface
  oxfw: Add PCM interface
  oxfw: Add hwdep interface

 include/uapi/sound/asound.h        |   3 +-
 include/uapi/sound/firewire.h      |   3 +-
 sound/firewire/Kconfig             |  17 +
 sound/firewire/Makefile            |   1 +
 sound/firewire/oxfw/Makefile       |   3 +
 sound/firewire/oxfw/oxfw.c         | 243 ++++++++++++++
 sound/firewire/oxfw/oxfw.h         | 140 ++++++++
 sound/firewire/oxfw/oxfw_command.c | 161 ++++++++++
 sound/firewire/oxfw/oxfw_hwdep.c   | 197 ++++++++++++
 sound/firewire/oxfw/oxfw_midi.c    | 156 +++++++++
 sound/firewire/oxfw/oxfw_pcm.c     | 421 ++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw_proc.c    |  61 ++++
 sound/firewire/oxfw/oxfw_stream.c  | 639 +++++++++++++++++++++++++++++++++++++
 13 files changed, 2043 insertions(+), 2 deletions(-)
 create mode 100644 sound/firewire/oxfw/Makefile
 create mode 100644 sound/firewire/oxfw/oxfw.c
 create mode 100644 sound/firewire/oxfw/oxfw.h
 create mode 100644 sound/firewire/oxfw/oxfw_command.c
 create mode 100644 sound/firewire/oxfw/oxfw_hwdep.c
 create mode 100644 sound/firewire/oxfw/oxfw_midi.c
 create mode 100644 sound/firewire/oxfw/oxfw_pcm.c
 create mode 100644 sound/firewire/oxfw/oxfw_proc.c
 create mode 100644 sound/firewire/oxfw/oxfw_stream.c

-- 
1.8.3.2
