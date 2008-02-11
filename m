From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Some questions about devices supported by alsa
Date: Mon, 11 Feb 2008 11:49:01 +0100
Message-ID: <47B0281D.1050006@insite.cz>
References: <47ADFFF2.4050803@gmail.com> <47B02752.5020803@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C6B124411
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 11:49:09 +0100 (CET)
In-Reply-To: <47B02752.5020803@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Sergio Atzori <sergioatzori@gmail.com>
List-Id: alsa-devel@alsa-project.org

Just a notice - these commands must be run with Juli's driver unloaded 
(rmmod snd-ice1724) otherwise it locks up the kernel when opening Juli's 
midi device registered in alsa midi. Been there, done that :)

Regards,

Pavel.

Clemens Ladisch wrote:
> Sergio Atzori wrote:
>> 2) Miditech I2 control-37 (http://www.miditech.de/produktee_i2.htm):
>> beatiful usb-keyboard, not mentioned in Linux-USB device site, it does
>> not work in linux...I think the kernel configure it well (as
>> snd-usb-audio device) but I can't see it in Jack midi connections..
> 
> Does it appear in the output of "amidi -l"?
> Does it appear in the output of "aplaymidi -l"?
> 
> 
> Regards,
> Clemens
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
