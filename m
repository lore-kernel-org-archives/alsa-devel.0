From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Re: User-space ALSA driver?
Date: Mon, 14 Mar 2005 16:30:37 +0100
Message-ID: <1110814237.5056.113.camel@pc7.dolda2000.com>
References: <1110765624.5056.77.camel@pc7.dolda2000.com>
	 <s5hzmx6s167.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hzmx6s167.wl@alsa2.suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-03-14 at 16:21 +0100, Takashi Iwai wrote:
> At Mon, 14 Mar 2005 03:00:24 +0100,
> Fredrik Tolf wrote:
> > (Please CC me, I'm not on the list)
Again, please.
> > 
> > I've been googling around a bit for a user-space ALSA driver (meaning an
> > ALSA driver that allows a user-space program to act as the "hardware"),
> > but I've been unable to find one.
> > 
> > It seems strange to me that no such driver would exist. Does anyone on
> > the list know of any such driver? I was just about to start writing one
> > myself, but I thought I'd better check with the list first, just in case
> > I missed it.
> 
> Check alsa-plugins CVS repository.  It includes JACK and OSS
> "user-space" drivers.  Also, the bluez CVS includes the ALSA plugin,
> too.

Thanks, but that wasn't really what I wanted. I really do want a kernel
driver that plugs back to user-space. I realize that the preferred way
to do ALSA userspace drivers is to make a libasound plugin, but without
a kernel driver, I can't get OSS emulation (right?).

Should I take your reply as an indication that I'll have to write that
driver myself?

Thanks for your reply!
Fredrik Tolf




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
