From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: Unexpected hw_pointer value
Date: Sat, 4 Oct 2003 16:58:12 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031004215812.GI2972@dbz.icequake.net>
References: <20031004211200.GA13137@zeus.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20031004211200.GA13137@zeus.homenet>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi,

On Sat, Oct 04, 2003 at 11:12:00PM +0200, Jon wrote:
> hello,
> 
> i have an ES1983S Maestro-3i on a c600 dell laptop
> i got this message in syslog :
> 
> ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0,
> delta: -944, max jitter = 1024): wrong interrupt acknowledge?

I get a lot of these as well with the in-development Aureal driver.  I'm
also curious as to what they mean.  (I seem to be the only person having
the problem).  They mostly occur while playing music in xmms with xmms
alsa plugin.  They fill up syslog with hundreds of megabytes. :)

Thanks,

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
