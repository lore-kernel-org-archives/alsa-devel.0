From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Static build of alsa-lib?
Date: Sat, 30 Aug 2003 22:08:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F51125D.5050001@superbug.demon.co.uk>
References: <200308302141.16626.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA24701
	for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2003 23:08:46 +0200
In-Reply-To: <200308302141.16626.adrian@mcmen.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> Thanks to James I now know a few more of things I need to do to build and test 
> my sound driver on the Dreamcast.
> 
> But the system I am installing to is based on a static version of Busybox - 
> there is no glibc (or indeed any other C RTL) available on it. Thus I need to 
> build anything I install as static.
> 
> I can successfully build the alsa-lib with the cross compiling tools I have, 
> but can see no easy way to get it to build static - can anybody tell me how?
> 
> Adrian
> 
> 
You could use the oss emulation instead. You won't need alsa-lib etc then.
just "modprobe snd-pcm-oss" and then depending on whether you run devfs 
or not, create /dev/dsp

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
