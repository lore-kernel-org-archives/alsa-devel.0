From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Update sst audio firmware for Skylake
Date: Thu, 4 Feb 2016 10:42:27 +0530
Message-ID: <20160204051227.GP11744@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C01626590E
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 06:08:52 +0100 (CET)
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
Cc: Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Linux firmware maintainers,

Please PULL to receive the updated version of Skylake audio firmware.

This PULL request has two patches, first one creates a sym link for binary
name which helps us to keep different versions of firmware in git

Second one updates to latest FW v869

The following changes since commit 52442afee9907bc32a058f22bb3295d040677c26:

  brcm: add firmware for bcm4366 device (2016-01-25 15:15:34 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

for you to fetch changes up to f7996657e8f25386541593242cb8e906d9808ec7:

  linux-firmware: intel: Update Skylake audio firmware (2016-02-04 10:36:52 +0530)

----------------------------------------------------------------
Vinod Koul (2):
      linux-firmware: intel: add symbolic link and file versions
      linux-firmware: intel: Update Skylake audio firmware

 WHENCE                        |   4 ++--
 intel/dsp_fw_release.bin      | Bin 233472 -> 23 bytes
 intel/dsp_fw_release_v827.bin | Bin 0 -> 233472 bytes
 intel/dsp_fw_release_v869.bin | Bin 0 -> 233472 bytes
 4 files changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 => 120000 intel/dsp_fw_release.bin
 create mode 100644 intel/dsp_fw_release_v827.bin
 create mode 100644 intel/dsp_fw_release_v869.bin

Thanks
-- 
~Vinod
