From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH] eukrea-tlv320: add support for our i.MX25
 board
Date: Sat, 19 Jun 2010 14:13:49 +0200
Message-ID: <4C1CB47D.1090807@eukrea.com>
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
	by alsa0.perex.cz (Postfix) with SMTP id 4EBB110381B
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 14:13:51 +0200 (CEST)
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

Le 19/06/2010 13:06, Mark Brown a =E9crit :
> On Sat, Jun 19, 2010 at 10:45:04AM +0200, Eric B=E9nard wrote:
>> Le 19/06/2010 02:29, Mark Brown a =E9crit :
>
>>> That's supposed to be being used to build the SSI driver as a separate
>>> module.
>
>> ok, we can suppose that if someone introduce the possibility to
>> build the SSI driver as a separate module, he will add the right
>> Kconfig option.
>
> This should just be a matter of a simple Makefile edit.
>
this should be simple but unless yoou accept it as an untested change, =

it would require testing when built as a module and I don't have the =

bandwitdh to do this testing.

>>>> - 1st board :
>
>>> It'd be helpful to use actual names to make your mails legible,
>>> otherwise it's like Outlook style mail.
>
>> I don't understand what you mean here. What is "Outlook style mail" ?
>
> Replying by adding text at the top of a message without trimming any
> context.
>
there was no top posting in my email and the only goal of 1st/2nd/3rd =

board enumeration was to provide a simple context showing the fact that =

3 MXC boards are handling the Kconfig options in 3 different ways =

(providing the exact CONFIG name of each boards didn't seems to me as a =

necessary information for readers to understand this fact in this context).

Eric
