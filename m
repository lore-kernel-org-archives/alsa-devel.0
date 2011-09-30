From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [RFC 0/3] ASoC: davinci- pcm and McASP error detection
Date: Fri, 30 Sep 2011 17:23:00 -0400
Message-ID: <cover.1317417232.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E8BD1037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 23:23:08 +0200 (CEST)
Received: by qadz2 with SMTP id z2so1034506qad.39
	for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2011 14:23:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Both the EDMA3 and McASP have the ability to report error conditions. In both
cases these errors are silently dropped on the floor. 

I would like very much to get HW errors up the stack to the aplay process using
the harware. This is an RFC series demonstrating a first attempt. 

1/3 isn't nearly as half-baked as the others. It proposes to return
SNDRV_PCM_POS_XRUN from davinci-pcm's pointer() function like is currently done
in fsl_dma. The problem I have observed in test is that the stream does not abort; 
several underruns are reported before aplay finally dies. I would prefer immeadiate
death with a reason.

2/3 and 3/3 are a first-strike at registering 'health' callbacks provided by the 
CPU DAI so that error conditions can be reported back. The health callback is polled
on calls to pointer(). This may be too often. Also the current method of registering
these callbacks seems wrong -- please help me out here.

If there is an established method of bubbling HW errors up to userspace that I
completely missed: I am sorry for the noise and would be glad to hear about how to 
use it with davinci-pcm.

Best Regards,

Ben Gardiner

Ben Gardiner (3):
  [RFC] ASoC: davinci-pcm: latch EDMA errors
  [RFC] ASoC: davinci-pcm: add cpu-dai health callbacks
  [RFC] ASoC: davinci-mcasp: add cpu dai health callback

 sound/soc/davinci/davinci-mcasp.c |   26 ++++++++++++++++++++++++++
 sound/soc/davinci/davinci-pcm.c   |   19 +++++++++++++++++--
 sound/soc/davinci/davinci-pcm.h   |    3 +++
 3 files changed, 46 insertions(+), 2 deletions(-)

-- 
1.7.4.1
