From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ALSA: seq: Yet a few more fixes / cleanups
Date: Fri, 12 Apr 2019 14:29:32 +0200
Message-ID: <20190412122935.4092-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DE61F8971C
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 14:29:37 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5BE3FACBC
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 12:29:36 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of fixes / cleanups of ALSA sequencer code,
especially for OSS sequencer layer.  One fix is yet another attempt to
harden against the race of port deletions, while others are for racy
OSS sequencer accesses.


Takashi

===

Takashi Iwai (3):
  ALSA: seq: Cover unsubscribe_port() in list_mutex
  ALSA: seq: Simplify snd_seq_kernel_client_enqueue() helper
  ALSA: seq: Protect racy pool manipulation from OSS sequencer

 include/sound/seq_kernel.h          |  3 +-
 sound/core/seq/oss/seq_oss_device.h | 10 ++++-
 sound/core/seq/oss/seq_oss_rw.c     | 11 ++----
 sound/core/seq/oss/seq_oss_writeq.c |  2 +-
 sound/core/seq/seq_clientmgr.c      | 75 +++++++++++++++++++++----------------
 sound/core/seq/seq_clientmgr.h      |  8 ++--
 sound/core/seq/seq_ports.c          |  2 +-
 7 files changed, 63 insertions(+), 48 deletions(-)

-- 
2.16.4
