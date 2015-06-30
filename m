From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH RFT] ASoC: ak4642: Fix up max_register
	setting
Date: Tue, 30 Jun 2015 19:25:57 +0800
Message-ID: <CAFRkauCPAq9xmpJSpbhTZy2_s=2ipSW5Mwixj3ptJTpB+Vqv1w@mail.gmail.com>
References: <1435459611.15772.2.camel@ingics.com>
 <20150630104608.GP11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id BF4A7260417
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 13:25:57 +0200 (CEST)
Received: by lagx9 with SMTP id x9so9221869lag.1
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 04:25:57 -0700 (PDT)
In-Reply-To: <20150630104608.GP11162@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

2015-06-30 18:46 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Sun, Jun 28, 2015 at 10:46:51AM +0800, Axel Lin wrote:
>
>>  static const struct regmap_config ak4642_regmap = {
>>       .reg_bits               = 8,
>>       .val_bits               = 8,
>> -     .max_register           = ARRAY_SIZE(ak4642_reg) + 1,
>> +     .max_register           = FIL1_3,
>>       .reg_defaults           = ak4642_reg,
>> -     .num_reg_defaults       = ARRAY_SIZE(ak4642_reg),
>> +     .num_reg_defaults       = FIL1_3 + 1,
>
> This change is incorrect, the number of register defaults must match the
> size of the array of register defaults being passed in.  Why are you
> changing this?

Because I reuse the same reg_default for ak4642 and ak4643.
According to the datasheet:
For ak4642, the valid registers are 0x0 ~ 0x1f (FIL1_3)
For ak4643, the valid registers are 0x0 ~ 0x24 (SPK_MS)
The default registers for 0x0 ~ 0x1f are the same for ak4642 and ak4643.

That is why this patch set  .num_reg_defaults = FIL1_3 + 1 for ak4642.

Or do you prefer having separate reg_default for ak4642 and ak4643?
(Then it can use ARRAY_SIZE() here.)
