From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 0/2] cuse: implement mmap/munmap
Date: Fri, 13 Jan 2012 18:06:37 +0100
Message-ID: <1326474399-27278-1-git-send-email-miklos@szeredi.hu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, htejun@gmail.com, david.henningsson@canonical.com, smcnam@gmail.com, gmane@colin.guthr.ie, jamescaldwell1@gmail.com, s.maddox@lantizia.me.uk, mszeredi@suse.cz
List-Id: alsa-devel@alsa-project.org

These patches implement mmap support for CUSE (character device in userspace).

The immediate application for this is to get old games requiring OSS/mmap
support to work with OSS Proxy, written by Tejun.  So firstly this is a call for
testers; please try this out and report any problems.

Three pieces are needed:

kernel:
  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next

fuse:
  git://fuse.git.sourceforge.net/gitroot/fuse/fuse master

osspd:
  git://fuse.git.sourceforge.net/gitroot/fuse/osspd master


Comments about the interface and implementation in general (not related to OSS
proxy) are very welcome as well.

Thanks,
Miklos

---
Miklos Szeredi (1):
      fuse: create fuse_conn_operations

Tejun Heo (1):
      cuse: implement memory mapping

---
 fs/fuse/cuse.c       |  426 +++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/dev.c        |  155 ++-----------------
 fs/fuse/fuse_i.h     |   35 ++++-
 fs/fuse/inode.c      |  167 +++++++++++++++++++-
 include/linux/fuse.h |   25 +++
 5 files changed, 656 insertions(+), 152 deletions(-)
