From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: usage of SOC_ENUM_SINGLE
Date: Fri, 26 Nov 2010 20:15:11 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104BED4868C@bgsmsx502.gar.corp.intel.com>
References: <438BB0150E931F4B9CE701519A44630104BED485E4@bgsmsx502.gar.corp.intel.com>
	<20101126115220.GB30360@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 61EB1103D75
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 15:45:16 +0100 (CET)
In-Reply-To: <20101126115220.GB30360@rakim.wolfsonmicro.main>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 26, 2010 at 05:22:35PM +0530, Mark Brown wrote:
> On Fri, Nov 26, 2010 at 03:48:49PM +0530, Koul, Vinod wrote:
> 
> > static const struct snd_kcontrol_new intel_msic_snd_controls[] = {
> > SOC_ENUM_SINGLE(OUTEN, 0x43, 0x40, headset_switch_text),
> > };
> 
> > Would this be the right thing, I am interpreting that 0x40 will be written
> for
> > earpiece in above and 0x3 for headset
> 
> No, that will cause you to have an enumeration with 0x40 elements
> starting at bit 0x43 in the register.  You're looking for a
> SOC_VALUE_ENUM, not a SOC_ENUM - SOC_ENUM covers contiguous ranges of
> values in the enumeration.
Thanks Mark,
So this should do, right?

SOC_VALUE_ENUM_SINGLE(MSIC_OUTEN, 0, 0x43,
		ARRAY_SIZE(headset_switch_text),
		headset_switch_text, headset_switch_values)

With, static const char *headset_switch_values[] = {
	"0x40", "0x03"
};

I am interpreting that for earpiece 0x40 will be written to this register and 
for headset 0x03 to register offset MSIC_OUTEN with mask value of 0x43 (not 
changing other bits in this register).

I am interpreting xmask as a mask value that will be applied while changing this 
value, so that other bits are not changes
 
> Note also that you should namespace the #defines for your register
> names.
Yup, added MSIC_ to register defines

Thanks
Vinod
