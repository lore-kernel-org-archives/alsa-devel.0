From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: How to support multiple open in low-level driver
Date: Mon, 06 Jan 2003 11:25:44 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301061617.h06GHe2a014305@spider.tela.com>
References: <3E19A62E.20402@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from spider.tela.com (spider.tela.com [206.98.7.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA02532
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 17:17:54 +0100
In-reply-to: Your message of "Tue, 07 Jan 2003 00:52:14 +0900."
             <3E19A62E.20402@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>In the interest of correct documentation how is this explained:
>
>hw:0,0
>
>The first zero is the card number?
>The second zero is the device number?

the first index is the card number, the second is the device and the
third (rarely used) is the subdevice.

>What happens for sound devices that are not cards? For example the usb 
>quattro.

its still a "card" in the sense that its a specific driver controlling
a specific piece of hardware. perhaps "device" is a better term. it
corresponds to the index shown in /proc/asound/cards.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
