From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/6] ASoC: wcd934x: add support to
	wcd9340/wcd9341 codec
Date: Wed, 3 Jul 2019 09:49:37 +0100
Message-ID: <0a9a994c-5a88-539f-3af0-76754b9b58d1@linaro.org>
References: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
 <20190702080920.22623-3-srinivas.kandagatla@linaro.org>
 <20190702144411.GP2793@sirena.org.uk>
 <2e2a32dd-3dca-5391-1bfa-ab1c1f420e3a@linaro.org>
 <20190702165753.GQ2793@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B44DF800C5
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2019 10:49:40 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id n4so1751093wrw.13
 for <alsa-devel@alsa-project.org>; Wed, 03 Jul 2019 01:49:40 -0700 (PDT)
In-Reply-To: <20190702165753.GQ2793@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, robh+dt@kernel.org, srini@kernel.org
List-Id: alsa-devel@alsa-project.org



On 02/07/2019 17:57, Mark Brown wrote:
> On Tue, Jul 02, 2019 at 05:37:01PM +0100, Srinivas Kandagatla wrote:
>> On 02/07/2019 15:44, Mark Brown wrote:
>>> On Tue, Jul 02, 2019 at 09:09:16AM +0100, Srinivas Kandagatla wrote:
> 
>>>> +	for (i = 0; i < ARRAY_SIZE(cpr_defaults); i++) {
>>>> +		regmap_bulk_write(data->regmap,
>>>> +				  WCD934X_CODEC_CPR_WR_DATA_0,
>>>> +				(u8 *)&cpr_defaults[i].wr_data, 4);
>>>> +		regmap_bulk_write(data->regmap,
>>>> +				  WCD934X_CODEC_CPR_WR_ADDR_0,
>>>> +				(u8 *)&cpr_defaults[i].wr_addr, 4);
> 
>>> What is "cpr" and should you be using a regmap patch here?  Why
>>> is this not with the other default updates?  You've got loads of
>>> random undocumented sequences like this all through the driver,
>>> are they patches or are they things that should be controllable
>>> by the user?
> 
>> It makes sense to have a single default map here, I will do the in next
>> version. And regarding user controllable, I will go thru the list once
>> again in detail and remove user controllable registers.
> 
> What is a "default map"?  In terms of user controllable stuff
> it's not just a question of if things are currently user
> controllable but also if they should be user controllable.

I meant default updates here. These magic values and list came from 
downstream android code, so I will have to audit them before I can say 
that it will be useful for them to be exposed to user.
Most of things that made sense to provide a user control for the 
usecases of playback/capture/sidetone/speakers are already exposed via 
mixer controls.
> 
>>>> +	return of_platform_populate(wcd->dev->of_node, NULL, NULL, wcd->dev);
> 
>>> Why are we doing this?
> 
>> I will not be using MFD in this instance as most of the resources like
>> interrupts, pins, clks, SoundWire are modeled as proper drivers with
>> their respective subsystems.
> 
> This is a driver for a single device, you should be able to
> instantiate things without requiring binding through DT (and
> hence support non-DT systems such as those using ACPI).

My view point atleast from hw side was that Codec is Parent which is 
encompassing these different blocks and bus interface. DT representation 
clearly showed that relationship between the parent and child devices.
Binding it through DT will make sure that resources are ready before 
they are instantiated.

All the child devices also have some machine/board specific properties 
and dependency on resources from parent like regmap, clks, and bus.

In ACPI case, am not 100% sure how these will be represented inline with 
hw representation.

Are you suggesting to use MFD here?

> 
>> This gives a advantage of reusing those drivers like SoundWire, pinctrl
>> on other Qualcomm IPs as well!
>> Also I did not wanted to have a custom functions or hooks in the
>> drivers, so platform bus made much sense for me to use here, which can
>> take care of bringing up and tearing down the devices with proper parent
>> child relationship.
>> This will instantiate all the child devices like pinctrl, SoundWire
>> Controller and so on.
> 
> Just create platform devices like normal...
These are already modeled as platform devices, except the fact that 
these are children of Codec device.

thanks,
srini
> 
