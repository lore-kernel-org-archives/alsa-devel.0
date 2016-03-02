From: han.lu@intel.com
Subject: [PATCH 00/10] *** alsabat features and fixes ***
Date: Wed,  2 Mar 2016 16:53:10 +0800
Message-ID: <cover.1456907242.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BFAAC2614D3
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 09:51:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, bernard.gautier@intel.com, edward.c.popescu@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

add alsabat features and some fixes.
	1. add default device name
	2. add standalone mode
	3. add tinyalsa support
	4. add bash script for basic features test on alsa and tinyalsa
	5. refactor alsa thread process to make clearer structure, and
	allow more common functions shared by alsa and tinyalsa
	6. some tiny fixes on code, text and comments

Lu, Han (10):
  alsabat: add default device name for playback and capture
  alsabat: add standalone mode
  alsabat: add tinyalsa support
  alsabat: clean the thread loopback of alsa capture
  alsabat: refactor wav file process
  alsabat: use common data generator function
  alsabat: add interrupt handler for shutdown
  alsabat: fix an incorrect print
  alsabat: use variable for thread return value
  alsabat: add bash test script

 bat/Makefile.am |  14 +-
 bat/alsa.c      | 215 +++++++++--------------------
 bat/alsa.h      |   3 +
 bat/alsabat.1   |  12 ++
 bat/bat.c       |  80 ++++++++++-
 bat/common.c    |  89 ++++++++++++
 bat/common.h    |  14 ++
 bat/testbat.sh  | 160 +++++++++++++++++++++
 bat/tinyalsa.c  | 422 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat/tinyalsa.h  |  23 +++
 configure.ac    |   9 +-
 11 files changed, 883 insertions(+), 158 deletions(-)
 create mode 100644 bat/testbat.sh
 create mode 100644 bat/tinyalsa.c
 create mode 100644 bat/tinyalsa.h

-- 
2.5.0
