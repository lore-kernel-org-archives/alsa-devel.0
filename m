From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Trivial hdsp.c patch to support rev 50 cards
Date: Mon, 28 Jul 2003 12:23:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19hAfE-0007jP-00@sc8-sf-list1.sourceforge.net>
References: <NDBBLGIKBJENLAMOLFHGOEIBCNAB.mknecht@controlnet.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 28 Jul 2003 08:55:35 PDT."
             <NDBBLGIKBJENLAMOLFHGOEIBCNAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>So then the only way to set volume levels on a DIGI9652 or DIGI9636 when
>using Alsa is either in the application, or using some form of a script
>like:
>
>#!/bin/bash
>
>for i in $(seq 1 26);do
>amixer -c 0 sset 'Chn',$i 85%
>done

only in the application. there is *no* mixer, nothing for ALSA to
control. whatever is written to the PCM data buffer is what comes out
of the hardware.

--p


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
