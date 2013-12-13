From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Fri, 13 Dec 2013 15:57:24 +0200
Message-ID: <52AB1244.5010506@ti.com>
References: <1386939499-5163-1-git-send-email-peter.ujfalusi@ti.com>
 <20131213130443.GY11044@sirena.org.uk> <52AB0BBD.2020001@ti.com>
 <20131213133444.GZ11044@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 70FF7260376
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 14:57:32 +0100 (CET)
In-Reply-To: <20131213133444.GZ11044@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/13/2013 03:34 PM, Mark Brown wrote:
> On Fri, Dec 13, 2013 at 03:29:33PM +0200, Peter Ujfalusi wrote:
>> On 12/13/2013 03:04 PM, Mark Brown wrote:
> =

>>> This should be adding the case for the new format rather than replacing
>>> the old one shouldn't it?  They ought to turn out the same on the AIF so
>>> the CODECs shouldn't care about the difference, ideally the core would
>>> hide the difference from them.
> =

>> Not really since the codec has only field to specify the data format. The
>> codec can not support S24_LE (S24_LE is basically S32_LE msbits=3D=3D24)=
 since we
>> can not say to the codec to ignore the 8bit over the 24 bits of real dat=
a.
>> In case of S24_3LE the I2S bus will have 24 clocks/per channel which can=
 not
>> be used to stream S24_LE either.
> =

> No, I'd expect the wire behaviour to be identical for any 24 bit samples
> (that's certainly what most drivers are written for).  The memory layout
> differences shouldn't be visible to CODEC drivers.

We can not change the HW... for example:
twl4030/twl5030: 32 clock cycle/channel and 24 bits used out of that.
tlv320aic3106: 24 clock cycle/channel for 24 bit audio.

The wire behavior is different and this need to be known by the CPU side as=
 well.

-- =

P=E9ter
