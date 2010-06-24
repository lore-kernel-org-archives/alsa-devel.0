From: Hans Schou <linux@schou.dk>
Subject: Re: [alsa-devel] PROBLEM: SIS7019 stops recording after 42 min
Date: Thu, 24 Jun 2010 10:08:17 +0200
Message-ID: <AANLkTinlo1B3LtdMuxOYwU8hhcYV69g0JeODfdTVy6if@mail.gmail.com>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org> <AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org> <AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
	<1277129180.22889.64.camel@obelisk.thedillows.org> <AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
	<AANLkTikCGzUKe9Fy1d0xhberqGFe71lvrQbg5gkQzgf1@mail.gmail.com>
	<AANLkTikPW9j4H15gq7nl0Tb213R15uIQAnSDi_cTOJre@mail.gmail.com>
	<1277262047.10818.9.camel@obelisk.thedillows.org> <1277271419.10818.22.camel@obelisk.thedillows.org>
	<AANLkTiln40Xo3fHbMSkEvdBUtFq8ZWrF57wgRWdU2Juc@mail.gmail.com>
	<1277325732.2521.55.camel@lap75545.ornl.gov>
Reply-To: linux@schou.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277325732.2521.55.camel@lap75545.ornl.gov>
Sender: linux-kernel-owner@vger.kernel.org
To: David Dillow <dave@thedillows.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2010/6/23 David Dillow <dave@thedillows.org>:
> On Wed, 2010-06-23 at 20:22 +0200, Hans Schou wrote:

>> =A0 =A0int fd =3D open("/dev/dsp", =A0O_RDWR);
>>
>> This should not go through ALSA (I think). I gues one should use
>> something with "snd_pcm_open()" to use ALSA.
>
> To use ALSA directly, yes. However, there is no OSS SIS7019 driver in
> the kernel, only the ALSA one I wrote. There is an OSS emulation laye=
r,
> so you can use the OSS API to talk to the ALSA core. Unless you are
> using a vendor (SIS/MicroJr/etc.) supplied driver, you are using ALSA=
 in
> some capacity.

OK. Thanks for clearing it out.

I guess I should have programmed against ALSA when I started.

>> I really don't understand why I do not see this problem on other
>> hardware using the same compiled code.
>
> You mean the 10 second pauses during recording after 42 minutes? That=
 is
> a driver bug, so it is specific to this card.

OK. And 42 min is also the only problem I see. I have no problems with
the recorded sounds.

> If you mean the alternating long/sort period times, then it is presen=
t
> on other hardware, but you likely don't see it either due to the
> defaults giving you more periods to work in so you don't see overruns=
,
> faster hardware than the SIS550 CPU, or a combination of the two. The
> bug that gives rise to the 10 second pauses can also shorten the peri=
ods
> I think, making overruns more likely to occur.

OK.

/hans
