From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: RME96 driver patch
Date: Tue, 07 Jan 2003 09:10:36 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301071402.h07E2LiX009146@spider.tela.com>
References: <20030107113235.GB20015@tuba.home>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from spider.tela.com (spider.tela.com [206.98.7.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA22814
	for <alsa-devel@alsa-project.org>; Tue, 7 Jan 2003 15:02:38 +0100
In-reply-to: Your message of "Tue, 07 Jan 2003 12:32:35 +0100."
             <20030107113235.GB20015@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: martin-langer@gmx.de
Cc: Jaroslav Kysela <perex@suse.cz>, torger@ludd.luth.se, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Let's suppose this playing is going on and a new fresh input arrives on my
>input channel. So I would think the hardware will run in master mode and the
>software will say: slave mode. I'm really not happy about this solution. I
>would prefer a solution with precise modes or error messages if necassary.

then you need to explicitly set the clock source to "master", and then
the hardware will use its own clock without paying attention to the
outside world.

the standard name for the control is "Sample Clock Source" and the
standard values are "Word", "Internal" or "AutoSync". (see
alsa-driver/doc/ControlNames).

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
