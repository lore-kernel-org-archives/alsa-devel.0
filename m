From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 09/19] ASoC: tlv320aic31xx: Remove
	platform data
Date: Wed, 6 Dec 2017 12:40:45 -0600
Message-ID: <86e13e26-e8d5-35ed-6bd0-d91d9323d5e6@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-10-afd@ti.com>
 <20171201132606.vyw7wthmql5trkwq@sirena.org.uk>
 <4fee76ef-e518-69b6-3bcc-f65b0a31cacc@ti.com>
 <20171206124540.GC1827@finisterre>
 <10f1b19b-4a0a-e336-b757-933d46b5c8e9@ti.com>
 <20171206173059.qw4tt7nizmyo6xbl@sirena.org.uk>
 <b6f581be-6d3a-6fc3-036f-9efc1bfc2429@ti.com>
 <20171206181534.7t23ljja6fgle4ar@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E571267048
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 19:40:46 +0100 (CET)
In-Reply-To: <20171206181534.7t23ljja6fgle4ar@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 12/06/2017 12:15 PM, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 11:48:43AM -0600, Andrew F. Davis wrote:
> 
>> That would be unreasonable I agree, but it's also completely
>> hypothetical, as again, there are no in-tree users and most platforms
>> are DT/ACPI, so the odds of anyone needing it are next to nothing.
> 
> You're removing support for something someone might want to use for no
> clear gain.  The bar for doing that needs to be higher than just random
> cleanup, it needs to actively bring some benefit that justifies the
> cost.  If something is sitting there not getting in the way and is
> potentially going to be helpful for something in the future then there
> needs to be a positive reason to take it away.
> 

For some userspace feature sure, but this is kernel code, there is no
guarantee for a sable API, in fact some would probably argue even
further that there is a guarantee that stuff *will* change and this is a
good thing as it kinda serves to punish for those you don't try to upstream.

So the helpfulness bar should be zero for changes that break out-of-tree
stuff.

Even more so this patch isn't a zero gain, the cleaner, better looking,
and easier to maintain code *is* the benefit in itself. Plus we gain the
ability to set mic-gain voltage with ACPI, something you couldn't do
before this patch.
