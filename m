From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 0/6] sequencer fixes
Date: Sun, 25 Jan 2015 14:33:21 +0100
Message-ID: <54C4F0A1.2000907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D8895260437
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 14:33:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

One bug fix, and various unimportant cleanups for -next.

 include/sound/seq_kernel.h     |    9 +--------
 sound/core/seq/seq_clientmgr.c |    3 +--
 sound/core/seq/seq_dummy.c     |   31 -------------------------------
 sound/core/seq/seq_ports.c     |    9 +++------
 sound/core/seq/seq_ports.h     |    1 -
 5 files changed, 5 insertions(+), 48 deletions(-)
