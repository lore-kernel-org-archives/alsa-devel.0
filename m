From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH] eukrea-tlv320: add support for our i.MX25
 board
Date: Sat, 19 Jun 2010 10:45:04 +0200
Message-ID: <4C1C8390.8000302@eukrea.com>
References: <1276782241-9407-1-git-send-email-eric@eukrea.com>	<20100618005637.GA3333@opensource.wolfsonmicro.com>	<4C1B1BE9.9040802@eukrea.com>
	<20100619002937.GB2463@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 29.mail-out.ovh.net (29.mail-out.ovh.net [87.98.216.213])
	by alsa0.perex.cz (Postfix) with SMTP id E8F72103805
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 10:45:08 +0200 (CEST)
In-Reply-To: <20100619002937.GB2463@opensource.wolfsonmicro.com>
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

Le 19/06/2010 02:29, Mark Brown a =E9crit :
> On Fri, Jun 18, 2010 at 09:10:33AM +0200, Eric B=E9nard wrote:
>> This Kconfig seems to have unecessary things into it :
>> - config SND_MXC_SOC_SSI :
>> 	not used in the kernel
>
> That's supposed to be being used to build the SSI driver as a separate
> module.
>
ok, we can suppose that if someone introduce the possibility to build =

the SSI driver as a separate module, he will add the right Kconfig option.

>> - 1st board :
>
> It'd be helpful to use actual names to make your mails legible,
> otherwise it's like Outlook style mail.
>
I don't understand what you mean here. What is "Outlook style mail" ?

>> Please find attached a patch which should clean this Kconfig. If
>> it's ok for you, I'll submit it the right way.
>
> This isn't the best approach, converting things so SND_IMX_SOC is a menu
> and we don't need to reference that at all from the individual items
> would be nicer since it saves having to do per-board handling.

OK, if I understood correctly what you mean here, the following patch =

should be better.

Thanks,
Eric
