From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
	driver
Date: Fri, 16 Mar 2012 17:45:09 -0400
Message-ID: <CA+7tXijxUpnoBfrjOEyBeLPF9T9qhBiy6B+8LPVnyNc99mYVQw@mail.gmail.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
	<1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
	<CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
	<20120316111814.GA7860@S2101-09.ap.freescale.net>
	<20120316192110.GH3158@opensource.wolfsonmicro.com>
	<CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
	<4F63B128.7040705@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 9007324402
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 22:45:12 +0100 (CET)
Received: by werg1 with SMTP id g1so4642311wer.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 14:45:09 -0700 (PDT)
In-Reply-To: <4F63B128.7040705@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 16, 2012 at 5:31 PM, Timur Tabi <timur@freescale.com> wrote:
> Trent Piepho wrote:
>> The ESAI and SSI hardware are totally different. =A0SSI gives you a
>> playback and a record stream in an I2S, or I2S like, interface. =A0A
>> stream is mono or stereo. ESAI has IIRC up to six output and four
>> inputs streams. =A0Each stream is in parallel on the same clock, and can
>> have one or more channels.
>
> Are these channels on the same wire in a time-division multiplexing, or on
> six different wires? =A0If it's a TDM, then the SSI can actually do this
> using "network mode", but I don't enable that in the driver, since it's
> not really I2S compliant.

Six different wires.  Each wire can have multiple channels, or
"slots", to do mono, stereo, 5.1, etc.  Each wire needs the same
number of slots, since there is only one frame sync.  And only one bit
clock too.  RX and TX can be synchronous or async.  I know it has
network mode too, but our hardware is I2S so I never bothered to look
into exactly what network mode is.
