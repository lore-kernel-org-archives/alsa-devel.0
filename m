From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: why do elements disappear?
Date: Wed, 16 Feb 2005 13:14:04 +0100
Message-ID: <m2ekfgpur7.fsf@vador.mandrakesoft.com>
References: <1108501973.2845.87.camel@tux.lan> <s5hll9obxar.wl@alsa2.suse.de>
	<m2r7jgpvw9.fsf@vador.mandrakesoft.com> <s5hd5v0bu2d.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5hd5v0bu2d.wl@alsa2.suse.de> (Takashi Iwai's message of "Wed,
 16 Feb 2005 12:52:42 +0100")
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

Takashi Iwai <tiwai@suse.de> writes:

> > > > a mixer app of mine (you know, one of those controlling
> > > > volumes) is updating itself (if other apps change settings) by
> > > > continuously running get-volume (et al) on all mixer elements
> > > > every once in a while (10Hz).
> > > 
> > > Well, this isn't a good idea.  You should do update passively via
> > > poll().  The exception is a control with VOLATILE flag like VU
> > > meter, which won't send change notification.  But normal controls
> > > send notification if the value is changed, or the control is
> > > created/deleted, so that the app can react.
> > 
> > is this the same bug that affects totem?
> > 
> > see totem's gdb trace at
> > http://qa.mandrakesoft.com/show_bug.cgi?id=13045 and xine strace at
> > http://qa.mandrakesoft.com/show_bug.cgi?id=13449
> > (http://qa.mandrakesoft.com/attachment.cgi?id=2444)
> 
> They are slightly different problems.  I guess it's indeed a bug of
> alsa-lib, which was fixed recently on CVS.

could you point to the relevant fix?



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
