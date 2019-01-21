From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/7] Runtime PM support (hda/tegra)
Date: Mon, 21 Jan 2019 23:11:30 +0530
Message-ID: <1548092497-5459-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A3CE32667E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 18:41:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Background
==========
The device power management operations can be controlled with the help of
runtime power management (runtime PM) framework. In this case hda driver
can register runtime PM callbacks with the power management core (PM core).
Idea is to put the device in low power mode, when it is not getting used.
The clocks and power domains can be turned off when no use case is running
on the device. Current patch series adds necessary support to manage hda
device at runtime.

Change log
==========
v1:
----
  Patch-1: "ALSA: hda/tegra: runtime power management support"
    * runtime PM enable/disable added in device probe/remove
    * runtime PM calls are forbidden if AZX_DCAPS_PM_RUNTIME is not enabled
      in driver flags
    * worker thread uses pm_runtime_get_sync to invoke ->runtime_resume and
      pm_runtime_put to invoke ->runtime_suspend. The callbacks are added
      in subsequent patches
 
  Patch-2: "ALSA: hda/tegra: get clock handles early in probe"
    * Clock handles required for hda are acquired early in the probe. This
      is done to make use of runtime PM framework to enable/disable clocks
      in the callbacks.

  Patch-3: "ALSA: hda/tegra: add runtime PM callbacks"
    * adds runtime PM callbacks for ->runtime_suspend(), ->runtime_resume()
    * only skeleton for the callbacks is added, implementation is done in
      the subsequent patches

  Patch-4: "ALSA: hda/tegra: remove redundant clock enable API"
    * As worked thread is calling pm_runtime_get_sync() now, no need to
      enable the clock explicitly. This can be managed from callback.
    * Idea is to have clock enable and disable functionalities in runtime
      PM callbacks and the driver can make use of the above. Any device
      access should be preceded by ->runtime_resume() call.

  Patch-5: "ALSA: hda/tegra: implement runtime suspend/resume"
    * clock enable and controller initialization is moved to
      ->runtime_reesume() and the reverse is done during
      ->runtime_suspend()
    * Also during system wide power transitions, pm_runtime_force_resume()
      is invoked in system resume() and similarly for suspend case.

  Patch-6: "ALSA: hda/tegra: fix kernel panic"
    * kernel panic is happening befoe controller init is done
    * added a flag "probed" to indicate the completion of device init
    * this flag is checked before doing any device access.

  Patch-7: "ALSA: hda/tegra: add driver flag for runtime PM"
    * driver flag AZX_DCAPS_PM_RUNTIME is added if CONFIG_PM is enabled.
    * otherwise runtime PM calls will be forbidden and act as dummy calls

=========

Sameer Pujar (7):
  ALSA: hda/tegra: runtime power management support
  ALSA: hda/tegra: get clock handles early in probe
  ALSA: hda/tegra: add runtime PM callbacks
  ALSA: hda/tegra: remove redundant clock enable API
  ALSA: hda/tegra: implement runtime suspend/resume
  ALSA: hda/tegra: fix kernel panic
  ALSA: hda/tegra: add driver flag for runtime PM

 sound/pci/hda/hda_tegra.c | 120 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 88 insertions(+), 32 deletions(-)

-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
