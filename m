From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: future ALSA development
Date: Thu, 3 Jul 2003 18:05:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32900.81.50.18.84.1057248308.squirrel@www.undata.org>
References: <Pine.LNX.4.44.0306222010030.1838-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from undata.org (12-186-106-62.kaptech.net [62.106.186.12])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA24591
	for <alsa-devel@alsa-project.org>; Thu, 3 Jul 2003 17:58:09 +0200
In-Reply-To: <Pine.LNX.4.44.0306222010030.1838-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Hello all,
>
> 	here are my next goals for the ALSA library development (short
> term). I invite all developers to comment these directions.
>

[...]

> * initiate a development of a graphical tool which will manage
>   the alsa configuration files (~/.asoundrc)
>   - we need a rapid development tool; I slowly became a fan of python
> and
>     Qt has rich number of widgets; python + PyQt seems to me a good idea
>   - using python requires to write a GPLed ALSA 0.9 -> python wrapper
>

One point I would like to bring to focus is how sound hardware state
persistance is dealt with. The limits of alsactl are showing up with
hardware like the hdsp, were the card might not be fully initialized (or
not even present yet, e.g. cardbus) at boot time. We're more and more
likely to have to deal with such external hotpluggable devices (pcmcia,
firewire, usb), where full initialization can happen any time after the
boot process, and we can't expect the average user to be scripting around.

IMHO state restoration could be :
* triggered by the driver, at the appropriate time, depending maybe on
some system configuration options.
* initiated by the user, through the configuration GUI.

We could have a default configuration restored by the driver at
initialization time, and a set of named configurations the user could
save/restore/set as default using the GUI.

There are probably other ways to handle this, I'm waiting for your comments.

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
