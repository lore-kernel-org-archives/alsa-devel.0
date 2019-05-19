From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: firewire-lib: unify tracing events
	for isoc packet
Date: Sun, 19 May 2019 19:01:04 +0900
Message-ID: <20190519100109.14167-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 146AFF89618
 for <alsa-devel@alsa-project.org>; Sun, 19 May 2019 12:01:16 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is for Linux kernel v5.3 development.

ALSA IEC 61883-1/6 packet streaming engine has four types of tracing
events to probe data of handled isochronous packets on IEEE 1394 bus.
The most parameters of data are common independent of type of
isochronous payload and inbound/outbound direction.

This commit unifies the tracing events as 'amdtp_packet'. Instead of
named tracing events, filtering functionality of Linux tracing
framework is available to filter out target events, like:

$ echo 'src == 0xffc0' > /sys/kernel/debug/tracing/events/snd_firewire_lib/amdtp_packet/filter
$ echo 1 > /sys/kernel/debug/tracing/events/snd_firewire_lib/amdtp_packet/enable
$ cat /sys/kernel/debug/tracing/trace
...
...: amdtp_packet: 00 0594 ffc0 ffc1 00 002 00 240 41 1 09 {0x0,0x2,0x0,0xf0,0x90,0x1,0xff,0xff}
...: amdtp_packet: 00 0595 ffc0 ffc1 00 018 08 240 42 1 10 {0x0,0x2,0x0,0xf0,0x90,0x1,0x4b,0x3d}

Takashi Sakamoto (5):
  firewire-lib: use the same type of argument for CIP header for tracing
    event
  firewire-lib: add data_blocks/data_block_counter parameter to
    in_packet/out_packet tracing events
  firewire-lib: use the same unit for payload argument in tracing events
  firewire-lib: use dynamic array for CIP header of tracing events
  firewire-lib: unify tracing events to 'amdtp_packet' event

 sound/firewire/amdtp-stream-trace.h | 163 ++++------------------------
 sound/firewire/amdtp-stream.c       |  16 +--
 2 files changed, 28 insertions(+), 151 deletions(-)

-- 
2.20.1
