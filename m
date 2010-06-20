From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH] eukrea-tlv320: add support for our i.MX25
 board
Date: Sun, 20 Jun 2010 21:17:11 +0200
Message-ID: <4C1E6937.6050903@eukrea.com>
References: <1276782241-9407-1-git-send-email-eric@eukrea.com>
	<20100618005637.GA3333@opensource.wolfsonmicro.com>
	<4C1B1BE9.9040802@eukrea.com>
	<20100619002937.GB2463@opensource.wolfsonmicro.com>
	<4C1C8390.8000302@eukrea.com>
	<20100619110604.GC2409@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 29.mail-out.ovh.net (29.mail-out.ovh.net [87.98.216.213])
	by alsa0.perex.cz (Postfix) with SMTP id D932210383C
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jun 2010 21:17:13 +0200 (CEST)
In-Reply-To: <20100619110604.GC2409@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Le 19/06/2010 13:06, Mark Brown a =E9crit :
> On Sat, Jun 19, 2010 at 10:45:04AM +0200, Eric B=E9nard wrote:
>> ok, we can suppose that if someone introduce the possibility to
>> build the SSI driver as a separate module, he will add the right
>> Kconfig option.
>
> This should just be a matter of a simple Makefile edit.
>
OK, I gave this a quick try and it doesn't seem actually possible to =

compile imx-ssi.c as a module without changing some code to separate ssi =

and pcm parts which are actually mixed in imx-ssi.c.
So actually, selecting SND_IMX_SOC as a module produces snd-soc.imx.ko =

which integrates the SSI driver + the PCM drivers.

So actually the 3 following configurations are possible (and tested on =

my i.MX27 board)  with the patch I sent for Kconfig :
- imx soc driver in kernel, board driver in kernel
- imx soc driver in kernel, board driver (snd-soc-eukrea-tlv320.ko) as a =

module
- imx soc driver (snd-soc-imx.ko) and board driver =

(snd-soc-eukrea-tlv320.ko) as 2 modules.

Also thanks for suggesting this Makefile edit, this allowed me to fix =

sound support for my board when soc is compiled as a module ;-)

Eric
