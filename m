From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Juli - function of specific GPIOs?
Date: Fri, 18 Jan 2008 22:41:51 +0100
Message-ID: <47911D1F.8030006@insite.cz>
References: <1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>	<1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>	<bc64b4640801151540n4cb66f99u68ba0d42c91b5ff6@mail.gmail.com>
	<20080118101816.GA19291@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id A3AC8246B9
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 22:42:09 +0100 (CET)
In-Reply-To: <20080118101816.GA19291@rakim.wolfsonmicro.main>
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

Hi Takashi,

Sorry for distracting you from the constant struggle with HDA.

I would like to provide complete support for the ESI Juli@ card.
Informing the ADC (AK5385) about current sample rate via the dedicated
GPIOs is fairly simple, as well as the monitoring features (DIGOUT, 
DIGIN, ANAIN, MUTE + volume control of the remaining DACs).

However, I do not understand functions of the GPIO_FREQ_XXKHZ and
GPIO_MULTI_XX GPIOs. The card's user manual says the card can detect
incoming SPDIF rate. AK4114 can either read the rate from the input data
in professional format only, or detect it by comparing external clock 
with the input rate. The AK4114 external clock pin does go to the Xilinx 
CPLD. The GPIOs lead to the CPLD too. Do they in some way control the 
CPLD to provide AK4114 with external clock so that AK4114 can provide 
correct input rate data through its registers?

But if so, where would CPLD get the independent clock when ICE1724 is in 
slave mode, clocked by AK4114? True, the PMCLK output is fed to the 
CPLD, but that would be slaved to AK4114 too. I guess the only 
independent clock during the slave mode would have to come directly from 
the 24.576MHz crystal of ICE, but I could not trace any connection to 
the CPLD.

Perhaps the mysterious AV73-1 helps, I could not google-out any 
information on this IC.

The automated detection of incoming rate is important for setting
correct sample rates in codecs when running on external clock.

If resolved, I would add similar functionality to the MI/ODI/O card for
Prodigy192 too.

I am sorry for bothering you, but the GPIOs named constants in juli.c 
suggest you had access to some documentation about the card. My tracing 
and beeping the card ends with the internal CPLD logic.

Thanks a lot for any information or suggestion.

Best regards,

Pavel Hofman.




-----------------

inSITE, s.r.o.

Rubesova 29, 326 00 Plzen, Czech Republic
Tel., fax: +420 - 37 - 74 493 58
GSM: +420 - 603 - 163 973
Email: pavel.hofman@insite.cz
