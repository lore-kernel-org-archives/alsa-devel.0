From: Joe Perches <joe@perches.com>
Subject: [PATCH 0/8] Rework KERN_<LEVEL>
Date: Tue,  5 Jun 2012 02:46:29 -0700
Message-ID: <cover.1338889066.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 03B41245B4
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 11:46:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org
Cc: devel@driverdev.osuosl.org, Andrew Morton <akpm@linux-foundation.org>, Kay Sievers <kay@vrfy.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

KERN_<LEVEL> currently takes up 3 bytes.
Shrink the kernel size by using an ASCII SOH and then the level byte.
Remove the need for KERN_CONT.
Convert directly embedded uses of <.> to KERN_<LEVEL>

Joe Perches (8):
  printk: Add generic functions to find KERN_<LEVEL> headers
  printk: Add kern_levels.h to make KERN_<LEVEL> available for asm use
  arch: Remove direct definitions of KERN_<LEVEL> uses
  btrfs: Use printk_get_level and printk_skip_level, add __printf, fix fallout
  sound: Use printk_get_level and printk_skip_level
  staging: wlags49_h2: Remove direct declarations of KERN_<LEVEL> prefixes
  printk: Convert the format for KERN_<LEVEL> to a 2 byte pattern
  printk: Remove the now unnecessary "C" annotation for KERN_CONT

 arch/arm/lib/io-acorn.S              |    3 +-
 arch/arm/vfp/vfphw.S                 |    7 +++--
 arch/frv/kernel/kernel_thread.S      |    2 +-
 drivers/staging/wlags49_h2/hcf.c     |    8 +++---
 drivers/staging/wlags49_h2/wl_main.c |    4 +-
 fs/btrfs/ctree.h                     |   13 ++++++++++
 fs/btrfs/disk-io.c                   |    2 +-
 fs/btrfs/relocation.c                |    2 +-
 fs/btrfs/super.c                     |   41 +++++++++++++++++++++++++++++-----
 include/linux/kern_levels.h          |   25 ++++++++++++++++++++
 include/linux/printk.h               |   41 +++++++++++++++++++--------------
 kernel/printk.c                      |   14 +++++++----
 sound/core/misc.c                    |   13 +++++++---
 13 files changed, 130 insertions(+), 45 deletions(-)
 create mode 100644 include/linux/kern_levels.h

-- 
1.7.8.111.gad25c.dirty
