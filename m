From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 16/19] ASoC: tlv320aic31xx: Add short
 circuit detection support
Date: Thu, 7 Dec 2017 09:37:36 -0600
Message-ID: <83e40a88-2c3d-416a-6e19-56c6f96d3af3@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-17-afd@ti.com>
 <20171201133930.xzfjjj6wzkbtk6c4@sirena.org.uk>
 <4d956cbc-829c-0d81-2980-aa2a79f36660@ti.com>
 <fd362117-ae71-a6a2-eb43-70c2457c0a5d@ti.com>
 <20171207120352.4obvlu4cemagfom7@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 437F1266B67
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 16:37:58 +0100 (CET)
In-Reply-To: <20171207120352.4obvlu4cemagfom7@sirena.org.uk>
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

On 12/07/2017 06:03 AM, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 02:22:39PM -0600, Andrew F. Davis wrote:
>> On 12/01/2017 09:32 AM, Andrew F. Davis wrote:
> 
>>>> This will report the interrupt as handled even if we didn't see an
>>>> interrupt we understand which will break shared interrupt lines.  At the
>>>> very least we should log other interrupt sources numerically.
> 
>>> Okay, I think I can make that work by checking if no bits are set in the
>>> interrupt regs and returning early if not, IRQ_NONE.
> 
>> This turned out to be more difficult than I expected, plus if I do
>> handle an interrupt it doesn't mean the other device did not right? So
>> this wouldn't fix shared lines as far as I can tell, but I don't
>> register it as shared so this should be fine.
> 
> It'll mean that we don't offer the interrupt to anything else sharing
> the line.
> 
>> As for your other suggestion of "log other interrupt sources
>> numerically", could you explain this or point to an example of what you
>> mean?
> 
> Just print out the bits that were set.
> 

I don't see anyone else doing this, what would that solve? Maybe I still
don't get what you mean here. :(
