From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: RFC: reworking ASOC for large registers
Date: Tue, 22 Jul 2008 20:09:34 +0100
Message-ID: <20080722190933.GA20555@opensource.wolfsonmicro.com>
References: <9e4733910807201847q6d914e58l567a96904679ada8@mail.gmail.com>
	<9e4733910807211625l3268a1a9m59d6914fb55593c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 523E0103899
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 21:09:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807211625l3268a1a9m59d6914fb55593c6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 21, 2008 at 07:25:21PM -0400, Jon Smirl wrote:

>  /* codec IO */
> -#define snd_soc_read(codec, reg) codec->read(codec, reg)
> -#define snd_soc_write(codec, reg, value) codec->write(codec, reg, value)
> +#define snd_soc_read(codec, reg, value, size) codec->read(codec, reg,
> value, size)
> +#define snd_soc_write(codec, reg, value, size) codec->write(codec,
> reg, value, size)

I appreciate that this is just a work in progress but I did want to flag
up the effect that this will have on drivers for CODECs with normally
sized registers.  Given that this is a fairly unusual case it doesn't
seem sensible to cause drivers to have difficulties writing the
equivalent of:

	snd_soc_write(codec, REG_CONTROL, MAKE_IT_WORK);

if we don't have to.

There's two cases where we have a problem currently: one is with
registers up to 32 bits which I think everyone agrees should Just Work
and the other is much bigger registers like these 32 byte registers your
CODEC has which are a bit more tricky :/ .
