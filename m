From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 0/4]: ASoC SST v2: add mid asoc drivers
Date: Tue, 4 Jan 2011 20:13:28 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C119BA80@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 3521D1038F4
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 15:43:36 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Harsha, Priya" <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alan Cox <alan@linux.intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset adds the asoc drivers for mid devices. These drivers along with sst driver form the audio subsystem in these class of devices.
The current asoc driver supports the Intel(R) Medfield platform and sn95031 codec.

This patchset addresses the comments received in previous v1 patches.

This current patch set adds only sn95031 codec driver, the sst platform driver and Medfield machine driver. More codec drivers will be added eventually.
This tisn95031 codec driver adds only playback path. Capture path and jack detection are todo.

The Platform driver is currently dependent on the SST driver which is in the staging.

Brief description of these patches with changes from previous v1:
1/4: tisn95031 Codec driver with config changes
	Fixed code format issues. Renamed codec to tisn95031.
	Cleaned up update_bits usage, fixed mode alias

2/4: SST Platform driver
	Cleaned up this, added locking. Renamed aptly to sst_platform.
	Fixed mode alias

3/4: Machine driver
	Moved device creation to core. Only add soc-audio here.
	Fixed mode alias, renamed to Medfield machine driver as this is for Medfield only

4/4: Make file and kconfig changes for machine and platform driver

~Harsha & Vinod
