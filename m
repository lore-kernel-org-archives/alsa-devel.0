From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] ASoC CS4270 codec device driver
Date: Tue, 31 Jul 2007 11:41:44 -0500
Message-ID: <46AF6648.5000803@freescale.com>
References: <1185896812320-git-send-email-timur@freescale.com>	<s5h4pjkva0g.wl%tiwai@suse.de>	<46AF5F7C.5020309@freescale.com>	<s5h3az4v97m.wl%tiwai@suse.de>
	<s5hy7gwttzp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 91D7524405
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Jul 2007 18:41:48 +0200 (CEST)
In-Reply-To: <s5hy7gwttzp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> OK, now found another problem.  The driver seems not built without
> CONFIG_I2C.
> =

> In file included from sound/soc/codecs/cs4270.c:1:
> sound/soc/codecs/cs4270.c:694: error: =91cs4270_set_dai_sysclk=92 undecla=
red here (not in a function)
> sound/soc/codecs/cs4270.c:695: error: =91cs4270_set_dai_fmt=92 undeclared=
 here (not in a function)
> =

> Shouldn't the driver be dependent on I2C?

Well, technically no.  It should work find without I2C, but I admit I never=
 tried that. =

I'll provide a fix soon.

> Also,
> =

> #ifdef CONFIG_I2C
> =

> isn't enough.  It should be
> =

> #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)

I asked about that a while ago, and I never got an answer.  Where does CONF=
IG_I2C_MODULE =

come from?  I don't see it in any Kconfig or any header file.  And if I2C c=
an be a module, =

then why wouldn't CONFIG_I2C also be defined?

-- =

Timur Tabi
Linux Kernel Developer @ Freescale
