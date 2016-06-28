From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 4/6] ASoC: max98504: Add max98504
 speaker amplifier driver
Date: Tue, 28 Jun 2016 19:59:35 +0200
Message-ID: <5772BB07.4000609@samsung.com>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-5-git-send-email-s.nawrocki@samsung.com>
 <20160627163312.GB17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13])
 by alsa0.perex.cz (Postfix) with ESMTP id D8B852657BE
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 19:59:43 +0200 (CEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O9H00C30TZH2IC0@mailout3.w1.samsung.com> for
 alsa-devel@alsa-project.org; Tue, 28 Jun 2016 18:59:41 +0100 (BST)
In-reply-to: <20160627163312.GB17217@sirena.org.uk>
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
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, Krzysztof Kozlowski <k.kozlowski@samsung.com>, inki.dae@samsung.com, ideal.song@samsung.com
List-Id: alsa-devel@alsa-project.org

On 06/27/2016 06:33 PM, Mark Brown wrote:
> On Thu, Jun 23, 2016 at 12:45:13PM +0200, Sylwester Nawrocki wrote:
> 
>> > +	/* Select analog input by default */
>> > +	regmap_write(map, MAX98504_REG_SPEAKER_SOURCE_SELECT, 0x1);
>
> This should be done by userspace configuration, just leave the chip at
> power on defaults.  This is policy so that we don't have people trying
> to patch their configurations into the kernel.

OK, I will remove this and update the UCM configuration files instead.

>> > +	/* Brownout protection enable */
>> > +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_ENABLE, 0x1);
>> > +	/* Threshold 2.9V, 3dB speaker attenuation*/
>> > +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(1), 0x33);
>> > +	/* Attack hold time 10 ms */
>> > +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(2), 0x0a);
>> > +	/* Brownout hold time 255 ms, brownout release time 255 ms */
>> > +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(3), 0xff);
>> > +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(4), 0xff);
>
> Should these be DT properties?

I'm not sure, these properties define the speaker gain decrease pattern
during VBAT brownout, it seems a system integration detail and will most
likely differ from board to board.  I'd assume it's acceptable to put
these in DT, looking at other bindings.  I've prepared something like
this:

------8<--------
Optional properties:

- maxim,brownout-threshold - the VBAT brownout threshold, the value must be
  from 0, 1...21 range, corresponding to 2.6V, 2.65V...3.65V voltage range
- maxim,brownout-attenuation - the brownout attenuation to the speaker gain
  applied during the "attack hold" and "timed hold" phase, the value must be
  from 0...6 (dB) range
- maxim,brownout-attack-hold-ms - the brownout attack hold phase time in ms,
  0...255 (VBATBROWN_ATTK_HOLD, register 0x0018)
- maxim,brownout-timed-hold-ms - the brownout timed hold phase time in ms,
  0...255 (VBATBROWN_TIME_HOLD, register 0x0019)
- maxim,brownout-release-rate-ms - the brownout release phase step time in ms,
  0...255 (VBATBROWN_RELEASE, register 0x001A)

The default value when the above properties are not specified is 0,
the maxim,brownout-level property must be specified to actually enable
the VBAT brownout protection.
------8<--------
