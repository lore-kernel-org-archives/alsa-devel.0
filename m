From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: pxa-ssp: Don't use
	SSCR0_SerClkDiv and SSCR0_SCR
Date: Thu, 19 Mar 2009 13:04:16 +0100
Message-ID: <74d0deb30903190504v1d1e7b5fm13eea63222019a24@mail.gmail.com>
References: <1237451692.14402.10.camel@localhost.localdomain>
	<20090319114809.GC1598@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f175.google.com (mail-bw0-f175.google.com
	[209.85.218.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 82601103905
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 13:04:17 +0100 (CET)
Received: by bwz23 with SMTP id 23so493301bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 05:04:16 -0700 (PDT)
In-Reply-To: <20090319114809.GC1598@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 19, 2009 at 12:48 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Mar 19, 2009 at 09:34:52AM +0100, Philipp Zabel wrote:
>
>> +static u32 ssp_get_scr(struct ssp_dev *dev)
>
> ...
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((ssp_get_scr(ssp) =3D=3D 4) && (width =3D=
=3D 16)) {
>
> but here ssp is a ssp_device, not a ssp_dev (the compiler warns about
> this).

Oh crap.
Please ignore patch 3, then. I'll fix and resend that one when I have
time to think properly about what I'm doing, but I fear the 2.6.29
release will be first.
The patches had a test-run on the magician, but it doesn't use I2S mode.

regards
Philipp
