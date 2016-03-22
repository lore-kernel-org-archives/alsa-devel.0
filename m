From: han.lu@intel.com
Subject: [PATCH V2 0/6] alsabat: clean structure and tinyalsa
	support
Date: Tue, 22 Mar 2016 22:31:32 +0800
Message-ID: <cover.1458655876.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 691C7260711
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 15:30:13 +0100 (CET)
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

 1. refactoring alsa process to make structure simpler and cleaner,
 use general functions and unified return value for convenience of
 maintaining;
 2. add tinyalsa support, user can choose tinyalsa with "configure
  --enable-tinyalsa" option. By default ALSA lib is used. The purpose
 is for alsabat to run on tinyalsa platforms such as Android and some
 IoT devices.

Lu, Han (6):
  alsabat: refactoring alsa capture thread
  alsabat: use general function for wav header update
  alsabat: clean return value for playback and capture threads
  alsabat: use general data generator function
  alsabat: move alsa process to a single block
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
 configure.ac    |  17 +++
 10 files changed, 711 insertions(+), 174 deletions(-)
 create mode 100644 bat/tinyalsa.c
 create mode 100644 bat/tinyalsa.h

-- 
2.5.0
