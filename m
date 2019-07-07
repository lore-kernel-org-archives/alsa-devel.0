From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/7] ALSA: firewire-lib: some fixes for
	tracepoints events
Date: Sun,  7 Jul 2019 21:07:52 +0900
Message-ID: <20190707120759.16371-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E7C2F800E6
 for <alsa-devel@alsa-project.org>; Sun,  7 Jul 2019 14:08:07 +0200 (CEST)
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

This kernel module, firewire-lib, adds 'amdtp_packet' tracepoints events
to Linux system. After heavy code refactoring for v5.3, some event
parameters include invalid values. This patchset is to fix them, and
the last part of my refactoring work in this development period.

Takashi Sakamoto (7):
  ALSA: firewire-lib: fix invalid length of tx packet payload for
    tracepoint events
  ALSA: firewire-lib/ficeface: fix initial value of data block counter
    for IR context with CIP_NO_HEADER
  ALSA: firewire-lib: fix initial value of data block count for IR
    context without CIP_DBC_IS_END_EVENT
  ALSA: firewire-lib: fix different data block counter between probed
    event and transferred isochronous packet
  ALSA: firewire-lib: code refactoring for error path of parser for CIP
    header
  ALSA: firewire-lib: code refactoring for post operation to data block
    counter
  ALSA: firewire-lib: code refactoring for local variables

 sound/firewire/amdtp-stream.c | 59 ++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 28 deletions(-)

-- 
2.20.1
