From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
Date: Sun, 17 Jan 2016 02:01:05 +0100
Message-ID: <569AE7D1.6050607@maciej.szmigiero.name>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <5693B4C1.4060400@maciej.szmigiero.name>
 <CAOMZO5DVKrnufV_PLD_+7FgA=ePhn1DSpzYDQPy5FZvHyGOJ-g@mail.gmail.com>
 <569AD8A7.7080803@maciej.szmigiero.name> <569ADC0D.2000807@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CC8826044E
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2016 02:02:08 +0100 (CET)
In-Reply-To: <569ADC0D.2000807@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 17.01.2016 01:10, Timur Tabi wrote:
> Maciej S. Szmigiero wrote:
>> +static const struct regmap_config fsl_ssi_regconfig_imx21 = {
>> +    .max_register = CCSR_SSI_SRMSK,
>> +    .reg_bits = 32,
>> +    .val_bits = 32,
>> +    .reg_stride = 4,
>> +    .val_format_endian = REGMAP_ENDIAN_NATIVE,
>> +    .num_reg_defaults_raw = CCSR_SSI_SRMSK / 4 + 1,
>> +    .readable_reg = fsl_ssi_readable_reg,
>> +    .volatile_reg = fsl_ssi_volatile_reg,
>> +    .precious_reg = fsl_ssi_precious_reg,
>> +    .writeable_reg = fsl_ssi_writeable_reg,
>> +    .cache_type = REGCACHE_RBTREE,
>> +};
>> +
>>   static const struct regmap_config fsl_ssi_regconfig = {
>>       .max_register = CCSR_SSI_SACCDIS,
>>       .reg_bits = 32,
>>       .val_bits = 32,
>>       .reg_stride = 4,
>>       .val_format_endian = REGMAP_ENDIAN_NATIVE,
>> -    .reg_defaults = fsl_ssi_reg_defaults,
>> -    .num_reg_defaults = ARRAY_SIZE(fsl_ssi_reg_defaults),
>> +    .num_reg_defaults_raw = CCSR_SSI_SACCDIS / 4 + 1,
>>       .readable_reg = fsl_ssi_readable_reg,
>>       .volatile_reg = fsl_ssi_volatile_reg,
>>       .precious_reg = fsl_ssi_precious_reg,
> 
> Is this really necessary?  Why do we need separate register configs for one specific SOC?
> There are already too many "if (some_stupid_imx_variant)" blocks in this driver.

This is because (at least according to the datasheet) imx21-class SSI
registers end at CCSR_SSI_SRMSK (no SACC{ST,EN,DIS} regs), so
reading them for cache initialization may not be safe.

Also, a "MXC 91221 only" comment before these regs in FSL tree
(drivers/mxc/ssi/registers.h) seems to confirm that these registers
aren't present at least on some SSI (or SoC) models.

Best regards,
Maciej Szmigiero
