From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ALSA - driver 0000502]: Mp3+ crackles when on
	alsa, not when on oss emulation
Date: Tue, 14 Sep 2004 20:00:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1095206427.2406.22.camel@krustophenia.net>
References: <20040914224423.247494904E@server.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 104862D8
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2004 02:00:24 +0200 (MEST)
In-Reply-To: <20040914224423.247494904E@server.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bugtrack@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-09-14 at 18:44, bugtrack@alsa-project.org wrote:
> this shell-cut-and-paste wil ilustrate my problem:
> 
> At first when I plug my mp3+ in, it crackles. It is not scraping or
> static, it is a distinct pop in the sound about 2-3 times/sec not
> rythmical. The card shows up in alsamixer -c1, and everything about
> controling it works. Then, without plugging my card in or out, I do this:
> 
> [root@localhost hhg]# rmmod snd_usb_audio
> [root@localhost hhg]# modprobe audio
> [root@localhost hhg]# alsamixer -c1
>  
> alsamixer: function snd_ctl_open failed for hw:1: No such file or
> directory
> 
> I also have a boult-in intel-8x0-card working fine with alsa. But now the
> mp3+card works great. Using oss-emulated mixer the card can also be
> controled. I have to use oss-output, though, as the card no longer is
> registrered by alsa.

Sounds like you are missing the ALSA device nodes in /dev.  Did you run
the snddevices script?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
