From: Steffen Sauder <steffensauder@gmx.de>
Subject: Re: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Wed, 21 Jan 2004 00:18:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400DB759.2010807@gmx.de>
References: <1074633766.6579.2.camel@moria.arnor.net>	 <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz> <1074637277.6579.16.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id AAA32379
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2004 00:19:22 +0100
In-Reply-To: <1074637277.6579.16.camel@moria.arnor.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Torrey Hoffman wrote:

>In 2.6.1-mm5, which I'm running at the moment, I just get no sound
>output.  No error messages.  The envy24control level meters don't show
>any sound output.
>  
>
I have the same problem with my Terratec DMX6fire, running gentoo / 
2.6.1 with the alsa-kernel directory from alsa-driver-1.0.1 merged into 
the kernel sources as described in the wiki. Sometimes  I hear some kind 
of looped noise instead of silence which stays the same no matter what I 
try to play.

I found out that unloading all alsa modules, recompiling alsa-lib and 
restarting alsa seemes to make it work again until the next reboot.

>I'm very motivated to get this working, and am happy to apply patches,
>recompile my kernel, or do anything else that would help debug the
>problem.  
>
>  
>
Same here, I could try out some stuff or send you more information, but 
I don't know where to start.

gruss,
Steffen




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
