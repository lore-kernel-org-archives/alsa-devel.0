From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic3x: Add output driver
 pop reduction controls
Date: Mon, 10 Nov 2014 15:23:04 +0200
Message-ID: <5460BC38.9010707@ti.com>
References: <1415615253-28919-1-git-send-email-peter.ujfalusi@ti.com>
 <20141110105155.GL3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id E5992261557
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 14:23:08 +0100 (CET)
In-Reply-To: <20141110105155.GL3815@sirena.org.uk>
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
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/10/2014 12:51 PM, Mark Brown wrote:
> On Mon, Nov 10, 2014 at 12:27:32PM +0200, Peter Ujfalusi wrote:
> =

>> +static const struct soc_enum aic3x_pop_reduction_enum[] =3D {
>> +	SOC_ENUM_SINGLE(HPOUT_POP_REDUCTION, 4, 12, aic3x_poweron_time),
>> +	SOC_ENUM_SINGLE(HPOUT_POP_REDUCTION, 2, 4, aic3x_rampup_step),
>> +};
> =

>> +	/* Pop reduction */
>> +	SOC_ENUM("Output Driver Power-On time", aic3x_pop_reduction_enum[0]),
>> +	SOC_ENUM("Output Driver Ramp-up step", aic3x_pop_reduction_enum[1]),
> =

> Don't add arrays of enums with magic number indexes like this, it's hard
> to read and hence error prone.

I agree on this. I have not changed this since this driver is using enums l=
ike
this and I thought it is better to follow the style.

But if I add these to the aic3x_enum[] array with a define for the ID I thi=
nk
it is going to be a bit better?

-- =

P=E9ter
