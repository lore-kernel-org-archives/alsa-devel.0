From: Steffen Sauder <steffensauder@gmx.de>
Subject: Re: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Wed, 21 Jan 2004 16:08:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400E9603.8010103@gmx.de>
References: <1074633766.6579.2.camel@moria.arnor.net>  <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz> <1074637277.6579.16.camel@moria.arnor.net> <Pine.LNX.4.58.0401210908220.2010@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id QAA15386
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2004 16:08:11 +0100
In-Reply-To: <Pine.LNX.4.58.0401210908220.2010@pnote.perex-int.cz>
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

Jaroslav Kysela wrote:

>
>Can you try 2.6.1-rc1 with alsa-bk-2004-01-20.patch.gz available at our 
>ftp site (/pub/kernel-patches)? It should fix your problem.
>  
>
Thanks a lot Jaroslav! That fixed the problem for me. One small hint for 
everyone else trying this: Don't forget to readjust your mixer settings, 
the previously saved settings seem to get lost with the new driver!

Is there any reason why the patch is against 2.6.1-rc1? I was quite 
satisfied with 2.6.1 and don't really want to go back to its first rc. 
Should I just try to apply the patch to 2.6.1 or 2.6.1-mmX? Will it work 
for sure, probably or definetly not?

Or could you perhaps post your changes as a patch against alsa-driver 
1.0.1, so that I can merge alsa into the kernel-sources by myself?

gruss,
Steffen



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
