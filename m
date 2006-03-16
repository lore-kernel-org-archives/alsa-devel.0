From: nagual.hsu <nagual.hsu@gmail.com>
Subject: Re: =?utf-8?b?c25kX3BjbV9od3N5bmM=?=
Date: Thu, 16 Mar 2006 15:26:46 +0000 (UTC)
Message-ID: <loom.20060316T162209-805@post.gmane.org>
References: <7fe205990603150406i5e61842fh@mail.gmail.com> <Pine.LNX.4.61.0603151309030.20193@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> 
> yOn Wed, 15 Mar 2006, Joe Hsu wrote:
> 
> > Hi all:
> >     Sometimes, snd_pcm_hwsync would return -32 (-EPIPE).
> > I can't see why. After snd_pcm_hwsync failed, snd_pcm_avail_update
> > would return a much bigger positive value than pcm_hw_bufsize.

> -EPIPE means xrun (over or underrun - new data exceed the ring buffer 
> or an application does not put new data in time)
> 
> 						Jaroslav
> 
> -----


    I will check out. I used real time scheduling already. Maybe I should 
enlarge snd_pcm_hwbufsize. Thanks. :)




----
The sun is shinny but the ice is slippery.







-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
