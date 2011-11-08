From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: soc-dsp questions
Date: Tue, 08 Nov 2011 13:52:35 +0530
Message-ID: <1320740555.32205.144.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B84BE2455B
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 09:26:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam <lrg@ti.com>
Cc: alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hey Liam,

I had few questions on your dsp work, would be great if you could answer
them and help me in understanding the approach.

- Is it possible to have one FE connected to multiple BEs (voice FE to
modem and headset bBE), if so how?
- SND_SOC_DAI_LINK_OPT_HOST, what does this mean, does not seem to be
used anywhere in core?
- Why comment need dummy codec for some BEs like BT etc, when soc-core
has already one?
- any reason why be haves a number associated with a BE, than usual
convention of referring things by string name in asoc?

and last one, when would this be merged to mainline, 3.3?

-- 
~Vinod
