From: Sven Zeisberg <sven.zeisberg@googlemail.com>
Subject: Re: Problem to init AD1938 on i.MX25
Date: Mon, 16 Aug 2010 10:39:40 +0200
Message-ID: <4C68F94C.8090703@googlemail.com>
References: <4C68C3C5.5030701@googlemail.com>
	<20100816073040.GH27749@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D13210380C
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 10:40:06 +0200 (CEST)
Received: by bwz10 with SMTP id 10so1891290bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2010 01:40:06 -0700 (PDT)
In-Reply-To: <20100816073040.GH27749@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  Thank you, Sascha, for helping!

You're probably right - there is actually no "i.MX25" path in the SPI =

driver!
Since I'm on a congress for the rest of the week, a colleague of mine =

will takeover and return with the results of the test you suggested.

*/Sven Chris Zeisberg
/*
*Zeisberg GmbH*
Wilhelmstrasse 162 Geb=E4ude 16
72805 Lichtenstein

Tel

	=


	=


+49 (0) 7129 938 277 10

Fax

	=


	=


+49 (0) 7129 938 277 77

Mobile

	=


	=


+49 (0) 163 27 66 769

e-Mail

	=


	=


sven.zeisberg@zego.org <mailto:sven_zeisberg@zego.org>

Web

	=


	=


www.zego.org <http://www.zego.org/>

Hauptsitz der Gesellschaft / Head Office: Wilhelmstrasse 162, Geb=E4ude =

16, D-72805 Lichtenstein
Registergericht Stuttgart HRB 723336
USt.-Id Nr.: DE254794586
Gesch=E4ftsf=FChrer / General Manager: Sven Zeisberg

Der Inhalt dieser e-Mail ist vertraulich. Geben Sie den Inhalt nicht =

weiter und verwenden Sie keine Informationen daraus, falls Sie nicht der =

gew=FCnschte Empf=E4nger sind. Falls Ihnen diese e-Mail f=E4lschlicherweise =

geschickt wurde, machen Sie uns bitte unverz=FCglich durch R=FCcksendung =

darauf aufmerksam und l=F6schen Sie das Dokument.
This e-mail (including any attachments) is intended for the addressee(s) =

stated above only and may contain confidential information protected by =

law. You are hereby notified that any unauthorized reading, disclosure, =

copying or distribution of this e-mail or use of information contained =

herein is strictly prohibited and may violate rights to proprietary =

information. If you are not an intended recipient, please return this =

e-mail to the sender and delete it immediately hereafter.


Am 16.08.2010 09:30, schrieb Sascha Hauer:
> Hello Sven,
>
> On Mon, Aug 16, 2010 at 06:51:17AM +0200, Sven Zeisberg wrote:
>>    Hello,
>>
>> we're working on an ALSA  driver for AD1938 for i.MX25 based system.
>> On the I=B2S the CODEC is Master. On the SPI, the MCU is Master.
>>
>> SSI seems to work (when we set the CODEC as Master by Hardware).
>>
>> We have problems to get the communication via SPI working. The CODEC
>> requires 24Bit words and we can set SPI according to this in the
>> board-file and verify this also with a logic analyzer. However, we can
>> send only one word to the CODEC! This first word is transferred
>> correctly, but all subsequent transfers show no activity on the SPI
>> lines. We do not get any error messages from the SPI drivers! All SPI
>> writes after the first word seem to be executed in software but show not
>> effect in hardware. All reads return 0xff.
> This is probaly more a problem in the SPI driver than alsa related. The
> i.MX SPI unit comes in many different variants and there may well be a
> bug in the i.MX25 path. As a test you could configure the SPI pads in
> gpio mode and use the bitbang gpio spi driver (drivers/spi/spi_gpio.c).
> When this works you can hunt down the bug in the SPI driver.
>
> Sascha
>
