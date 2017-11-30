From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 5/8] ARM: dts: am335x-pepper: Fix the
 audio CODEC's reset pin
Date: Thu, 30 Nov 2017 10:37:22 -0600
Message-ID: <4b535cec-6e33-adc0-a962-f5e65d84d1ad@ti.com>
References: <20171129171359.29382-1-afd@ti.com>
 <20171129171359.29382-6-afd@ti.com> <20171130161826.GP28152@atomide.com>
 <20171130163344.kudopvsljywb4hyw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F383267AC6
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 17:37:24 +0100 (CET)
In-Reply-To: <20171130163344.kudopvsljywb4hyw@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/30/2017 10:33 AM, Mark Brown wrote:
> On Thu, Nov 30, 2017 at 08:18:26AM -0800, Tony Lindgren wrote:
> 
>> So it seems this and patch 8/8 are safe for me to pick separately?
> 
> It might make sense to pull in the relevant branches from ASoC first
> however IIRC the reset GPIO code currently does nothing useful anyway so
> it won't have any impact on bisection.  Andrew?
> 

Yeah, that's right, for safety it would be nice to take these after the
ASoC code, but it shouldn't matter in practice as the reset wasn't used
right anyway.
