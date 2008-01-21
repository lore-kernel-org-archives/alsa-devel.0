From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Juli - function of specific GPIOs?
Date: Mon, 21 Jan 2008 17:05:23 +0100
Message-ID: <4794C2C3.2050800@insite.cz>
References: <1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>	<bc64b4640801151540n4cb66f99u68ba0d42c91b5ff6@mail.gmail.com>	<20080118101816.GA19291@rakim.wolfsonmicro.main>	<47911D1F.8030006@insite.cz>
	<s5h63xncgxe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EFF424548
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 17:05:59 +0100 (CET)
In-Reply-To: <s5h63xncgxe.wl%tiwai@suse.de>
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
> At Fri, 18 Jan 2008 22:41:51 +0100,
> Pavel Hofman wrote:
> =

>>Hi Takashi,
>>
>>Sorry for distracting you from the constant struggle with HDA.
>>
>>I would like to provide complete support for the ESI Juli@ card.
>>Informing the ADC (AK5385) about current sample rate via the dedicated
>>GPIOs is fairly simple, as well as the monitoring features (DIGOUT, =

>>DIGIN, ANAIN, MUTE + volume control of the remaining DACs).
>>
>>However, I do not understand functions of the GPIO_FREQ_XXKHZ and
>>GPIO_MULTI_XX GPIOs. The card's user manual says the card can detect
>>incoming SPDIF rate. AK4114 can either read the rate from the input data
>>in professional format only, or detect it by comparing external clock =

>>with the input rate. The AK4114 external clock pin does go to the Xilinx =

>>CPLD. The GPIOs lead to the CPLD too. Do they in some way control the =

>>CPLD to provide AK4114 with external clock so that AK4114 can provide =

>>correct input rate data through its registers?
> =

> =

> Sorry, I have little idea about Juli (and all ESI boards).  The
> datasheet was given only to Jaroslav (cc'ed) at that time.
> =

> =

> Takashi

Takashi,

Thanks a lot for the info and sorry for overlooking the initial =

changetset author.

Perhaps Jaroslav will find a few minutes to recall the old story, p=ECkn=EC =

pros=EDm :)

Regards,

Pavel.

-- =

-----------------

inSITE, s.r.o.

Rubesova 29, 326 00 Plzen
Tel., fax: +420 - 37 - 74 493 58
GSM: +420 - 603 - 163 973
Email: pavel.hofman@insite.cz
