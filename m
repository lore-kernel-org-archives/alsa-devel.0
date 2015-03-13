From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: dummy codec + simple card combination
Date: Fri, 13 Mar 2015 10:54:22 +0100
Message-ID: <7087ED0D-9625-48EA-9012-A6A05869E014@goldelico.com>
References: <CAAfyv37dgX=6aBYH4FWuJgh=k4jQB1Osh_3fwJhRU5unt6Bd6A@mail.gmail.com>
 <CAAfyv36tTpvWgrKaMySdfYnBcoSAr64NzAH6fCsNt2MN5PX3wg@mail.gmail.com>
 <5502ADD9.9070603@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 85386261497
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 10:54:27 +0100 (CET)
In-Reply-To: <5502ADD9.9070603@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

Hi,

Am 13.03.2015 um 10:28 schrieb Peter Ujfalusi <peter.ujfalusi@ti.com>:

> Hi,
> =

> On 03/12/2015 08:33 PM, Belisko Marek wrote:
>> Hi,
>> =

>> I posted same question on alsa-devel ML this week but I forgot to add
>> sound omap + asoc maintainers (sorry about that)
>> =

>> I'm trying to add audio support for gta04 (for gsm + bt and fm audio).
>> All audio sources are clock masters so basically connection is dummy
>> codecs -> cpu dai (mcbsp ports).
> =

> The FM seams to be slave device (Si4705/Si4721) on the I2S bus.
> But in any of the cases (FM, GSM and BT) how do you configure the DAI for=
mats
> of the 'codecs'? Si47xx has support for I2S, L_JUST and DSP mode for exam=
ple.
> What about the sample formats and rates?

That was previously (before DT) set up in some board specific paches into t=
he
audio systems and partially in the board-file.

> I think there should be a driver for at least the FM.

We control it through its i2c interface and a user space tool which can set=
 up
the Si4721.

> For BT there is a bt-sco
> codec driver but w/o DT support.
> =

>> For implementing such thing I can see 2 options:
>> 1. simple card driver which can easily describe cpu dai interface but
>> dummy codec cannot because there are no DT bindings (there was sever
>> attempts to add DT bindings for dummy-codec but AFAIK none was
>> accepted)
> =

> Yes, the dummy-codec is Linux/ASoC concept and should not be described in=
 DT.
> However I think there should be a way to describing passive DAIs. Slave
> devices only listening, or masters streaming the data.
> But, I think even if you have such a device you do have some control, at =
least
> to enable/disable them...
> =

>> This turns it to only solution to create gta04 soundcard which will
>> get from DT cpu dai links and use in card driver dummy codecs
>> directly.
> =

> I would look up the driver for the FM and write the codec driver for it,
> probably the same can be done for the GSM and add bindings for the bt-sco=
 so
> all of this can work with simple-card.

For GSM there is some special logic for tri-stating a DAI because the
audio channel is wired to the twl4030 *and* a McBSP. This is for either
routing the voice directly to the twl or through the CPU (and some filters,
answering machine, sound scrambling etc.). This needs tri-state support
of the McBSP DX line.

> Or write a custom machine driver and get it done ;)

If you would find time (which is beyond what we can realistically expect) t=
o look
into the non-DT 3.12 kernel where everything works, it would be here:

http://git.goldelico.com/?p=3Dgta04-kernel.git;a=3Dtree;f=3Dsound/soc/omap;=
hb=3DHEAD

Basically we want to rebuild this using DT and use as much standard pieces
as possible. So that we only need to upstream what is missing for full gta04
support.

> =

>> Is my assumption correct? I would like to get some feedback before
>> wasting my time with implementing something which cannot be pushed
>> mainline. Thanks for all suggestions.
>> =

>> BR,
>> =

>> marek
>> =

>> --
>> as simple and primitive as possible
>> -------------------------------------------------
>> Marek Belisko - OPEN-NANDRA
>> Freelance Developer
>> =

>> Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
>> Tel: +421 915 052 184
>> skype: marekwhite
>> twitter: #opennandra
>> web: http://open-nandra.com
>> =

> =

> =

> -- =

> P=E9ter

BR,
Nikolaus
