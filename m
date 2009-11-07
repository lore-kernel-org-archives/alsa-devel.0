From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] S3C64XX I2S: Enable audio-bus clock
Date: Sat, 7 Nov 2009 12:31:06 +0000
Message-ID: <20091107123106.GD3228@sirena.org.uk>
References: <1257498024-29163-1-git-send-email-jassi.brar@samsung.com>
	<20091106131330.GB10371@rakim.wolfsonmicro.main>
	<1b68c6790911060648w8a3bca6te94ae2fcd221f1ae@mail.gmail.com>
	<20091106150934.GC27699@rakim.wolfsonmicro.main>
	<1b68c6790911061903s30e92a64uaab9f518479b7a6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 88FA5103817
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 13:31:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6790911061903s30e92a64uaab9f518479b7a6b@mail.gmail.com>
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

On Sat, Nov 07, 2009 at 12:03:34PM +0900, jassi brar wrote:

> By the design of the driver, clk_enable for 'audio-bus' too ought to be in
>  driver (just like 'iis'). If some user is enabling it somewhere else, he=
/she is
> not in line with the design.

I suspect that these users were just never enabling the clock at all
rather than enabling it somewhere else.

> > Any news on IISv4 port support? =A0It'd be good to get the SMDKs to the
> > point where they can actually play audio. =A0I had been expecting some
> > followups from your previous patches.

> I will resend some patches which were given reviews. I just got busy.
> Due to different official priorities, the 6channel support implementation=
 got
> delayed. It is definitely on my todo list.

OK, thanks.  Even two channel support for the port would be good since
it'd make it much easier for me to do the enhancements to the wm8580
driver that we were talking about.
