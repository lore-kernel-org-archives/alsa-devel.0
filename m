From: focus.luo@linux.intel.com
Subject: [PATCH v2 0/2] alsabat: test scripts and reference
	amixer config files
Date: Mon, 15 Aug 2016 13:24:03 +0800
Message-ID: <1471238645-12554-1-git-send-email-focus.luo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 44AD3265857
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 06:56:28 +0200 (CEST)
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
Cc: Focus Luo <focus.luo@linux.intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Focus Luo <focus.luo@linux.intel.com>

The patch set supplies some automated test scripts and reference amixer config
files for linux audio driver testing by using alsa-bat as test tool on Intel
platforms.

The first patch includes automated test scripts for linux audio driver based
on alsa-lib interface by using alsabat as test tool. It supports analog audio
and display audio(HDMI/DP) interface.

The second patch supplies some amixer reference config file on Intel platforms.

Focus Luo (2):
  alsabat: automation test scripts
  alsabat: add amixer config files

 bat/Makefile.am                                |   1 +
 bat/tests/Makefile.am                          |  11 +
 bat/tests/README                               |  32 ++
 bat/tests/alsabat_main.sh                      | 178 ++++++++++
 bat/tests/analog_audio_playback_and_capture.sh |  84 +++++
 bat/tests/asound_state/Makefile.am             |   6 +
 bat/tests/asound_state/asound.state.Broadwell  | 439 +++++++++++++++++++++++++
 bat/tests/asound_state/asound.state.Haswell    | 342 +++++++++++++++++++
 bat/tests/asound_state/asound.state.Skylake    | 437 ++++++++++++++++++++++++
 bat/tests/dp_audio_playback.sh                 |  83 +++++
 bat/tests/dp_audio_subdevice_number.sh         |  68 ++++
 bat/tests/hdmi_audio_playback.sh               |  81 +++++
 bat/tests/hdmi_audio_subdevice_number.sh       |  65 ++++
 bat/tests/map_test_case                        |   8 +
 configure.ac                                   |   3 +-
 15 files changed, 1837 insertions(+), 1 deletion(-)
 create mode 100644 bat/tests/Makefile.am
 create mode 100644 bat/tests/README
 create mode 100755 bat/tests/alsabat_main.sh
 create mode 100755 bat/tests/analog_audio_playback_and_capture.sh
 create mode 100644 bat/tests/asound_state/Makefile.am
 create mode 100644 bat/tests/asound_state/asound.state.Broadwell
 create mode 100644 bat/tests/asound_state/asound.state.Haswell
 create mode 100644 bat/tests/asound_state/asound.state.Skylake
 create mode 100755 bat/tests/dp_audio_playback.sh
 create mode 100755 bat/tests/dp_audio_subdevice_number.sh
 create mode 100755 bat/tests/hdmi_audio_playback.sh
 create mode 100755 bat/tests/hdmi_audio_subdevice_number.sh
 create mode 100644 bat/tests/map_test_case

-- 
1.9.1
