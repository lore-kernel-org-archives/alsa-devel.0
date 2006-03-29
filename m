From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ALSA sample rate conversion and
	general	performance improvements.
Date: Wed, 29 Mar 2006 16:12:31 -0500
Message-ID: <1143666752.13933.20.camel@mindpipe>
References: <4429C5A4.7@superbug.co.uk> <s5hirpx6256.wl%tiwai@suse.de>
	 <442A5B80.3010706@superbug.co.uk>
	 <1143643959.3402.47.camel@localhost.localdomain>
	 <20060329173129.GA27846@homer>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060329173129.GA27846@homer>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christian Henz <chrhenz@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-29 at 19:31 +0200, Christian Henz wrote:
> Hmm, I though that we DO have schedulable high res timers
> now with the recent hrtimers merge? At least thats what I 
> got from watching the video of the talk on RT patches at 
> FOSDEM (http://free-electrons.com/community/videos/conferences).
> I might have to watch it again to see if that only applied to
> the -rt patch... 

Only in the -rt patch for now.  The hrtimers infrastructure is in
mainline now, and actual hrtimers should be available soon.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
