From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [RFC PATCH 1/6] ASoC: sgtl5000: fix regulator
	support
Date: Fri, 06 Mar 2015 14:09:20 -0700
Message-ID: <54FA1780.4060906@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-2-git-send-email-eric.nelson@boundarydevices.com>
 <20150306200415.GW21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id F255C26605D
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 22:09:24 +0100 (CET)
Received: by pdbft15 with SMTP id ft15so17549287pdb.6
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2015 13:09:23 -0800 (PST)
In-Reply-To: <20150306200415.GW21293@sirena.org.uk>
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
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Mark,

Thanks for the review.

On 03/06/2015 01:04 PM, Mark Brown wrote:
> On Thu, Feb 26, 2015 at 03:54:28PM -0700, Eric Nelson wrote:
> 
>> Since the internal LDO can only be enabled after I2C is
>> available, there's no benefit in treating it as a regulator, so
>> this patch removes the regulator structure surrounding it.
> 
> The expected benefit would be that it is possible to then have the
> code that uses the regulator be constant:
> 

That's a nice plan, but doesn't fit, since the internal regulator
requires I2C access and can only be used after the rest of the
power-up sequence has completed.

>> case SND_SOC_BIAS_STANDBY: if (codec->dapm.bias_level ==
>> SND_SOC_BIAS_OFF) { ret = regulator_bulk_enable( -
>> ARRAY_SIZE(sgtl5000->supplies), +						sgtl5000->num_supplies, 
>> sgtl5000->supplies);
> 
> so we avoid stuff like this.
> 

I understand the intent, but that doesn't work. If the internal LDO
is wrapped in a regulator and placed here, the sequence needs to be:
	enable VDDIO and VDDA regulators
	re-enable the clock
	wait 8 cycles
	enable the LDO for VDDD

>> @@ -1115,7 +938,9 @@ static int sgtl5000_set_power_regs(struct
>> snd_soc_codec *codec)
>> 
>> vdda  =
>> regulator_get_voltage(sgtl5000->supplies[VDDA].consumer); vddio =
>> regulator_get_voltage(sgtl5000->supplies[VDDIO].consumer); -	vddd
>> = regulator_get_voltage(sgtl5000->supplies[VDDD].consumer); +
>> vddd  = (sgtl5000->num_supplies > VDDD) +		?
>> regulator_get_voltage(sgtl5000->supplies[VDDD].consumer) +		:
>> LDO_VOLTAGE;
> 
> Please write a normal if statement, this is not legible (and the
> test is more than a little obscure).
> 

Will do (in a V2).

>> -	/* External VDDD only works before revision 0x11 */ -	if
>> (sgtl5000->revision < 0x11) { -		vddd =
>> regulator_get_optional(codec->dev, "VDDD");
> 
> It'd be good to keep at least a warning about this (not that
> there's one now but it's a good idea).
> 

I haven't been able to find the origin of this test, but it's in
conflict with ER1.

>> -	ret = regulator_bulk_get(codec->dev,
>> ARRAY_SIZE(sgtl5000->supplies), +	sgtl5000->num_supplies =
>> ARRAY_SIZE(sgtl5000->supplies) +				 - 1 + external_vddd;
> 
> This is a bit obscure, why not just do this sooner (with a comment
> for the - 1) and increment num_supplies when we add the external
> regulator. A comment on the supply list saying that VDDD must be
> last would be good too.
> 

Agreed. I'll rework it.

>> +	ret = regulator_bulk_enable(sgtl5000->num_supplies, +
>> sgtl5000->supplies); +	if (!ret) +		usleep_range(10, 20);
> 
> This is a separate change...
> 

I changed udelay() to usleep_range() in order to keep
checkpatch happy.

>> +	else +		regulator_bulk_free(sgtl5000->num_supplies, +
>> sgtl5000->supplies);
> 
> Convert to using devm_ since you're doing all this stuff.
> 
> 

Will do.

>> ret = clk_prepare_enable(sgtl5000->mclk); -	if (ret) -		return
>> ret; +	if (ret) { +		dev_err(&client->dev, "Error  enabling clock
>> %d\n", ret); +		goto disable_regs; +	}
> 
> This is a separate fix as far as I can tell?
> 

Not really. Once regulators are moved into the I2C device, we
can't just return because that would leave the regulators enabled.

>> +	/* Follow section 2.2.1.1 of AN3663 */ +	if
>> (sgtl5000->num_supplies <= VDDD) { +		/* internal VDDD at 1.2V
>> */
> 
> These checks are just far too obscure, please set a flag or
> something.
> 

Got it. I'll fix this in V2 (not RFC).

Regards,


Eric
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU+heAAAoJEFUqXmm9AiVrx+0H/3juYAWgD0su7nwPLvw8nhPH
8rGVc/laHcSTC/GBAjomkhmGWTL3Kb/gJo38hEo3GNeq9E6rlqPjP5qQMorcqVSo
agy+GGaPZ6W8AvRoEqyG3r/pN/MrwmT8JtkmMp3iBlPtB9cDfksFmeych697jPuU
gWj9xSuWyrnGcAZPJMrI2xJDfPHQ2/TStNhnR3bvVIAqfdfS8MKbqeUwQJ12gLhM
GeEMTfHwx2P5IBPDucieJtMnl+pX4v+s/IoJdU8gIz1IC4k9jz9OQIFxYocLWcpe
m6DhlTY0gMUdfnMIQ+WnDSk6dzNINglvFUqNsm0sMyXI+2MKZGFD+Dx33qOQX24=
=1he2
-----END PGP SIGNATURE-----
