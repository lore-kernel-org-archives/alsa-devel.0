From: han.lu@intel.com
Subject: [PATCH 0/3] *** new features for alsabat ***
Date: Tue, 15 Mar 2016 11:18:51 +0800
Message-ID: <cover.1458011641.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DDF3B2605CA
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 04:17:08 +0100 (CET)
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

Add 3 features for alsabat:
    1. add default device name for playback and capture
    2. add standalone mode, to bypass data analysis
    3. add bash test script to cover basic alsabat features

Lu, Han (3):
  alsabat: add default device name for playback and capture
  alsabat: add standalone mode
  alsabat: add bash test script

 bat/Makefile.am     |  13 +++---
 bat/alsa.c          |  12 ------
 bat/alsabat-test.sh | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat/alsabat.1       |   9 +++++
 bat/bat.c           |  18 ++++++++-
 bat/common.h        |   3 ++
 configure.ac        |   5 ++-
 7 files changed, 153 insertions(+), 19 deletions(-)
 create mode 100755 bat/alsabat-test.sh

-- 
2.5.0
