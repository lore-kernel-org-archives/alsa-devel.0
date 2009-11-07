From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] S3C PCM: Added the CPU driver for PCM
 controllers
Date: Sat, 7 Nov 2009 12:27:37 +0000
Message-ID: <20091107122737.GC3228@sirena.org.uk>
References: <1257384917-18368-1-git-send-email-jassi.brar@samsung.com>
	<20091106175058.GH4938@sirena.org.uk>
	<1b68c6790911061918m339d6fe3tfba5ab3cebdfa00c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 173AC103817
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 13:27:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6790911061918m339d6fe3tfba5ab3cebdfa00c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 07, 2009 at 12:18:10PM +0900, jassi brar wrote:
> On Sat, Nov 7, 2009 at 2:50 AM, Mark Brown

> > May as well just clk_set_rate() unconditionally, it'll do no harm to do
> > a null change.

> I believe the clock sources should be touched only when we can't do witho=
ut it.
> clk_get_rate doesn't touch any register, but clk_set_rate does even if ov=
erwrite
> the same value.

I can see your point but if this is required it feels like something
that the clock API ought to be handling it - the same code should be
added pretty much every time the clock might be set.

> >> + =A0 =A0 /* Check for valid device index */
> >> + =A0 =A0 if (pdev->id >=3D ARRAY_SIZE(s3c_pcm)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "id %d out of range\n", =
pdev->id);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> + =A0 =A0 }
> >
> > id could be less than zero too.

> okay. Though i wonder how did it pass review in s3c64xx-i2s.c

When the drivers were originally merged there were quite a few issues
that needed fixing up but it was felt that it was better to get the code
into mainline where it could be worked on more readily.  Ben didn't
really have any time to do much work on the drivers at the time and this
way it's easier for others to pitch in and fix up problems.
