From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3 v3] firewire-lib: support tracepoints to
	dump a part of packet data
Date: Mon,  9 May 2016 21:12:43 +0900
Message-ID: <1462795966-13445-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F8002654D4
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 14:12:50 +0200 (CEST)
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

This patchset updates my RFCv2, and go for merging.

[alsa-devel] [RFC][PATCH 0/3 v2] firewire-lib: support Linux tracing framework
to dump a part of packet data
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-April/106950.html

The motivation of this patchset is to check the sequence of packet from/to
audio and music units on IEEE 1394 bus. When the units have some quirks or
ALSA firewire stack includes some bugs, we can work to seek them with Linux
tracing framework.

Changes:
 - Improve commit comments.
 - Improve Python3 script in commit comment for NODATA/NOINFO packets.
 - Move the position of trace_out_acket() so that the index of packet starts 0.

Takashi Sakamoto (3):
  ALSA: firewire-lib: compute the value of second field in cycle count
    for IT context
  ALSA: firewire-lib: compute the value of second field in cycle count
    for IR context
  ALSA: firewire-lib: add tracepoints to dump a part of isochronous
    packet data

 sound/firewire/Makefile             |  3 ++
 sound/firewire/amdtp-stream-trace.h | 98 +++++++++++++++++++++++++++++++++++++
 sound/firewire/amdtp-stream.c       | 77 ++++++++++++++++++++++-------
 3 files changed, 160 insertions(+), 18 deletions(-)
 create mode 100644 sound/firewire/amdtp-stream-trace.h

-- 
2.7.4
