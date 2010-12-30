From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 0/4]: ASoC SST mid asoc drivers
Date: Thu, 30 Dec 2010 16:40:20 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C10F26DF@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FA8024401
	for <alsa-devel@alsa-project.org>; Thu, 30 Dec 2010 12:12:26 +0100 (CET)
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

This patchset adds the asoc drivers for mid devices. These drivers along with
sst driver form the audio subsystem in these class of devices.
The current asoc driver supports the Intel(R) Medfield platform and msic codec
with only playback support. More features and codecs will be added in future.

This patchset addresses the comments received in previous RFC patches.

This current patch set adds one msic codec driver, the mid platform driver and 
machine driver. More codec drivers will be added eventually.
This misc codec driver adds only playback path. Capture path and jack detection
are todo.

The Platform driver is currently dependent on the SST driver which is in the
staging.

Brief description of these patches:
1/4: Codec driver with config changes
2/4: Platform driver
3/4: Machine driver
4/4: Make file and kconfig changes for machine and platform driver

Thanks
Harsha & Vinod
