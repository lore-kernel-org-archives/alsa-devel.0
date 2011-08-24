From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Wed, 24 Aug 2011 13:44:55 +0200
Message-ID: <4E54E437.7020209@ladisch.de>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
	<4E53959A.7090702@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id BD4B4103942
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 13:44:54 +0200 (CEST)
In-Reply-To: <4E53959A.7090702@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Kristian Amlie wrote:
> I tried 38400 baud, and that seemed to work. I got a small number
> of bytes everytime I pressed a key on the instrument.
> 
> 18 f9 ff 18 03 f8
> 18 f9 ff 18 01 f8
> 18 f9 ff 18 01 f8
> 18 fb ff 18 01 f8
> 18 fb ff 18 01 f8
> 18 fb ff 18 03 f8
> 18 f9 ff 18 01 f8
> 18 fb ff 18 01 f8
> 18 fb ff 18 01 f8
> 18 fb ff 18 01 f8

This is not MIDI.  However, these value might by explained by
a 31250-baud signal sampled at 38400 baud.

> Daniel Mack wrote:
> > I think that requires a special divider setup that is not
> > supported by the ftdi_sio driver.

Indeed.

Kristian, what do the .inf files that come with the Windows driver say?


Regards,
Clemens
