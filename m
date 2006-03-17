From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Couple of questions
Date: Fri, 17 Mar 2006 20:27:32 +0000
Message-ID: <1142627252.9449.9.camel@localhost.localdomain>
References: <1142467271.9298.7.camel@localhost.localdomain>
	 <s5hirqer7r5.wl%tiwai@suse.de>
	 <1142552045.9236.9.camel@localhost.localdomain>
	 <1142554597.9395.25.camel@mindpipe>  <s5hirqdv0oj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 1BCCD18F
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 21:27:36 +0100 (MET)
In-Reply-To: <s5hirqdv0oj.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-03-17 at 11:13 +0100, Takashi Iwai wrote:

> 
> The period size is same, but the copy is not done like LLLLRRRR.
> 
> As default, the whole buffer is divided to number of channels.  For
> example, using two channels,
> 
> 	|LLLLLLL..|RRRRRRR....|
> 	|<--- buffer_size --->|
> 
> and using six channels,
> 
> 	|1111....|2222....|.....|6666....|
> 	|<-------- buffer_size --------->|
> 
> where each channel has a length of (period_size * periods) samples.
> Unless the buffer size is changed, this assignment of each channel
> also isn't changed.
> 
> The above is the default behavior.  You can change the assignment as
> you like by defining proper copy and silence callback, too.  For
> mmap, you need to define CHANNEL_INFO ioctl, too.
> 

Presumably this is what happens at the start, but when doing a single
period update presumably it is split LLLLRRRR on non interleaved



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
