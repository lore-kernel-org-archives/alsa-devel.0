From: <ext-Eero.Nurkkala@nokia.com>
Subject: Re: [PATCH - try2] ASoC: TPA6130A2 amplifier driver
Date: Fri, 9 Oct 2009 16:54:42 +0200
Message-ID: <1FFEF31EBAA4F64B80D33027D42977600E85F0CC99@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1255092941-17586-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255093831.30157.207.camel@eenurkka-desktop>,
	<200910091636.16126.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AA4F103AE6
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 16:57:36 +0200 (CEST)
In-Reply-To: <200910091636.16126.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@nokia.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, eduardo.valentin@nokia.com
List-Id: alsa-devel@alsa-project.org


>> During the tpa6130a2_i2c_write, you read the data->power_state, that
>> may change it's state meanwhile (preempted). Thus, I suggest you using
>> the mutex to cover all i2c writes. (and all tpa read <-> write cycles,
>> so that things are consistent?)
>>
>> A call to tpa6130a2_power() -> preemted over somewhere here, you may
>> have i2c accesses to a chip that's not powered up?
>
> Well it is very unlikely that something like this could ever happen since=
 the
> tpa6130a2_channel_enable and the tpa6130a2_power is called when DAPM is
> enabling/disabling the path. I think in a middle of enable or disable the=
re
> should not be any opposite operation running in DAPM...
> =

> But better to be safe: I can add the mutex_lock, unlock pair.
> =

> I'll wait for more comments and address this one as well.
> =

> --
> P=E9ter

Right, sorry I read the patch too fast =3D) So I guess it's ok like it was.=
 However,
I'll put sleep(n)'s in the problematic places and verify it's 100% ok one o=
f =

these weeks.

- Eero
