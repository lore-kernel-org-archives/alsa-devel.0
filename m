From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: ESI Maya44 initial patch
Date: Wed, 06 Feb 2008 15:03:09 +0100
Message-ID: <47A9BE1D.3000601@insite.cz>
References: <47A8A2AC.4000901@lightshed.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BD7CD24449
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 15:03:20 +0100 (CET)
In-Reply-To: <47A8A2AC.4000901@lightshed.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rainer Zimmermann <mail@lightshed.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Piotr Makowski <oponek@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for the reverse engineering.

MI/ODI/O is partially supported in prodigy192.c.

Combination Prodigy192 + MI/ODI/O:

SPDIF-out works automatically (basically kind of a parallel connection 
to the on-board SPDIF-out). The SPDIF input via AK4114 works, I have not 
tested MIDI yet.

Theoretically, the Xilinx array should supply AK4114 with external clock 
for SPDIF rate detection - using the MK73-1 frequency multiplier. I have 
yet to hook up my oscilloscope to analyze the actual functionality. As 
of now the automatic rate detection does not work.

I guess MI/ODI/O support for Maya44 would be fairly similar.

Good luck and best regards,

Pavel Hofman.


Rainer Zimmermann wrote:
> 
> Hello,
> 
> this is the first testing version of the driver for the ESI Maya44 card, 
> which I developed on the initiative of Piotr Makowski.
> 
> The driver is actually an addition to the existing ice1724 code.
> 
> More information can be found in doc/README.maya44 .
> 
> We would appreciate your testing and feedback.
> 
> Also, since I am new to ALSA driver development, I would appreciate 
> feedback on whether the way I integrated this into the ALSA tree is 
> correct.
> 
> 
> Thanks for your feedback and best regards,
> Rainer Zimmermann
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
-----------------

inSITE, s.r.o.

Rubesova 29, 326 00 Plzen
Tel., fax: +420 - 37 - 74 493 58
GSM: +420 - 603 - 163 973
Email: pavel.hofman@insite.cz

www.educity.cz, www.insite.cz
www.meetings.cz, www.hrzive.cz
www.comben.cz, www.hr-online.cz
-------------------------------
Navstivte www.educity.cz, server
s nejvetsi nabidkou profesniho
vzdelavani na ceskem internetu.
