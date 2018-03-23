From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [GIT PULL] Audio firmware update
Date: Fri, 23 Mar 2018 15:19:39 +0530
Message-ID: <20180323094939.GA6602@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 9183126748B
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 10:49:06 +0100 (CET)
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
To: linux-firmware@kernel.org
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, jeremy.p.lin@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

Please PULL to receive the update for Skylake, Kabylake, Broxton and
Geminilake audio DSP firmware.

The following changes since commit 44476f2465dac9c22bce90da66e86b2b56ba34f0:

  BCM-0bb4-0306: Update to Cypress license in WHENCE (2018-03-20 12:20:21 -0400)

are available in the git repository at:

  https://github.com/sanyogrk/firmware kbl

for you to fetch changes up to 9c53767c99f1d393e9c0f566ec17e4699788e95d:

  linux-firmware: intel: Update Geminilake audio firmware (2018-03-23 09:55:51 +0530)

----------------------------------------------------------------
Sanyog Kale (4):
      linux-firmware: intel: Update Skylake audio firmware
      linux-firmware: intel: Update Broxton audio firmware
      linux-firmware: intel: Update Kabylake audio firmware
      linux-firmware: intel: Update Geminilake audio firmware

 WHENCE                         |  16 ++++++++++++----
 intel/dsp_fw_bxtn.bin          |   2 +-
 intel/dsp_fw_bxtn_v3366.bin    | Bin 0 -> 505608 bytes
 intel/dsp_fw_glk.bin           |   2 +-
 intel/dsp_fw_glk_v3366.bin     | Bin 0 -> 505608 bytes
 intel/dsp_fw_kbl.bin           |   2 +-
 intel/dsp_fw_kbl_v3402.bin     | Bin 0 -> 247112 bytes
 intel/dsp_fw_release.bin       |   2 +-
 intel/dsp_fw_release_v3402.bin | Bin 0 -> 247112 bytes
 9 files changed, 16 insertions(+), 8 deletions(-)
 create mode 100644 intel/dsp_fw_bxtn_v3366.bin
 create mode 100644 intel/dsp_fw_glk_v3366.bin
 create mode 100644 intel/dsp_fw_kbl_v3402.bin
 create mode 100644 intel/dsp_fw_release_v3402.bin

Thanks,
Sanyog

-- 
