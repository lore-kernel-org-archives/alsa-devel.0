From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
	driver
Date: Fri, 16 Mar 2012 06:16:13 -0400
Message-ID: <CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
	<1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6239C104740
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 11:16:14 +0100 (CET)
Received: by wgbed3 with SMTP id ed3so122103wgb.20
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 03:16:14 -0700 (PDT)
In-Reply-To: <1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 16, 2012 at 4:56 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> +Required properties:
> +- compatible : "fsl,imx-audio-sgtl5000"
> +- model : The user-visible name of this sound complex
> +- ssi-controller : The phandle of the i.MX SSI controller
> +- audio-codec : The phandle of the SGTL5000 audio codec
> +- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX)
> +- mux-ext-port : The external port of the i.MX audio muxer
> +
> +Note: The AUDMUX port numbering should start at 1, which is consistent w=
ith
> +hardware manual.
> +
> +Example:
> +
> +sound {
> + =A0 =A0 =A0 compatible =3D "fsl,imx51-babbage-sgtl5000",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"fsl,imx-audio-sgtl5000";
> + =A0 =A0 =A0 model =3D "imx51-babbage-sgtl5000";
> + =A0 =A0 =A0 ssi-controller =3D <&ssi1>;
> + =A0 =A0 =A0 audio-codec =3D <&sgtl5000>;
> + =A0 =A0 =A0 mux-int-port =3D <1>;
> + =A0 =A0 =A0 mux-ext-port =3D <3>;
> +};

What would the device node look like for the ESAI controller?  I've
got a board here based on an iMX53 with two of three SSI controllers
and the ESAI controller in use.  It used the nullcodec codec driver
for SSI and ESAI.  The ESAI driver was since replaced with an entirely
new custom driver that doesn't use ASoC at all.  But ignoring that
detail, what would the sound node(s) look like for some hardware that
isn't so simple?  It seems like there would be three sound nodes, but
what would compatible and model be set to?  I'm having a hard time
seeing how "fsl,imx-audio-sgtl5000" would be changed into something
for either SSI or ESAI.
