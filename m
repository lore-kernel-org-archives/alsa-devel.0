From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: dummy codec + simple card combination
Date: Tue, 17 Mar 2015 16:07:25 +0200
Message-ID: <5508351D.7050304@ti.com>
References: <CAAfyv37dgX=6aBYH4FWuJgh=k4jQB1Osh_3fwJhRU5unt6Bd6A@mail.gmail.com>
 <CAAfyv36tTpvWgrKaMySdfYnBcoSAr64NzAH6fCsNt2MN5PX3wg@mail.gmail.com>
 <5502ADD9.9070603@ti.com>
 <7087ED0D-9625-48EA-9012-A6A05869E014@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id C7CD7264F23
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 15:07:31 +0100 (CET)
In-Reply-To: <7087ED0D-9625-48EA-9012-A6A05869E014@goldelico.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

On 03/13/2015 11:54 AM, Dr. H. Nikolaus Schaller wrote:
> =

> For GSM there is some special logic for tri-stating a DAI because the
> audio channel is wired to the twl4030 *and* a McBSP. This is for either
> routing the voice directly to the twl or through the CPU (and some filter=
s,
> answering machine, sound scrambling etc.). This needs tri-state support
> of the McBSP DX line.
> =

>> Or write a custom machine driver and get it done ;)
> =

> If you would find time (which is beyond what we can realistically expect)=
 to look
> into the non-DT 3.12 kernel where everything works, it would be here:
> =

> http://git.goldelico.com/?p=3Dgta04-kernel.git;a=3Dtree;f=3Dsound/soc/oma=
p;hb=3DHEAD
> =

> Basically we want to rebuild this using DT and use as much standard pieces
> as possible. So that we only need to upstream what is missing for full gt=
a04
> support.

I see. You have had written dummy codecs for the GSM, BT, the FM had an act=
ual
working driver.

Hrm. There is one thing which would make sense for these audio devices:
Since you do not have control over them in terms of formats, rates and
protocol - they use fixed interfaces.

I think it would make sense to have binding for something like:
compatible =3D "fixed-codec" or something like that, implying that it's
configuration can not be changed.
In it's bindings you would have the supported properties of the interface,
like rate, channels, sample width, protocol on the bus (I2S, DSP, etc) and =
to
indicate if it is bus master or slave.

You could use this 'fixed-codec' to describe the DAIs and use simple-card to
connect them with the CPU.

I think this will fill in some gaps and it is actually going to describe the
HW you have as well, so it is not Linux specific.

> =

>>
>>> Is my assumption correct? I would like to get some feedback before
>>> wasting my time with implementing something which cannot be pushed
>>> mainline. Thanks for all suggestions.
>>>
>>> BR,
>>>
>>> marek
>>>
>>> --
>>> as simple and primitive as possible
>>> -------------------------------------------------
>>> Marek Belisko - OPEN-NANDRA
>>> Freelance Developer
>>>
>>> Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
>>> Tel: +421 915 052 184
>>> skype: marekwhite
>>> twitter: #opennandra
>>> web: http://open-nandra.com
>>>
>>
>>
>> -- =

>> P=E9ter
> =

> BR,
> Nikolaus
> =



-- =

P=E9ter
