From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Wed, 24 Aug 2011 18:01:58 +0200
Message-ID: <4E552076.7080905@ladisch.de>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
	<4E53959A.7090702@amlie.name> <4E54E437.7020209@ladisch.de>
	<4E54FA4A.5000809@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 025CD103910
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 18:01:56 +0200 (CEST)
In-Reply-To: <4E54FA4A.5000809@amlie.name>
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
> On 08/24/11 13:44, Clemens Ladisch wrote:
> > Kristian, what do the .inf files that come with the Windows driver say?
> 
> I have attached the three files that come with the installation. I'm not
> sure what to look for myself, I'm afraid.

ftdiport.inf says:
| HKR,,"ConfigData",1,11,04,00,00,10,27,00,00,88,13,00,00,C4,09,00,00,E2,04,00,00,71,02,00,00,38,41,00,00,9C,80,00,00,4E,C0,00,00,34,00,00,00,1A,00,00,00,0D,00,00,00,06,40,00,00,03,80,00,00,00,00,00,00,D0,80,00,00

These are just the standard baud rates.  But the driver doesn't expose
a COM port with selectable baud rates anyway.

The dmusftdi.sys driver was written by Starr Labs.  I guess it manually
sets a custom baud rate.

I'll look into how to set a custom baud rate.


Regards,
Clemens
