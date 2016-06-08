From: han.lu@intel.com
Subject: [PATCH 0/4] alsabat: add noise detection
Date: Thu,  9 Jun 2016 03:42:45 +0800
Message-ID: <cover.1465404865.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 148D62656EB
 for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2016 13:46:37 +0200 (CEST)
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

Add noise detection for alsabat.
Alsabat reports error when noise above threshold be detected.
Use either of the options below to designate the threshold. (e.g.
if the ratio of noise to signal is 5%, the snr is about 26dB.)
    --snr-db <value in dB>
    --snr-pc <value in %>

The noise detection is performed in time domain. On each period
of the sine wave being analyzed, alsabat substracts a clean sine
wave from the source, calculates the RMS value of the residual,
and compares the result with the threshold. At last, alsabat
returns the number of periods with noise above threshold. 0 is
returned when the source is clean.

patch content:
  1. align the data type and process on float
  2. add a parameter for adjust_waveform()
  3. add a single channel sine wave generator
  4. add noise detection

Lu, Han (4):
  alsabat: align the data type on float
  alsabat: add channels parameter for adjust_waveform()
  alsabat: add a single channel sine wave generator
  alsabat: add noise detection

 bat/alsabat-test.sh |   4 +
 bat/alsabat.1       |   8 ++
 bat/analyze.c       | 216 +++++++++++++++++++++++++++++++++++++++++++++++-----
 bat/bat-signal.h    |   1 +
 bat/bat.c           |  62 ++++++++++++---
 bat/common.h        |  36 ++++++++-
 bat/convert.c       |   8 +-
 bat/convert.h       |   8 +-
 bat/signal.c        |  27 ++++++-
 configure.ac        |   2 +-
 10 files changed, 327 insertions(+), 45 deletions(-)

-- 
2.5.0
