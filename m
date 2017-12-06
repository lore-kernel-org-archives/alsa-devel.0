From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 16/19] ASoC: tlv320aic31xx: Add short
 circuit detection support
Date: Wed, 6 Dec 2017 11:15:12 -0600
Message-ID: <73ee66e9-81c3-2bfe-8808-2c3e90f5bcba@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-17-afd@ti.com>
 <20171201133930.xzfjjj6wzkbtk6c4@sirena.org.uk>
 <4d956cbc-829c-0d81-2980-aa2a79f36660@ti.com>
 <20171201155725.lrl35nig53fnwkac@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D3422679C7
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:15:14 +0100 (CET)
In-Reply-To: <20171201155725.lrl35nig53fnwkac@sirena.org.uk>
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

On 12/01/2017 09:57 AM, Mark Brown wrote:
> On Fri, Dec 01, 2017 at 09:32:12AM -0600, Andrew F. Davis wrote:
>> On 12/01/2017 07:39 AM, Mark Brown wrote:
> 
>>> Is the interrupt only available on GPIO1?
> 
>> Some devices can route this to GPIO2 IIRC.
> 
>> I'm not sure how that would be supported, I think we would need to add
>> interrupt names to DT so users could specify which gpio they wired their
>> IRQ lines to.
> 
>> interrupt = <&host 23>;
>> interrupt-name = "gpio2";
> 
>> or similar?
> 
> You could also use pinctrl an require the user to mux the interrupt in
> whatever fashion makes sense for their device.
> 

If done at that layer then no change is needed in the driver right? We
just request and use the IRQ passed to us from i2c data.
