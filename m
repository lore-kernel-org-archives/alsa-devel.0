From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: How to set idle S/PDIF sample rate?
Date: Wed, 27 Feb 2008 15:28:09 +0100
Message-ID: <47C57379.3060807@insite.cz>
References: <200802222234.22975.matt@whitlock.name>	<200802251403.21651.matt@whitlock.name>	<s5hskzfu89e.wl%tiwai@suse.de>
	<200802261725.35575.matt@whitlock.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz
	(171-43-207-85.zapcechy.adsl-llu.static.bluetone.cz [85.207.43.171])
	by alsa0.perex.cz (Postfix) with ESMTP id F0EFB246EF
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 15:28:31 +0100 (CET)
In-Reply-To: <200802261725.35575.matt@whitlock.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matt Whitlock <matt@whitlock.name>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matt Whitlock wrote:
> 
> Can I assume at this point that there is no way to set the idle S/PDIF output sample rate to 44100 Hz?  That is my original question.

I have no experience with HDA. In ICE1712/24 the spdif-out outputs 
signal corresponding to the current sampling frequency the chip is 
running on, containing no data. When playing sound, the chip clock 
switches to appropriate frequency, and spdif outputs data of this 
frequency. I.e. if the "parking, idle, default" frequency is 44.1kHz, it 
continuously outputs 44.1kHz SPDIF signal.

I guess if you could force HDA to default to 44.1kHz (no idea whether it 
is feasible), that would be it.

Pavel.

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
