From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: snd_soc_dapm_force_enable_pin question
Date: Fri, 25 Mar 2011 16:15:30 +0530
Message-ID: <1301049930.1695.11.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 2556C1037FF
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 12:15:00 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a Vibra controller on the codec which can be programmed using
alsa controls. Now after configuration I added an enable control which
when turned On, forces the Vibra Pin to be ON. The Pin is on, but not
the path, I need the DAC and amplifier connected to be ON as well?

Is this not what the force_enable_pin() is supposed to do?
If not how should I ensure this path and codec BIAS is on when Vibra is
activated by user?


-- 
~Vinod
