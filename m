From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 00/17] Enhancement for firewire-lib
Date: Sat, 23 Nov 2013 15:07:47 +0900
Message-ID: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 235D72619D6
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:10 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This series of patch extend functionalities of current firewire-lib:
 - support for both in/out AMDTP stream
 - support for duplex stream synchronization (blocking mode only)
 - support for both MIDI/PCM stream
 - support for both in/out CMP
 - support for some AV/C general commands

Additionally, at the last of this series, some quirks for Fireworks are added.

I'm happy to receive your comments, especially for sort processing.

Takashi Sakamoto (17):
  firewire-lib: Rename functions, structure, member for both direction
  firewire-lib: Add macros instead of fixed value for AMDTP
  firewire-lib: Add 'direction' member to 'amdtp_stream' structure
  firewire-lib: Split some codes into functions to reuse in future
  firewire-lib: Add support for AMDTP transmit stream and PCM capture
  firewire-lib: Add support for MIDI capture/playback
  firewire-lib: give syt value to handle_out_packet()
  firewire-lib: Add support for duplex streams with synchronization
  firewire-lib: Add sort function for transmitted packet
  firewire-lib: Add transfer delay to synchronized duplex streams
  firewire-lib: Add support for channel mapping
  firewire-lib: Rename macros, variables and functions for CMP
  firewire-lib: Add 'direction' member to 'cmp_connection' structure
  firewire-lib: Add handling output connection by CMP
  firewire-lib: Add a new function to check others' connection
  firewire-lib: Add some AV/C general commands
  firewire-lib: Add quirks for Fireworks chipset

 sound/firewire/amdtp.c    | 1014 +++++++++++++++++++++++++++++++++++----------
 sound/firewire/amdtp.h    |  161 +++++--
 sound/firewire/cmp.c      |  217 +++++++---
 sound/firewire/cmp.h      |   14 +-
 sound/firewire/dice.c     |   46 +-
 sound/firewire/fcp.c      |  149 +++++++
 sound/firewire/fcp.h      |   16 +
 sound/firewire/speakers.c |   94 ++---
 8 files changed, 1319 insertions(+), 392 deletions(-)

-- 
1.8.3.2
