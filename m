From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: usage of SOC_ENUM_SINGLE
Date: Fri, 26 Nov 2010 15:48:49 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104BED485E4@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F75E244A5
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 11:19:34 +0100 (CET)
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
Cc: "Harsha, Priya" <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi

I am trying to add an output control which is basically a switch between headset 
and earpiece. The H/W register for this asks me to write 0x40 for EP and 0x3 for 
enabling Headset

So I did this:

static const char *headset_switch_text[] = {
	"Earpiece", "HeadSet"
};

static const struct snd_kcontrol_new intel_msic_snd_controls[] = {	
SOC_ENUM_SINGLE(OUTEN, 0x43, 0x40, headset_switch_text),
};

Would this be the right thing, I am interpreting that 0x40 will be written for 
earpiece in above and 0x3 for headset

~Vinod
