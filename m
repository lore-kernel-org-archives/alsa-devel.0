From: han.lu@intel.com
Subject: [PATCH V2 0/7] BAT: Add Basic Audio Tester command
	line tool
Date: Wed, 23 Sep 2015 15:48:48 +0800
Message-ID: <cover.1442993440.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CCDD82604BD
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 09:51:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@intel.com, bernard.gautier@intel.com, caleb@crome.org, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

BAT (Basic Audio Tester) is a simple command line utility intended
to automate audio driver and sound server QA testing with no human
interaction.

BAT works by playing an audio stream and capturing the same stream
in either a digital or analog loop back. It then compares the captured
stream to the original to determine if the test case passes or fails.

The main idea of frequency detecting is:
The analysis function reads data from WAV file, run FFT against the data
to get magnitude of frequency vectors, and then calculates the average
value and standard deviation of frequency vectors. After that, we define
a threshold:
    threshold = 3 * standard_deviation + average_value
Frequencies with amplitude larger than threshold will be recognized as
a peak, and the frequency with largest peak value will be recognized as
a detected frequency.
BAT then compares the detected frequency to target frequency, to decide
if the detecting passes or fails.

BAT supports 4 working modes:
  1. Single line playback;
  2. Single line capture and analysis;
  3. Playback and capture in loop, and analyze captured data;
  4. Local analyze without actual playback or capture.
BAT will check devices input by user to decide which mode to use.
BAT will create threads for playback and record, and will run spectrum
analysis for mode 2, 3 or 4.

Changes on V2:
	1. Adopt Caleb Crome's method to generate sine signal to avoids
	unwanted distortion on waveform.

Lu, Han (7):
  BAT: Add initial functions
  BAT: Add common definitions and functions
  BAT: Add playback and record functions
  BAT: Add signal generator
  BAT: Add converting functions
  BAT: Add spectrum analysis functions
  BAT: Add Makefile and configures

 Makefile.am     |   3 +
 bat/Makefile.am |  14 ++
 bat/alsa.c      | 594 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat/alsa.h      |  20 ++
 bat/analyze.c   | 314 +++++++++++++++++++++++++++++
 bat/analyze.h   |  16 ++
 bat/bat.c       | 603 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat/common.c    | 198 +++++++++++++++++++
 bat/common.h    | 176 +++++++++++++++++
 bat/convert.c   | 113 +++++++++++
 bat/convert.h   |  23 +++
 bat/signal.c    | 182 +++++++++++++++++
 bat/signal.h    |  30 +++
 configure.ac    |  19 +-
 14 files changed, 2304 insertions(+), 1 deletion(-)
 create mode 100644 bat/Makefile.am
 create mode 100644 bat/alsa.c
 create mode 100644 bat/alsa.h
 create mode 100644 bat/analyze.c
 create mode 100644 bat/analyze.h
 create mode 100644 bat/bat.c
 create mode 100644 bat/common.c
 create mode 100644 bat/common.h
 create mode 100644 bat/convert.c
 create mode 100644 bat/convert.h
 create mode 100644 bat/signal.c
 create mode 100644 bat/signal.h

-- 
1.9.1
