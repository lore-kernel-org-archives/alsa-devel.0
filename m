From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 4/5] ASoC: sam9g20_wm8731: convert to
	device tree support
Date: Mon, 29 Oct 2012 14:38:17 +0800
Message-ID: <508E2459.5090707@atmel.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
 <1350901079-18307-4-git-send-email-voice.shen@atmel.com>
 <20121027221204.GL4564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 20C512651ED
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 07:38:44 +0100 (CET)
In-Reply-To: <20121027221204.GL4564@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, plagnioj@jcrosoft.com, jm.lin@atmel.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 10/28/2012 6:12, Mark Brown wrote:
> On Mon, Oct 22, 2012 at 06:17:58PM +0800, Bo Shen wrote:
>> Covert sam9g20 wm8731 to device tree support
>> And enable it through dts file
>>
>>    Tested on sam9g20 EK board
>
> This needs to add binding documentation for the board.

I will add the binding documentation in next version.

>> +	dai: dai {
>> +		compatible = "atmel,atmel-ssc-dai";
>> +		atmel,dai-master = <&ssc0>;
>> +	};
>
> This looks wrong - this is a Linux-specific virtual device sitting on
> top of the SSC which is the actual physical device.  The usual patterns
> would be something like have the machine driver register the DAI based
> on the SSC specified in the bindings (much like how you're handling the
> platform already).

I have a question for this, do all nodes in dts file should be physical 
device?

The SSC part is a little different with other SoC family. So, I think, 
if I keep the ssc driver in driver/misc folder as the library code. And 
create new code into sound/soc/atmel for ssc which used for audio, would 
this be acceptable? If so, the framework will be the same with other SoC 
family.
