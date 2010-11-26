From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: usage of SOC_ENUM_SINGLE
Date: Fri, 26 Nov 2010 14:51:48 +0000
Message-ID: <20101126145147.GJ30360@rakim.wolfsonmicro.main>
References: <438BB0150E931F4B9CE701519A44630104BED485E4@bgsmsx502.gar.corp.intel.com>
	<20101126115220.GB30360@rakim.wolfsonmicro.main>
	<438BB0150E931F4B9CE701519A44630104BED4868C@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E0A3103D75
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 15:51:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104BED4868C@bgsmsx502.gar.corp.intel.com>
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

On Fri, Nov 26, 2010 at 08:15:11PM +0530, Koul, Vinod wrote:

> So this should do, right?

> SOC_VALUE_ENUM_SINGLE(MSIC_OUTEN, 0, 0x43,
> 		ARRAY_SIZE(headset_switch_text),
> 		headset_switch_text, headset_switch_values)

> With, static const char *headset_switch_values[] = {
> 	"0x40", "0x03"
> };

No, that's not going to work and I'd be astonished if it compiled
cleanly.  You need to pass the *values* you want to set - look at the
uses of this in exiting CODEC drivers for examples of how to use this.
