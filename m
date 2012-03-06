From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 16/17] ASoC: fsl: add dt support for
	imx-audmux
Date: Tue, 6 Mar 2012 21:13:11 +0800
Message-ID: <CAAQ0ZWRTrb2Epa+14i+ry0XdvFrOzaV-BYfV0ra7x5E63hzFnw@mail.gmail.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-17-git-send-email-shawn.guo@linaro.org>
	<20120306124925.GR19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BC4E61044FE
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 14:13:11 +0100 (CET)
Received: by bkwj10 with SMTP id j10so4292025bkw.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 05:13:11 -0800 (PST)
In-Reply-To: <20120306124925.GR19635@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Richard Zhao <richard.zhao@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 6 March 2012 20:49, Mark Brown <broonie@opensource.wolfsonmicro.com> wro=
te:
> On Mon, Mar 05, 2012 at 10:31:04PM +0800, Shawn Guo wrote:
>> From: Richard Zhao <richard.zhao@linaro.org>
>>
>> It adds device tree probe support for imx-audmux driver.
>
> Applied this one as well, thanks. =A0This really should've been in with
> all the other audmux motion stuff, there's no dependency on it having
> been moved into the fsl directory so it just makes it harder to apply
> (but as it was a straight move git am figured it out).
>
> As a general rule put bugfixes first, then minor cleanups, then things
> that are internal to existing files (like this) and finally anything
> invasive. =A0Basically, do the urgent stuff first and then work up in
> terms of how big/tricky the changes are. =A0This makes it easier to get
> things applied which is especially important with a large series like
> this as it makes review easier and means you have fewer out of tree
> patches to keep track of.

Thanks for the suggestion, Mark.

Regards,
Shawn
