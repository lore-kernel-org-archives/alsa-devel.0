From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 10/19] ASoC: tlv320aic31xx: Add MICBIAS
	off setting
Date: Fri, 1 Dec 2017 08:56:31 -0600
Message-ID: <afa96737-d17a-c854-b3a8-30730e06dd99@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-11-afd@ti.com>
 <20171201133028.svemo5qedyfqrt7y@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A465267C99
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 15:56:33 +0100 (CET)
In-Reply-To: <20171201133028.svemo5qedyfqrt7y@sirena.org.uk>
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

On 12/01/2017 07:30 AM, Mark Brown wrote:
> On Wed, Nov 29, 2017 at 03:32:51PM -0600, Andrew F. Davis wrote:
>> Leaving microphone bias off is a valid setting and even used in the DT
>> binding document example. Add this setting here and document the same.
> 
>>  - ai31xx-micbias-vg - MicBias Voltage setting
>> +        0 or MICBIAS_OFF - MICBIAS output is powered off
>>          1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
>>          2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
>>          3 or MICBIAS_AVDD - MICBIAS output is connected to AVDD
> 
> This doesn't make much sense.  If we enable the microphone with a
> voltage of 0V that's not going to work terribly well - I'd expect this
> property to control the voltage set when it's enabled, not if it's
> enabled.
> 

I agree about this not making much sense, but I'm not sure the right way
forward here.

Personally I wouldn't have put MicBias voltage in DT to begin with, it
is runtime configurable and depends on user runtime inserted microphone,
not really a hardware description :/

The enable/disable is controlled by a DAPM and should be wired to enable
whenever we are recording from the related microphone pin. So then
without MICBIAS_OFF the user is forced to select from the above voltages
whenever recording, which may not be correct if they are using a mic
that doesn't need bias.

The best option I think would be to drop this from DT, but I don't feel
like fighting that battle right now.
