From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 00/11] Intel IbexPeak HDMI codec support
Date: Thu, 15 Oct 2009 15:03:48 +0800
Message-ID: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 19A6D103827
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

This series adds support for the Intel IbexPeak HDMI codec, which can
connect up to 3 monitors and support 2 independant A/V pipes. The patches
are tested OK on IbexPeak and G45. DisplayPort is also working with another
in-house KMS patch. However we have not tested dual monitor configurations
(which should be rare for now).

Thanks,
Fengguang
