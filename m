From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Audio codec with multiple I2C devices
Date: Tue, 08 Apr 2014 08:40:25 +0200
Message-ID: <534399D9.3020709@metafoo.de>
References: <mailman.300.1396595329.806.alsa-devel@alsa-project.org>
 <C71C517D-B88B-48C3-9156-AB9DD40AE4C0@whospot.com>
 <53411B1F.5070004@metafoo.de> <20140407113710.GC14763@sirena.org.uk>
 <3C2805F4-7EB9-4E43-9140-98982932737C@whospot.com>
 <5342F68B.9060801@metafoo.de>
 <81C8B318-CBB6-4862-A779-E0EBFACA48C6@whospot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-115.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B560266F9E
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 08:40:24 +0200 (CEST)
In-Reply-To: <81C8B318-CBB6-4862-A779-E0EBFACA48C6@whospot.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Gilles <gilles@whospot.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/07/2014 09:29 PM, Gilles wrote:
> On Apr 7, 2014, at 12:03 , Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> On 04/07/2014 08:32 PM, Gilles wrote:
>> [...]
>>> Doesn't it make perfect sense to have the Volume be a control of the Codec driver even if it's provided by a separate chip on the same sound card?
>>
>> Not if they are standalone components that can also be used in different configurations on different sound cards. E.g. you code suggests that you are using a AK4113 and a DAC121C085. The CODEC driver is not the sound card driver, the sound card driver is the piece of code that glues all the different components that are found on the sound card together.
>>
>> i2c_new_dummy() is typically used for devices with multiple I2C addresses. Or where you have e.g. multiple devices with different addresses on the same die so they become a inseparable unit.
>>
>> - Lars
>
> Yes, but the functionality is very specific to the way the components are wired on the hardware. They are wired to work in conjunction with the ASIC Codec.
>
> The DAC121C085 is a very specific case as the DAC is actually wired to control the voltage of 4 quadrant multiplier which is hardwired to the Codec ASIC. This is a prototype. In the final product, the DAC chip may be built into the ASIC. For this one, I feel like the "Volume" should be a control of the same driver as the ASIC.
>
> This said I see your point about the AK4113 which is a generic multi channel receiver. In this specific application it is wired so only inputs 1,2 and 3 are hard wired (this actually isn't a sound card, but rather a finished product using Linux as the SoC OS as can be seen on the home page of http://birdland.com right now).
>
> There is already a working prototype, but as of now, the inputs are selected by the application talking directly to the I2C AKM. I'm just in the process of streamlining the code, and naturally, I envisioned the input selection be part of the sound card codec as I'd much rather have the sound card have a enum control with the 4 inputs shown by name show under amixer (this would enable my application to be more generic).
>
> Can you please point me to an example of a Sound board driver that uses multiple codecs? I suppose I can modify my sound board driver to use a codec for the audio and another for the AKM input selector).

Anything that uses aux devs. E.g. samsung/speyside.c
There is also this series https://lkml.org/lkml/2014/4/5/92 which adds DT 
support for aux devs.

- Lars
