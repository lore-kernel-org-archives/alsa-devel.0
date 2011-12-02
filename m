From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: data write in alsa
Date: Fri, 02 Dec 2011 12:24:41 +0530
Message-ID: <1322808881.1516.1011.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id C449324676
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 07:56:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa <alsa-devel@alsa-project.org>, Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

For alsa pcm we have two ways to write data, either we use write()
system call or use ioctl SNDRV_PCM_IOCTL_WRITEI_FRAMES.

Is there any specific reason why we have two methods and which one is
preferred and why?

This question is basically for compress API, should we add similar write
method thru ioctls, if so why?

-- 
~Vinod
