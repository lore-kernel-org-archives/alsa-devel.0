From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: usage of SOC_ENUM_SINGLE
Date: Fri, 26 Nov 2010 11:52:20 +0000
Message-ID: <20101126115220.GB30360@rakim.wolfsonmicro.main>
References: <438BB0150E931F4B9CE701519A44630104BED485E4@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D19410381F
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 12:52:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104BED485E4@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 26, 2010 at 03:48:49PM +0530, Koul, Vinod wrote:

> static const struct snd_kcontrol_new intel_msic_snd_controls[] = {	
> SOC_ENUM_SINGLE(OUTEN, 0x43, 0x40, headset_switch_text),
> };

> Would this be the right thing, I am interpreting that 0x40 will be written for 
> earpiece in above and 0x3 for headset

No, that will cause you to have an enumeration with 0x40 elements
starting at bit 0x43 in the register.  You're looking for a
SOC_VALUE_ENUM, not a SOC_ENUM - SOC_ENUM covers contiguous ranges of
values in the enumeration.

Note also that you should namespace the #defines for your register
names.
