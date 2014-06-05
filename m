From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: sigmadsp: remove I2C support
Date: Thu, 05 Jun 2014 17:23:07 +0200
Message-ID: <53908B5B.10807@metafoo.de>
References: <6181626.txoA4bpImf@wuerfel> <539084F3.3050700@metafoo.de>
 <4610731.9TBGyCy3TV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4610731.9TBGyCy3TV@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 06/05/2014 05:10 PM, Arnd Bergmann wrote:
> On Thursday 05 June 2014 16:55:47 Lars-Peter Clausen wrote:
>> On 06/05/2014 04:47 PM, Arnd Bergmann wrote:
>>> The newly added ADAU1781 codec comes with separate drivers for
>>> I2C and SPI modes, which gives us a new variation of the dependency
>>> problems: If SPI is enabled and the I2C core is a loadable module,
>>> selecting SND_SOC_ADAU1781_SPI as built-in leads to a link error because
>>> the common base code from sigmadsp.c now also gets built-in:
>>>
>>> sound/built-in.o: In function `sigma_action_write_i2c':
>>> :(.text+0x5d8d4): undefined reference to `i2c_master_send'
>>>
>>> Rather than adding yet more complex Kconfig logic, this converts the last
>>> user of process_sigma_firmware() to process_sigma_firmware_regmap(),
>>> which seems trivial after the driver itself now uses regmap as well.
>>> With that done, there is no more linker dependency from
>>> SND_SOC_ADAU1781_SPI to i2c_master_send.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>>
>> No this patch won't work. Regmap support for the adau1701 is rather limited
>> which is why we need native i2c support in the lib.
>
> Ah, I see.
>
>> But yea, I just noticed the same problem an hour ago and was thinking
>> hopefully I'll get to fixing this before it shows up in Arnd's randconfig
>> builds
>
> It's actually my second attempt after I finished writing the first patch
> for it. Is that better?

That will fix the symptoms of the issue for SND_SOC_ALL_CODECS, but the 
problem is still there. I'll send a patch which factors the regmap and I2C 
sigmadsp code out into their own modules.

- Lars
