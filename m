From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH - try2] ASoC: TPA6130A2 amplifier driver
Date: Fri, 9 Oct 2009 16:36:16 +0300
Message-ID: <200910091636.16126.peter.ujfalusi@nokia.com>
References: <1255092941-17586-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255093831.30157.207.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id D600E103ACF
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 15:36:39 +0200 (CEST)
In-Reply-To: <1255093831.30157.207.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Friday 09 October 2009 16:10:31 Nurkkala Eero.An (EXT-Offcode/Oulu) wrot=
e:
> On Fri, 2009-10-09 at 14:55 +0200, Ujfalusi Peter (Nokia-D/Tampere)
> =

> =

> During the tpa6130a2_i2c_write, you read the data->power_state, that
> may change it's state meanwhile (preempted). Thus, I suggest you using
> the mutex to cover all i2c writes. (and all tpa read <-> write cycles,
> so that things are consistent?)
> =

> A call to tpa6130a2_power() -> preemted over somewhere here, you may
> have i2c accesses to a chip that's not powered up?

Well it is very unlikely that something like this could ever happen since t=
he =

tpa6130a2_channel_enable and the tpa6130a2_power is called when DAPM is =

enabling/disabling the path. I think in a middle of enable or disable there =

should not be any opposite operation running in DAPM...

But better to be safe: I can add the mutex_lock, unlock pair.

I'll wait for more comments and address this one as well.

-- =

P=E9ter
