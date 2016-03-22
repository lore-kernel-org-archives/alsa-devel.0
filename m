From: han.lu@intel.com
Subject: [PATCH 0/6] *** alsabat: clean structure and tinyalsa
	support ***
Date: Tue, 22 Mar 2016 13:10:23 +0800
Message-ID: <cover.1458623090.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A874126516A
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 06:09:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

1. Clean structure, use general function to replace local processes.
2. Add tinyalsa support, configure will read environment and decide to
link to ALSA lib or tinyalsa lib.

Lu, Han (6):
  alsabat: clean file process on capture thread loop
  alsabat: use common wav process function in playback loop
  alsabat: clean return value of playback and capture loops
  alsabat: use common data generator function
  alsabat: move alsa process to alsa.c
  alsabat: add tinyalsa support

 bat/Makefile.am |  12 +-
 bat/alsa.c      | 217 +++++++++++---------------
 bat/alsabat.1   |   3 +
 bat/bat.c       |  58 +++----
 bat/common.c    |  68 +++++++++
 bat/common.h    |  17 ++-
 bat/signal.c    |  13 +-
 bat/tinyalsa.c  | 460 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat/tinyalsa.h  |  20 +++
 configure.ac    |   4 +
 10 files changed, 698 insertions(+), 174 deletions(-)
 create mode 100644 bat/tinyalsa.c
 create mode 100644 bat/tinyalsa.h

-- 
2.5.0
