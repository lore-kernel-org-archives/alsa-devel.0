From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [BUG] snd_intel8x0 parameter error (2.6.14-rc2)
Date: Fri, 23 Sep 2005 14:39:36 -0700
Message-ID: <20050923143936.25cc2055@dxpl.pdx.osdl.net>
References: <20050923125244.6ed69083@dxpl.pdx.osdl.net>
	<1127508548.9921.18.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 735B414D
	for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2005 23:39:17 +0200 (MEST)
In-Reply-To: <1127508548.9921.18.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 23 Sep 2005 16:49:07 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Fri, 2005-09-23 at 12:52 -0700, Stephen Hemminger wrote:
> > Can't load sound with current kernel. I am running FC4 and
> > it put the following in /etc/modprobe.conf
> > 
> > alias snd-card-0 snd-intel8x0
> > options snd-card-0 index=0  
> > options snd-intel8x0 index=0  
> > remove snd-intel8x0 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; }; /sbin/modprobe -r --ignore-remove snd-intel8x0
> > 
> > When snd-intel8x0 is loaded it gives:
> >  snd_intel8x0: Unknown parameter `'
> > 
> > 
> > It looks like the index parameter was changed to an array.
> > But in the process you broke compatibility.
> 
> Make sure there's no trailing whitespace in your modprobe.conf.
> 
> Lee

There is trailing whitespace, but since it was auto generated
it's probably a install tool problem.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
