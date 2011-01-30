From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: WL1273 FM Radio driver...
Date: Mon, 31 Jan 2011 00:23:59 +0100
Message-ID: <20110130232358.GD2565@sortiz-mobl>
References: <1295363063.25951.67.camel@masi.mnp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1295363063.25951.67.camel@masi.mnp.nokia.com>
Sender: linux-media-owner@vger.kernel.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, mchehab@redhat.com, hverkuil@xs4all.nl, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Matti,

On Tue, Jan 18, 2011 at 05:04:23PM +0200, Matti J. Aaltonen wrote:
> Hello
>=20
> I have been trying to get the WL1273 FM radio driver into the kernel =
for
> some time. It has been kind of difficult, one of the reasons is that =
I
> didn't realize I should have tried to involve all relevant maintainer=
s
> to the discussion form the beginning (AsoC, Media and MFD). At Mark's
> suggestion I'm trying to reopen the discussion now.
>=20
> The driver consists of an MFD core and two child drivers (the audio
> codec and the V4L2 driver). And the question is mainly about the role=
 of
> the MFD driver: the original design had the IO functions in the core.
> Currently the core is practically empty mainly because Mauro very
> strongly wanted to have =E2=80=9Ceverything=E2=80=9D in the V4L2 driv=
er.
What was Mauro main concerns with having the IO part in the core ?
A lot of MFD drivers are going that path already.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
