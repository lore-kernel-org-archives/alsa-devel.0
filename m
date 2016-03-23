From: han.lu@intel.com
Subject: [PATCH V3 0/6] alsabat: clean structure and tinyalsa
	support
Date: Wed, 23 Mar 2016 15:52:41 +0800
Message-ID: <cover.1458718230.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D84C2612AE
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 08:51:22 +0100 (CET)
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

 1. Refactoring alsa process to make structure simpler and cleaner,
 use general functions and unified return value for convenience of
 maintaining;
 2. Add tinyalsa support, user can choose tinyalsa with "configure
  --enable-alsabat-backend-tiny" option. By default ALSA lib is used.
 The intention is for alsabat to run on tinyalsa platforms such as
 Android and some IoT devices.

 changes on v3:
   1. use option "--enable-alsabat-backend-tiny" instead of
   "--enable-tinyalsa" to avoid ambiguous.
   2. fix inconsistent in man page and configure.ac.
 changes on v2:
   1. add more description to explain the purpose of each patch.
   2. use configure option to select tinyalsa, rather than auto detect
   environment and decide.

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
