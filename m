From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Some questions about devices supported by alsa
Date: Mon, 11 Feb 2008 11:13:53 +0100
Message-ID: <47B01FE1.1050504@insite.cz>
References: <47ADFFF2.4050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D1E5624333
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 11:14:00 +0100 (CET)
In-Reply-To: <47ADFFF2.4050803@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Sergio Atzori <sergioatzori@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Sergio,

Esi Juli@ seems to be a different beast than most other ice1724-based 
cards. I am working on the driver, it will take a number of changes to 
the generic ice1724 driver due to presumably different clocking scheme.

The ice1724 midi driver has a bug causing kernel hang when opening the 
device. It has been reported, and Takashi has provided an experimental 
patch.

http://mailman.alsa-project.org/pipermail/alsa-devel/2007-April/000641.html

It would be great if you were able to test the patch. The midi device 
should work (hopefully) using the existing driver for Juli@.

Thanks a lot,

Pavel.






Sergio Atzori wrote:
> Hello, my name is Sergio Atzori. I'm a musician and I love very much
> linux and open source. I have a lot of hardware for music, something
> well supported by linux, something else not supported...I have some
> questions:
> 1) Esi Juli@: reported as supported by alsa, but it isn't. Looking at
> http://www.linuxdriverproject.org/twiki/bin/view/Main/DriversNeeded and
> http://alsa.opensrc.org/index.php/Ice1724, this really beautiful card is
> unusable in linux. I have one and I tried to get it working with some
> distros, but nothing..I experience a computer freeze (kernel panic
> perhaps?) in every attempt to configure it with alsa-conf, or just
> opening an application that uses midi system (like Rosegarden). So I
> would know, there is someone working on a better driver? Can I hope to
> get it working in the near future? According to me there is a lot of
> people waiting for a driver for this card, I'm waiting since 2005..
> 2) Miditech I2 control-37 (http://www.miditech.de/produktee_i2.htm):
> beatiful usb-keyboard, not mentioned in Linux-USB device site, it does
> not work in linux...I think the kernel configure it well (as
> snd-usb-audio device) but I can't see it in Jack midi connections..
> 3) RME AES32 (and AES32express) & Lynx AES16: this driver could be
> important for professional studios..if we want to put linux distros on
> the professional side. I've none of them, but some people ask me to
> build a professional multichannel live machine, I'd like to build a
> linux based machine...there are not alternatives to these cards, because
> I can build a system with more than one of them (really powerful
> multichannel environment).
> 
> Thanks so much for attention.
> Ciao
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
