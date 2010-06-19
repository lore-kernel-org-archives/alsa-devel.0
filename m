From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] eukrea-tlv320: add support for our i.MX25
 board
Date: Sat, 19 Jun 2010 12:06:04 +0100
Message-ID: <20100619110604.GC2409@opensource.wolfsonmicro.com>
References: <1276782241-9407-1-git-send-email-eric@eukrea.com>
	<20100618005637.GA3333@opensource.wolfsonmicro.com>
	<4C1B1BE9.9040802@eukrea.com>
	<20100619002937.GB2463@opensource.wolfsonmicro.com>
	<4C1C8390.8000302@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA549103811
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 13:05:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C1C8390.8000302@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 19, 2010 at 10:45:04AM +0200, Eric B=E9nard wrote:
> Le 19/06/2010 02:29, Mark Brown a =E9crit :

> >That's supposed to be being used to build the SSI driver as a separate
> >module.

> ok, we can suppose that if someone introduce the possibility to
> build the SSI driver as a separate module, he will add the right
> Kconfig option.

This should just be a matter of a simple Makefile edit.

> >>- 1st board :

> >It'd be helpful to use actual names to make your mails legible,
> >otherwise it's like Outlook style mail.

> I don't understand what you mean here. What is "Outlook style mail" ?

Replying by adding text at the top of a message without trimming any
context.
