From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: concept of substream...
Date: Wed, 08 Feb 2012 14:35:00 +0530
Message-ID: <1328691900.26182.149.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id D64A32459B
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 10:02:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I was trying to understand the concept of substream. So can we have a
device which can have support say 5 substreams and these are controlled
(start/stop) independent of each other.
At any instance we can have any number of substreams active and runtime
we should be able to activate/deactivate a particular substream. Is that
doable with this concept or should i look at something else? 

--
~Vinod 
