From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Terratec Aureon 5.1 MKII slow
Date: Mon, 26 Sep 2005 17:11:24 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509261706330.1797-100000@studcom.urz.uni-halle.de>
References: <21ed1c3705092209171817de22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5125017A
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 17:11:26 +0200 (MEST)
In-Reply-To: <21ed1c3705092209171817de22@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <manuel.jander@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Manuel Jander wrote:
> Why is the maximum buffer so small ?

It's just some random value that was deemed appropriate several years
ago when nobody knew about multichannel interfaces.

> I would have expected that on a USB device the PCM buffer could be
> arbitrary large, so why is it so small ?

Indeed.  Version 1.0.10rc1 has increased this to 256 KB, the current
CVS version has 1 MB.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
