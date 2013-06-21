From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] ASoC: codecs: adau1701: allow
 configuration of PLL mode pins
Date: Fri, 21 Jun 2013 09:39:53 +0200
Message-ID: <51C40349.4040502@metafoo.de>
References: <1371749397-32238-1-git-send-email-zonque@gmail.com>
 <1371749397-32238-2-git-send-email-zonque@gmail.com>
 <51C3FF80.1020300@metafoo.de> <51C40140.9010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-182.synserver.de (smtp-out-183.synserver.de
 [212.40.185.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D31B2654C5
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 09:39:39 +0200 (CEST)
In-Reply-To: <51C40140.9010201@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/21/2013 09:31 AM, Daniel Mack wrote:
> On 21.06.2013 09:23, Lars-Peter Clausen wrote:
>> On 06/20/2013 07:29 PM, Daniel Mack wrote:
>>> The ADAU1701 has 2 hardware pins to configure the PLL mode in accordance
>>> to the MCLK-to-LRCLK ratio. These pins have to be stable before the chip
>>> is released from reset, and a full reset cycle, including a new firmware
>>> download is needed whenever they change.
>>>
>>> This patch adds GPIO properties to the DT bindings of the Codec, and
>>> implements makes the set_sysclk memorize the configured sysclk.
>>>
>>> To avoid excessive reset cycles and firmware downloads, the default
>>> clock divider can be specified in DT as well. Whenever a ratio change is
>>> detected in the hw_params callback, the PLL mode lines are updates and a
>>> full reset cycle is issued.
>>>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> ---
>>>  .../devicetree/bindings/sound/adi,adau1701.txt     |  14 +++
>>>  sound/soc/codecs/adau1701.c                        | 107 +++++++++++++++++----
>>>  sound/soc/codecs/adau1701.h                        |   4 +
>>>  3 files changed, 104 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/adi,adau1701.txt b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
>>> index 3afeda7..a0d7e92 100644
>>> --- a/Documentation/devicetree/bindings/sound/adi,adau1701.txt
>>> +++ b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
>>> @@ -11,6 +11,19 @@ Optional properties:
>>>   - reset-gpio: 		A GPIO spec to define which pin is connected to the
>>>  			chip's !RESET pin. If specified, the driver will
>>>  			assert a hardware reset at probe time.
>>> + - adi,pll-clkdiv: 	The PLL clock divider, specifing the ratio between
>>> +			MCLK and fsclk. The value is used to determine the
>>> +			correct state of the two mode pins below.
>>> +			Note that this value can be overridden at runtime
>>> +			by passing the ADAU1701_CLKDIV_MCLK_LRCLK divider
>>> +			with ASoC calls. However, the chips needs a full
>>> +			reset cycle and a new firmware download each time
>>> +			the configuration changes.
>>
>> Considering that this is now done all automatically at runtime, do we
>> actually still need this property?
> 
> Yes, I noticed that as well, but given that changing the PLL mode setup
> is expensive, and because we need some sort of firmware to start up at
> least, I wanted to provide a way to set these values up-front, so
> systems with stable clock dividers can minimize the number of firmware
> transfers.

Ok, fair enough, but the documentation for the property needs to be updated.

- Lars
