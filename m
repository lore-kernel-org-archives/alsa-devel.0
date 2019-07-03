From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/6] ASoC: wcd934x: add support to
	wcd9340/wcd9341 codec
Date: Wed, 3 Jul 2019 13:06:25 +0100
Message-ID: <8edd8bc6-4b32-7f7e-2521-d7038a4ffb8d@linaro.org>
References: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
 <20190702080920.22623-3-srinivas.kandagatla@linaro.org>
 <20190702144411.GP2793@sirena.org.uk>
 <2e2a32dd-3dca-5391-1bfa-ab1c1f420e3a@linaro.org>
 <20190702165753.GQ2793@sirena.org.uk>
 <0a9a994c-5a88-539f-3af0-76754b9b58d1@linaro.org>
 <20190703115243.GV2793@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FE65F80058
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2019 14:06:27 +0200 (CEST)
Received: by mail-wr1-x442.google.com with SMTP id p11so2491849wre.7
 for <alsa-devel@alsa-project.org>; Wed, 03 Jul 2019 05:06:27 -0700 (PDT)
In-Reply-To: <20190703115243.GV2793@sirena.org.uk>
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



On 03/07/2019 12:52, Mark Brown wrote:
> On Wed, Jul 03, 2019 at 09:49:37AM +0100, Srinivas Kandagatla wrote:
>> On 02/07/2019 17:57, Mark Brown wrote:
> 
>>> This is a driver for a single device, you should be able to
>>> instantiate things without requiring binding through DT (and
>>> hence support non-DT systems such as those using ACPI).
> 
>> My view point atleast from hw side was that Codec is Parent which is
>> encompassing these different blocks and bus interface. DT representation
>> clearly showed that relationship between the parent and child devices.
>> Binding it through DT will make sure that resources are ready before
>> they are instantiated.
> 
>> All the child devices also have some machine/board specific properties
>> and dependency on resources from parent like regmap, clks, and bus.
> 
>> In ACPI case, am not 100% sure how these will be represented inline with
>> hw representation.
> 
>> Are you suggesting to use MFD here?
> 
> I'm saying that you should be using a MFD here like all the other
> CODECs with multiple functions and that you shouldn't have
> compatible strings in DT for the subfunctions since you already
> know they'll be there simply from enumerating the chip as a whole
> and how exactly they are divided up is a function of how Linux
> currently has subsystems, not of the hardware.
> 
Got it!, thanks for the input, I will change that in v2.



--srin
