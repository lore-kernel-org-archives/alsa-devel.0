From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Fri, 13 Dec 2013 16:31:40 +0200
Message-ID: <52AB1A4C.3030907@ti.com>
References: <1386939499-5163-1-git-send-email-peter.ujfalusi@ti.com>
 <20131213130443.GY11044@sirena.org.uk> <52AB0BBD.2020001@ti.com>
 <20131213133444.GZ11044@sirena.org.uk> <52AB1244.5010506@ti.com>
 <20131213141814.GG11044@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EC3326163F
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 15:31:44 +0100 (CET)
In-Reply-To: <20131213141814.GG11044@sirena.org.uk>
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

On 12/13/2013 04:18 PM, Mark Brown wrote:
> On Fri, Dec 13, 2013 at 03:57:24PM +0200, Peter Ujfalusi wrote:
>> On 12/13/2013 03:34 PM, Mark Brown wrote:
> =

>>> No, I'd expect the wire behaviour to be identical for any 24 bit samples
>>> (that's certainly what most drivers are written for).  The memory layout
>>> differences shouldn't be visible to CODEC drivers.
> =

>> We can not change the HW... for example:
> =

> This isn't a hardware issue, this is a software issue.
> =

>> twl4030/twl5030: 32 clock cycle/channel and 24 bits used out of that.
> =

> These shouldn't be advertising themselves as supporting 24 bit format
> for ASoC then since they need 32 bit samples on the bus - this is
> actually pretty standard for things that say they support 32 bits, they
> usually just discard some of the lower bits but can cope with 32 bit on
> the interface.
> =

> The reason everything says 24_LE right now is that we're being dumb
> about how we do the constraints and CPUs do care about the memory
> layout, not because the CODECs require the blank cycles.  Of course this
> means that almost anything that does I2S should be able to advertise
> arbatrary sample size support which is one of the resons we ought to be
> doing stuff in the core to make this nicer.

Hrm, not sure about other SoCs but on OMAP most of the formats from memory
ends up on the I2S bus without any bits added/removed so the format actually
applies to the codec side as well since the data arriving to the codec will
have the same layout as it had in the memory.
But, yes some level of logic in the core might help.

>> tlv320aic3106: 24 clock cycle/channel for 24 bit audio.
> =

> This is normal ASoC behaviour.
> =

>> The wire behavior is different and this need to be known by the CPU side=
 as well.
> =

> This isn't the way to do it, though - if the TWL drivers were ever used
> with other CPUs (admittedly unlikely) they'd run into trouble.

The twl drivers (and the dac33) is doing the correct thing IMHO: reporting
S32_LE with set .sig_bits =3D 24. Just to let the user space know that thay
should not use the whole 32bit range.

-- =

P=E9ter
