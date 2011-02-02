From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: WL1273 FM Radio driver...
Date: Wed, 02 Feb 2011 13:35:01 -0200
Message-ID: <4D4979A5.1020000@redhat.com>
References: <1295363063.25951.67.camel@masi.mnp.nokia.com> <20110130232358.GD2565@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20110130232358.GD2565@sortiz-mobl>
Sender: linux-media-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, hverkuil@xs4all.nl, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em 30-01-2011 21:23, Samuel Ortiz escreveu:
> Hi Matti,
>=20
> On Tue, Jan 18, 2011 at 05:04:23PM +0200, Matti J. Aaltonen wrote:
>> Hello
>>
>> I have been trying to get the WL1273 FM radio driver into the kernel=
 for
>> some time. It has been kind of difficult, one of the reasons is that=
 I
>> didn't realize I should have tried to involve all relevant maintaine=
rs
>> to the discussion form the beginning (AsoC, Media and MFD). At Mark'=
s
>> suggestion I'm trying to reopen the discussion now.
>>
>> The driver consists of an MFD core and two child drivers (the audio
>> codec and the V4L2 driver). And the question is mainly about the rol=
e of
>> the MFD driver: the original design had the IO functions in the core=
=2E
>> Currently the core is practically empty mainly because Mauro very
>> strongly wanted to have =E2=80=9Ceverything=E2=80=9D in the V4L2 dri=
ver.
> What was Mauro main concerns with having the IO part in the core ?
> A lot of MFD drivers are going that path already.

My concerns is that the V4L2-specific part of the code should be at dri=
vers/media.
I prefer that the specific MFD I/O part to be at drivers/mfd, just like
the other drivers.

Cheers,
Mauro
