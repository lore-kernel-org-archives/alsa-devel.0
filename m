From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC alsa-lib 0/5] Add thread-safety to PCM API
Date: Tue,  5 Jul 2016 17:20:19 +0200
Message-ID: <20160705152024.20152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 63F112666CF
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 17:20:28 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8FC42AC72
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 15:20:27 +0000 (UTC)
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

here is an experimental patchset to add multi thread safety to PCM
functions.  Basically ALSA PCM functions are thread-unsafe, and
applications are supposed to do the proper protection against racy
accesses.  The reality is, however, that application developers don't
care such, as alsa-lib works in most cases.  Of course, users still
get occasionally mysterious crashes.

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

I lightly tested on my local machines and it seems working well, so
far.

Comments and suggestions welcome.


thanks,

Takashi

===

Takashi Iwai (5):
  pcm: Add thread-safety to PCM API
  test: Add pcm-multi-thread program
  Add pcm-multi-thread to .gitignore
  pcm: Remove superfluous rmb() from PCM meter plugin
  pcm: Remove home brew atomic operations

 .gitignore              |   1 +
 configure.ac            |  15 ++
 include/Makefile.am     |   2 +-
 include/iatomic.h       | 170 ------------------
 src/pcm/Makefile.am     |   2 +-
 src/pcm/atomic.c        |  43 -----
 src/pcm/pcm.c           | 468 +++++++++++++++++++++++++++++++++++++++++-------
 src/pcm/pcm_direct.c    |   4 +-
 src/pcm/pcm_dmix.c      |  13 +-
 src/pcm/pcm_dshare.c    |  13 +-
 src/pcm/pcm_dsnoop.c    |  15 +-
 src/pcm/pcm_file.c      |  21 ++-
 src/pcm/pcm_generic.c   |  10 +-
 src/pcm/pcm_hw.c        |   3 +
 src/pcm/pcm_ioplug.c    |  11 +-
 src/pcm/pcm_local.h     |  62 ++++++-
 src/pcm/pcm_meter.c     |   1 -
 src/pcm/pcm_mmap.c      |  16 +-
 src/pcm/pcm_params.c    |   2 +-
 src/pcm/pcm_plugin.c    |  72 ++------
 src/pcm/pcm_plugin.h    |   2 -
 src/pcm/pcm_rate.c      |  41 ++---
 src/pcm/pcm_route.c     |   2 +-
 test/Makefile.am        |   3 +-
 test/pcm-multi-thread.c | 263 +++++++++++++++++++++++++++
 25 files changed, 851 insertions(+), 404 deletions(-)
 delete mode 100644 include/iatomic.h
 delete mode 100644 src/pcm/atomic.c
 create mode 100644 test/pcm-multi-thread.c

-- 
2.9.0
