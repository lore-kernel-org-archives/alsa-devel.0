From: =?iso-8859-1?q?G=EDsli?= <glvals@internet.is>
Subject: Re: [PATCH] Initial support of the Mitac 8252D (based
	on ALC883)
Date: Fri, 7 Dec 2007 13:23:26 +0000
Message-ID: <200712071323.26407.glvals@internet.is>
References: <20071206094612.GB24527@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vxout-2.c.is (vxout-2.c.is [213.176.128.14])
	by alsa0.perex.cz (Postfix) with ESMTP id C5F1E244DA
	for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2007 14:24:50 +0100 (CET)
Received: from mail.internet.is (mail.aknet.is [193.4.194.58])
	by vxout-2.c.is (Postfix) with ESMTP id 64E312FCCDD
	for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2007 13:24:34 +0000 (GMT)
Received: from localhost (194-144-122-157.du.xdsl.is [194.144.122.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.internet.is (Postfix) with ESMTP id 7541A1793
	for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2007 13:24:27 +0000 (CUT)
In-Reply-To: <20071206094612.GB24527@serv.smile.org.ua>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

=DEann Fimmtudagur 06 desember 2007 skrifa=F0i Andy Shevchenko:
> Hi!
>
> The attached patch adds initial support of the Mitac 8252D
> (http://www.mitac-mtc.com.tw/English/products/8252Dspec.htm).

Thanks allot Andy! great work :)

>
> Working:
>  - Front speakers (volume + mute)
>  - Center/LFE speakers (volume + mute)
>  - HP out (with Front Volume)
>  - HP individual mute switch
>  - HP Jack sense
>  - Front Mic and its volume
>
> Not tested:
>  - external mic and its volume
>
> Not working while now:
>  - Mic Jack sense
>
> Questionable:
>  - is Mic have Jack sense?
>  - one or two Mic volume controls?
>  - CD/Line-in: presense in the mixer
According to the manual that comes with windows, the external mic mutes the =

internal one, but I don't have windows

Now kmix comes up with the headphone control, the mute works but the volume =

slider not(not present in alsamixer).
A great thing to have would be a master volume control.

but again thank you!
