From: Vinod Koul <vinod.koul@intel.com>
Subject: [ANNOUNCE] tinycompress: release 0.2.0
Date: Fri, 7 Jun 2013 21:02:01 +0530
Message-ID: <20130607153201.GJ23045@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C8A32610B7
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 18:11:29 +0200 (CEST)
Received: from vkoul-udesk3.iind.intel.com (localhost [127.0.0.1])
 by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
 r57FW5sV005480
 for <alsa-devel@alsa-project.org>; Fri, 7 Jun 2013 21:02:06 +0530
Received: (from vkoul@localhost)
 by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Submit) id r57FW1XQ005478
 for alsa-devel@alsa-project.org; Fri, 7 Jun 2013 21:02:01 +0530
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

Hello folks,

Time to cut another release for the library i am working on.

tinycompress library - the user mode library for using the ALSA compressed APIs
has received following new features and now is v0.2.0
	- support for non blocking I/O
	- support for recording compressed audio content
	- no poll when writing last file buffer
	- get_alsa_rate helper for rate conversion
	- bunch of other fixes
	- now all releases will be tagged accordingly

For details & contributions, pls see the below changelog.

Lakshmi N Vinnakota (1):
      fix error reporting in tinycompress

Richard Fitzgerald (6):
      tinycompress: cplay: Correct a couple of small message typos
      compress: Add support for capture streams
      compress: fix hpointer error when no sample rate
      compress: copy final version of config struct
      compress: do not poll if enough space to write remaining data
      compress: Add non-blocking I/O

Vinod Koul (4):
      compress: check for config first
      add utils file with rate conversion helper
      cplay: use get_alsa_rate to convert sample rate
      Tinycompress version 0.2.0

 Android.mk                          |    2 +-
 compress.c                          |  171 +++++++++++++++++++++++++++--------
 cplay.c                             |   52 ++---------
 include/tinycompress/tinycompress.h |   27 +++++-
 include/tinycompress/version.h      |    4 +-
 makefile.linux                      |    2 +-
 utils.c                             |   96 ++++++++++++++++++++
 7 files changed, 263 insertions(+), 91 deletions(-)
 create mode 100644 utils.c

Thanks
~Vinod
-- 
