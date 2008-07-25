From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
	instead of ad1848 one
Date: 25 Jul 2008 15:39:30 +0200
Message-ID: <20080725133930.E76201082492@f22.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id BE715246E2
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 15:39:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

Rene Herman napisa=B3(a):
> >>>> Is this now done in generic code? Not necessary anymore? Was no
> comment =

> >>>> in the changelog.
> >>> The MODE_RUNNING is not used at all in the cs4231 code. I wonder what
> the purpose of it.
> >> It was used by the AD1848 code though; snd_ad1848_trigger() set/reset
> it =

> >> on start/stop and it was then tested by snd_ad1848_interrupt() to
> decide =

> >> whether or not to call snd_pcm_period_elapsed().
> > =

> > It is not used by the cs4231. The only difference is that ad1848 does
> not =

> > call the snd_pcm_period_elapsed() after calling the snd_ad1848_open()
> > but before calling the snd_ad1848_trigger() (and similar restriction
> > after the snd_ad1848_trigger() and snd_ad1848_close().
> > =

> > The cs4231 does not use such restriction. I decided it does not really
> matter.
> > The interrupts are not enabled before and after the
> snd_ad1848_trigger().
> > If the cs4231 driver needed this it would be already causing problems.
> =

> It seems we are talking at cross purposes. I&#039;m not talking about cs4=
231. =

> I see this MODE_RUNNING thing disappear from ad1848_lib and, unless I&#03=
9;ve =

> missed it, not resurface in wss_lib -- that library that after these =

> patches is used to drive AD1848 chips that used to be driven by
> ad1848_lib.
> =

> The MODE_RUNNING looks as something someone will have once added upon =

> seeing spurious IRQs and as such, testing that it isn&#039;t needed on =

> chip/card A, B and C doesn&#039;t tell us much. The problem may have been =

> observed on type D, E or F and/or under condition foo or bar.
> =

> Looking at snd_wss_interrupt() I dom&#039;t seem to be seeing a similar g=
uard =

> after these patches.
> =

> If it&#039;s not needed, all for slashing it but please be convincing. No=
te =

> that by now you should know a lot more about the innards of this code =

> than I do, so please be as verbose as needed.
> =



I cannot be convincing as I am not convinced myself. I understand your reas=
oning.
My situation was that I saw the guard in the ad1848 which was missing in th=
e cs4231
while they should look like twins (in the area when MODE_RUNNING existed). =

I had two choices:

1. Add MODE_RUNNING to the cs4231
2. Remove MODE_RUNNING

The first approach is a bloat to me as I tested on ad1848 and it was not ne=
eded.
I don't know the conditions you called the "condition foo or bar" and I don=
't know =

if it ever exists. I have checked git history on the file, but this one was=
 added
earlier. Maybe there was a kind of approach in the old days then dropped/re=
placed
later (like mutex_open which is not needed now).
The second approach is more dangerous but with enough testing should be jus=
tified
and provides us with cleaner code.

Regards,
Krzysztof

----------------------------------------------------------------------
Te newsy nakreca Cie na caly dzien!
Sprawdz >>> http://link.interia.pl/f1e94
