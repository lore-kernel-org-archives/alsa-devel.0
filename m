From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: firewire-lib: fixes for processing
	packets without CIP header
Date: Sat, 15 Dec 2018 19:03:18 +0900
Message-ID: <20181215100321.1658-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 250A7267A8E
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2018 11:03:49 +0100 (CET)
Received: by mail-pl1-f193.google.com with SMTP id gn14so3876900plb.10
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2018 02:03:49 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

In kernel v4.12, a series of patch was applied to IEC 61883-1/6 packet
streaming engine in ALSA firewire stack to process isochronous packet
without CIP header. But this included some bugs. Especially, for capture
PCM substream, the engine handles PCM frames for applications as four
times against real time.

This patchset fixes the bugs.

Takashi Sakamoto (3):
  ALSA: firewire-lib: fix wrong handling payload_length as
    payload_quadlet
  ALSA: firewire-lib: fix wrong assignment for
    'out_packet_without_header' tracepoint
  ALSA: firewire-lib: use the same print format for 'without_header'
    tracepoints

 sound/firewire/amdtp-stream-trace.h | 4 ++--
 sound/firewire/amdtp-stream.c       | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.19.1
