From: Vinod Koul <vinod.koul@intel.com>
Subject: [ANNOUNCE]: tinycompress: release 0.1.0
Date: Sun, 24 Feb 2013 20:20:43 +0530
Message-ID: <20130224145043.GE23711@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 76C4F2650BD
 for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2013 15:51:16 +0100 (CET)
Received: from vkoul-udesk3.iind.intel.com (localhost [127.0.0.1])
 by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
 r1OEoivY003860
 for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2013 20:20:44 +0530
Received: (from vkoul@localhost)
 by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Submit) id r1OEoh7A003859
 for alsa-devel@alsa-project.org; Sun, 24 Feb 2013 20:20:43 +0530
Content-Disposition: inline
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

tinycompress library - the user mode library for using the ALSA compressed APIs
has seen some good testing, which brings few fixes and new feature for gapless
playback. This library supports both Android and Linux OSes.  Along with we have
a player, cplay- which can be used for mp3 offload playback Number of fixes and
cleanups along the way as seen by below changelog and diffstat.

So time to bump up the version to 0.1.0

Charles Keepax (4):
      compress: Extend limit on error messages
      compress: Return error when failing to allocate compress struct
      compress: Return error messages correctly from compress_open
      compress: Do not put newlines on error messages

Namarta Kohli (1):
      compress: add compress_resume

Richard Fitzgerald (12):
      compress: Add function to get timestamp in samples
      compress: Change compress_write() to take buffer as const void *
      compress: Remove unused buffer_size member from struct compress
      compress: Change running from bitfield to plain int
      compress: Fix incorrect error message on compress_resume()
      compress: Remove hardcoded limit on length of poll() wait
      compress: Handle case of pause() during compress_write()
      compress: Allow client to pass "don't care" for fragment size/number
      compress: Block if unable to write all data in single write()
      compress: Add missing header includes
      compress: Add makefile for building under standard linux
      cplay: support auto-configuration of fragment size and count

Vinod Koul (9):
      initial creation
      compress: fix the timestamp calculation
      compress: write when we have a fragment to write
      compress: make variable 'running' as unsigned
      compress: remove unused variables
      compress: cache the config values passed
      tinycompress: add gapless meta data APIs
      tinycompres: remove unused variable
      tinycompress: version 0.1.0

Xuemin Su (1):
      compress: fix arithmetic exception in compress_get_hpointer

 Android.mk                          |   22 ++
 README                              |   31 ++-
 compress.c                          |  539 +++++++++++++++++++++++++++++++++++
 cplay.c                             |  368 ++++++++++++++++++++++++
 include/sound/compress_offload.h    |   95 ++++++
 include/sound/compress_params.h     |  230 +++++++++++++++
 include/tinycompress/tinycompress.h |  270 ++++++++++++++++++
 include/tinycompress/tinymp3.h      |  106 +++++++
 include/tinycompress/version.h      |   70 +++++
 makefile.linux                      |   35 +++
 10 files changed, 1765 insertions(+), 1 deletions(-)
 create mode 100644 Android.mk
 create mode 100644 compress.c
 create mode 100644 cplay.c
 create mode 100644 include/sound/compress_offload.h
 create mode 100644 include/sound/compress_params.h
 create mode 100644 include/tinycompress/tinycompress.h
 create mode 100644 include/tinycompress/tinymp3.h
 create mode 100644 include/tinycompress/version.h
 create mode 100644 makefile.linux

--
~Vinod
