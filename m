From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] More hardening for ALSA sequencer
	write/ioctl races
Date: Thu,  8 Mar 2018 08:18:54 +0100
Message-ID: <20180308071856.12149-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 99819267403
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 08:18:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: =?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>, Nicolai Stange <nstange@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

here is two patches to paper over the still remaining races in ALSA
sequencer write and ioctl that have been leaked in the previous fix
for CVE-2018-1000004.

The reports came up totally individually, so both people are put as
Reported-by tag here.


thanks,

Takashi

===

Takashi Iwai (2):
  ALSA: seq: Don't allow resizing pool in use
  ALSA: seq: More protection for concurrent write and ioctl races

 sound/core/seq/seq_clientmgr.c | 21 ++++++++++++++-------
 sound/core/seq/seq_fifo.c      |  2 +-
 sound/core/seq/seq_memory.c    | 14 ++++++++++----
 sound/core/seq/seq_memory.h    |  3 ++-
 4 files changed, 27 insertions(+), 13 deletions(-)

-- 
2.16.2
