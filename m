From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Trivial hdsp.c patch to support rev 50 cards
Date: Mon, 28 Jul 2003 08:55:35 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGOEIBCNAB.mknecht@controlnet.com>
References: <E19hA0K-0000rR-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <E19hA0K-0000rR-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
> >   Is this envisioned an option in modules.conf, or a compile
> time option?
>
> modules.conf.
>
> >   Also, while I have your attention, can you clarify whether the RME
> >Hammerfall 9652 and 9636 have mixers? I made one of my 9636 machines into
> >dual boot last evening and then found alsamixer didn't work. I
> assume that
> >means the 9636 has no mixer, or is this a bug I should be reporting
> >somewhere?
>
> the digi9652 and digi9636 have no mixer.
>
> --p
>
Thanks for the info.

So then the only way to set volume levels on a DIGI9652 or DIGI9636 when
using Alsa is either in the application, or using some form of a script
like:

#!/bin/bash

for i in $(seq 1 26);do
amixer -c 0 sset 'Chn',$i 85%
done

Thanks,
Mark




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
