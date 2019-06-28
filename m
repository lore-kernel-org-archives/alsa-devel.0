From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: firewire-lib: fix miss detection
	from MIDI conformant data channel in AM824 format for IR context
Date: Fri, 28 Jun 2019 14:53:29 +0900
Message-ID: <20190628055331.1427-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6172F80768
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 07:53:38 +0200 (CEST)
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

This patchset is a fix for a case that AM824 format is used with
non-blocking transmission method in IEC 61883-1/6.

The recent changes for ALSA IEC 61883-1/6 engine brings a bug to miss
received MIDI messages in the case due to wrong data block counter for
calculation of multiplexed MIDI stream index. This bug mainly affects
ALSA oxfw driver.

Takashi Sakamoto (2):
  ALSA: firewire-lib: cache next data_block_counter after probing
    tracepoints event for IR context
  ALSA: firewire-lib: fix to process MIDI conformant data channel for
    AM824 format

 sound/firewire/amdtp-stream.c | 58 +++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

-- 
2.20.1
