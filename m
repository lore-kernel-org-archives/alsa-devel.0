From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH v6 1/2] ASoC: cs35l33: Initial commit of
 the cs35l33 CODEC driver.
Date: Mon, 6 Jun 2016 22:23:50 +0000
Message-ID: <D37B5CDE.146B8%Paul.Handrigan@cirrus.com>
References: <20160606183141.GI7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 141BE2652AE
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 00:23:52 +0200 (CEST)
In-Reply-To: <20160606183141.GI7510@sirena.org.uk>
Content-Language: en-US
Content-ID: <FB4C39248A25AA49A01BB00BCC224A5B@ad.cirrus.com>
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
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 6/6/16, 1:31 PM, "Mark Brown" <broonie@kernel.org> wrote:

>On Fri, Jun 03, 2016 at 03:09:05PM -0500, Paul.Handrigan@cirrus.com wrote:
>
>> +		regmap_update_bits(cs35l33->regmap, CS35L33_CLK_CTL,
>> +			CS35L33_MCLKDIV2, CS35L33_MCLKDIV2);
>> +			cs35l33->mclk_int = freq/2;
>
>Coding style, spaces around /.
Thanks!


>
>> +       if (CS35L33_VBSTMON_OVFL & sticky_val2)
>> +               dev_err(codec->dev,
>> +                       "ERROR: VPMON Overflow Interrupt\n");
>
>Cut'n'paste.

Thanks!
>
>> +	/* Make sure that the bits are cleared */
>> +	for (i = 0; i < CS35L33_INT_ATTEMPTS; i++) {
>> +		regmap_read(cs35l33->regmap, CS35L33_INT_STATUS_1,
>> +			&sticky_val1);
>> +		regmap_read(cs35l33->regmap, CS35L33_INT_STATUS_2,
>> +			&sticky_val2);
>> +
>> +		if (!(sticky_val1 & ~mask1) && !(sticky_val2 & ~mask2))
>> +			break;
>> +	}
>
>I still don't understand this.  If these interrupts are clear on read
>(which seems to be the case since we don't ack anything?) then these
>repeated reads are obviously just going to ignore interrupts.  I really
>hope that the masking also applies to the clear on read behaviour but
>that's a separate thing.
>
>I'm guessing the hardware is just broken here but it's not clear to me
>that just letting the interrupt fire a couple of extra times isn't the
>best solution and we need a clear explanation of what this is trying to
>accomplish and why so that the code is maintainable.

It is just to ensure that the unmasked bits are cleared. We can remove this
code all together.


>
>> +       ret = request_threaded_irq(i2c_client->irq, NULL,
>>cs35l33_irq_thread,
>> +                       IRQF_ONESHOT | IRQF_TRIGGER_LOW, "cs35l33",
>>cs35l33);
>> +       if (ret != 0)
>> +               dev_err(&i2c_client->dev, "Failed to request IRQ:
>>%d\n", ret);
>
>But otherwise ignore the error?

This really should be a warning.  The device can be used without an
interrupt pin.
This should be devm_ as well.

>
