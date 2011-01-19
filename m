From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: sn95031: add capture support
Date: Wed, 19 Jan 2011 18:48:01 +0000
Message-ID: <20110119184800.GC17150@opensource.wolfsonmicro.com>
References: <1295441169-32063-1-git-send-email-priya.harsha@intel.com>
	<20110119125131.GB31791@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A446301084470BBD1@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F08810384B
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 19:48:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A446301084470BBD1@bgsmsx502.gar.corp.intel.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha, Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 19, 2011 at 09:58:11PM +0530, Koul, Vinod wrote:

> > How about using a supply widget for the LDO and the clock?  This would
> > also ensure that...

> Hmmm, so what you are saying is add a supply widget like we have "Headset" and
> which does above. I thought about that, but what I have here is ADC with NULL
> stream (to ensure ADCs are on only when AMICs are selected) and added virtual
> AIF with capture stream, and all TX paths (and thereby DMIC and ADC connected
> to that). If I add supply widgets, then how do I code the map? Should I do
> AIF->TXPATH ->DMIC->Supply ?

A supply widget needs to feed into other widgets.  It will be turned on
before and turned off after the widgets it supplies but won't affect
their power.
