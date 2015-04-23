From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/8] Proc file cleanups
Date: Thu, 23 Apr 2015 16:49:22 +0200
Message-ID: <1429800570-10153-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 58563261B23
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:49:38 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 114F4ACA3
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 14:49:38 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

here is a series of patches for cleaning up the ALSA proc file
management code.  The biggest change is the use of seq_file for text
reads, but all are internal and the API is kept intact.

The rest are mostly small cleanups and refactoring.

The patches are found in topic/proc branch of sound git tree.


Takashi

===

Takashi Iwai (8):
  ALSA: core: Use seq_file for text proc file reads
  ALSA: core: Fix possible memory leaks at error path in info.c
  ALSA: core: Remove child proc file elements recursively
  ALSA: core: Manage asound root directory with snd_info_entry
  ALSA: core: Remove superfluous exit calls for proc entries
  ALSA: core: Don't ignore errors at creating proc files
  ALSA: core: Build conditionally and remove superfluous ifdefs
  ALSA: core: Clean up OSS proc file management

 include/sound/core.h      |   4 -
 include/sound/info.h      |  29 +-
 sound/core/Makefile       |   8 +-
 sound/core/info.c         | 779 ++++++++++++++++++----------------------------
 sound/core/info_oss.c     |  29 +-
 sound/core/init.c         |  33 +-
 sound/core/seq/Makefile   |   3 +-
 sound/core/seq/seq_info.c |  19 +-
 sound/core/sound.c        |  24 +-
 sound/core/sound_oss.c    |  30 +-
 10 files changed, 373 insertions(+), 585 deletions(-)

-- 
2.3.5
