From: focus.luo@linux.intel.com
Subject: [PATCH 0/2] alsabat: test scripts and reference amixer
	config files
Date: Mon,  8 Aug 2016 11:00:23 +0800
Message-ID: <1470625225-1237-1-git-send-email-focus.luo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E9681265FB4
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 04:33:20 +0200 (CEST)
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

 bat/tests/README                               |  32 ++
 bat/tests/alsabat_main.sh                      | 178 ++++++++++
 bat/tests/analog_audio_playback_and_capture.sh |  84 +++++
 bat/tests/asound_state/asound.state.Broadwell  | 439 +++++++++++++++++++++++++
 bat/tests/asound_state/asound.state.Haswell    | 342 +++++++++++++++++++
 bat/tests/asound_state/asound.state.Skylake    | 437 ++++++++++++++++++++++++
 bat/tests/dp_audio_playback.sh                 |  83 +++++
 bat/tests/dp_audio_subdevice_number.sh         |  68 ++++
 bat/tests/hdmi_audio_playback.sh               |  81 +++++
 bat/tests/hdmi_audio_subdevice_number.sh       |  65 ++++
 bat/tests/map_test_case                        |   8 +
 11 files changed, 1817 insertions(+)
 create mode 100644 bat/tests/README
 create mode 100755 bat/tests/alsabat_main.sh
 create mode 100755 bat/tests/analog_audio_playback_and_capture.sh
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
