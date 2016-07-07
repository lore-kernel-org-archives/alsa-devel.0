From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib v2 0/3] PCM thread-safety patchset
Date: Thu,  7 Jul 2016 16:40:10 +0200
Message-ID: <20160707144013.23953-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 908572655A5
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 16:40:16 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 47526AC0B
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 14:40:16 +0000 (UTC)
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

here is a v2 patchset for supporting multi thread safety to alsa-lib
PCM API.  Now it's out from RFC and should be reviewed as an official
patchset.

Basically ALSA PCM functions are thread-unsafe, and applications are
supposed to do the proper protection against racy accesses.  The
reality is, however, that application developers don't care such, as
alsa-lib works in most cases.  Of course, users still get occasionally
mysterious crashes.

As a workaround, this patchset adds the pthread mutex protection to
most of exported PCM functions.  This is slightly an overkill, but the
biggest merit is that it's easy to implement; I just wrapped the
functions and replaced the internal ones with unlocked versions.

To be noted, there is an optimization for the direct hw PCM access.
Performance-sensitive applications like JACK should work like before
without any overhead.

Another bonus by this addition is that we can finally get rid of home
brew (and deadly smelling) atomic macros from the tree, since it's now
more widely protected.

I lightly tested on my local machines (dmix, PA, jack and plugins) and
all seem working well, so far.


Takashi

===

v1->v2:
 - Drop locking for some API functions like hw_params
 - Lock some functions even for hw plugin to keep PCM internals
   consistent
 - Fix deadlock with jack ioplug
 - More documentations and comments
 - Add debugging option via $LIBASOUND_THREAD_SAFE=0
 - Reordered patches


Takashi Iwai (3):
  pcm: Add thread-safety to PCM API
  pcm: Remove home brew atomic operations
  pcm: Add LIBASOUND_THREAD_SAFE env variable check

 INSTALL               |   9 ++
 configure.ac          |  15 ++
 include/Makefile.am   |   2 +-
 include/iatomic.h     | 170 --------------------
 include/pcm_ioplug.h  |  10 +-
 src/pcm/Makefile.am   |   2 +-
 src/pcm/atomic.c      |  43 -----
 src/pcm/pcm.c         | 433 +++++++++++++++++++++++++++++++++++++++++---------
 src/pcm/pcm_direct.c  |   4 +-
 src/pcm/pcm_dmix.c    |  13 +-
 src/pcm/pcm_dshare.c  |  13 +-
 src/pcm/pcm_dsnoop.c  |  15 +-
 src/pcm/pcm_file.c    |  21 ++-
 src/pcm/pcm_generic.c |  10 +-
 src/pcm/pcm_hw.c      |   3 +
 src/pcm/pcm_ioplug.c  |  70 +++++---
 src/pcm/pcm_local.h   | 131 +++++++++++----
 src/pcm/pcm_mmap.c    |  18 ++-
 src/pcm/pcm_plugin.c  |  72 ++-------
 src/pcm/pcm_plugin.h  |   2 -
 src/pcm/pcm_rate.c    |  41 ++---
 src/pcm/pcm_route.c   |   2 +-
 22 files changed, 648 insertions(+), 451 deletions(-)
 delete mode 100644 include/iatomic.h
 delete mode 100644 src/pcm/atomic.c

-- 
2.9.0
