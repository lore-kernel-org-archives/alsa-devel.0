From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: BUG since "ASoC: simple-card: Add pm callbacks to platform
 driver"
Date: Tue, 17 May 2016 14:08:19 +0300
Message-ID: <9ff733b5-6a17-9c1b-c47f-bd6cd2acb877@ti.com>
References: <CAMuHMdX6veYCvRdJjui3J0oPUKLhZB1Y8_AROnqhtZS9=HyNTg@mail.gmail.com>
 <CAMuHMdWfHiaJzvSE5XARcgUPWiJR4ZJ82TdCA53vZ=rQ5wD7EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWfHiaJzvSE5XARcgUPWiJR4ZJ82TdCA53vZ=rQ5wD7EQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 05/17/16 14:02, Geert Uytterhoeven wrote:
> On Tue, May 17, 2016 at 12:55 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> With today's sound-asoc/for-next, I'm seeing on r8a7791/koelsch and
>> sh73a0/kzm9g:
>>
>>     kernel BUG at drivers/base/regmap/regcache.c:347!
>>     Internal error: Oops - BUG: 0 [#1] SMP ARM
>>     Modules linked in:
>>     CPU: 0 PID: 20 Comm: kworker/0:1 Not tainted
>> 4.6.0-koelsch-07135-g1481dd77fa7d01cb #2621
>>     Hardware name: Generic R8A7791 (Flattened Device Tree)
>>     Workqueue: events soc_resume_deferred
>>     task: ef512100 ti: ef5a6000 task.ti: ef5a6000
>>     PC is at regcache_sync+0xc/0x118
>>     LR is at ak4642_resume+0x20/0x28
>=20
> This is during resume from s2ram.

if you revert the patch does the ak4642_resume() is called at all, I th=
ink not.
But in the driver does not implement the .suspend callback, probably th=
is
never worked correctly in ak4642?

--=20
P=C3=A9ter
