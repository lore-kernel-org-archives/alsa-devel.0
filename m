From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [RFC 0/4]: ASoC SST mid asoc drivers
Date: Tue, 28 Dec 2010 17:35:42 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C104CF38@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 864A610388A
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 13:07:52 +0100 (CET)
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

This 4 patch series is sent to community to solicit early feedback on our work 
to move sst: driver from staging to ASoC framework as suggesting by community in 
previous review.

This current patch set adds one msic codec driver, the mid platform driver and 
machine driver. More codec drivers will be added eventually.
This misc codec driver adds only playback path, capture path and jack detection 
are todo.

Thanks
Harsha & Vinod
