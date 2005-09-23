From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [BUG] snd_intel8x0 parameter error (2.6.14-rc2)
Date: Fri, 23 Sep 2005 16:49:07 -0400
Message-ID: <1127508548.9921.18.camel@mindpipe>
References: <20050923125244.6ed69083@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id CD1F1132
	for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2005 22:49:35 +0200 (MEST)
In-Reply-To: <20050923125244.6ed69083@dxpl.pdx.osdl.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-09-23 at 12:52 -0700, Stephen Hemminger wrote:
> Can't load sound with current kernel. I am running FC4 and
> it put the following in /etc/modprobe.conf
> 
> alias snd-card-0 snd-intel8x0
> options snd-card-0 index=0  
> options snd-intel8x0 index=0  
> remove snd-intel8x0 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; }; /sbin/modprobe -r --ignore-remove snd-intel8x0
> 
> When snd-intel8x0 is loaded it gives:
>  snd_intel8x0: Unknown parameter `'
> 
> 
> It looks like the index parameter was changed to an array.
> But in the process you broke compatibility.

Make sure there's no trailing whitespace in your modprobe.conf.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
