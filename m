From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: ASoC: regmap_config.max_register value wrong?
Date: Tue, 26 May 2015 09:14:46 +0100
Message-ID: <20150526081446.GD31187@opensource.wolfsonmicro.com>
References: <55638A21.50208@gmx.de> <556415F2.4060809@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1E2726047E
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 10:14:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <556415F2.4060809@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sergej Sawazki <ce3a@gmx.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2015 at 08:42:58AM +0200, Lars-Peter Clausen wrote:
> On 05/25/2015 10:46 PM, Sergej Sawazki wrote:
>> Dear all,
>>
>> The following snippet is from the wm8741 codec driver. Shouldn't the
>> .max_register field be set to WM8741_REGISTER_COUNT-1 (10) instead of
>> WM8741_MAX_REGISTER (0x20)?
>>
>> [...]
>> static const struct regmap_config wm8741_regmap = {
>>      .reg_bits = 7,
>>      .val_bits = 9,
>>      .max_register = WM8741_MAX_REGISTER,
>> [...]
>>
>> WM8741_MAX_REGISTER is the address of the last register.
>> WM8741_REGISTER_COUNT is the number of registers.
>>
>> The regmap_config documentation says: "@max_register: Optional,
>> specifies the maximum valid register index."
>>
>> So it should be the *register index* and not the register address.
>> Do I understand it correctly?
>
> What the documentation means is the index into the physical register map, 
> which is the address. So the code is probably correct.
>

Yeah the documentation there is maybe not entirely clear here, but
the code is correct.

Thanks,
Charles
