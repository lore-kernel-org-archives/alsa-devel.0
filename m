From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Rear right speaker silent on 2.6.11
Date: Mon, 14 Mar 2005 12:16:00 -0500
Message-ID: <1110820560.14723.0.camel@mindpipe>
References: <4233770C.10601@gentoo.org> <s5hy8cqs12i.wl@alsa2.suse.de>
	 <4235C33C.3080404@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4235C33C.3080404@gentoo.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Drake <dsd@gentoo.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-03-14 at 17:00 +0000, Daniel Drake wrote:
> Takashi Iwai wrote:
> > It must be the one for ac97_codec.c, stereo mute fixes.
> 
> Thanks a lot, that did it. I'm not sure it is critical enough for inclusion in 
> linux-stable but I've submitted it anyway.

This is absoultely 100% linux-stable material.  ANY regression
qualifies: performance (including scheduling latency), functionality,
etc.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
