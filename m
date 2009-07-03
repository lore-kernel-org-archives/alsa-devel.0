From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH] [RFC 0/13] Intel SST drivers
Date: Fri, 3 Jul 2009 11:36:03 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630132984DC0@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AA2110389D
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:06:56 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org


Following emails are a of series 13 patches for Intel SST drivers (including documentation). These drivers are for the audio engine/sound card in upcoming Intel based Mobile Internet Devices (MID) platform

There are 2 drivers involved. One is for the audio DSP engine that can decode and do audio processing and one is for the ALSA sound card driver with support for three different sound cards that are supported on the platform.

The dependant drivers for the platform are not yet available in the upstream. So please consider these patches only for RFC and provide your comments/suggestions. 

The audio firmware binary associated with this platform that is downloaded by the driver at runtime will be shared in a public location and made available in firmware git when we release the drivers for up streaming.

The patches are compiled with 0 warnings and checkpatch-ed. 

The first patch in the series [RFC 1/13] Intel SST driver's documentation gives the documentation about the drivers and the interface for the audio DSP driver. The rest of the patches that follow have a brief description about the contents.

Thanks
-Vinod Koul & Harsha Priya
