From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Re: [usb-midi-fw-devel] proposal concerning cooperation of snd-usb-usx2x.o and rbtload
Date: Sat, 30 Aug 2003 01:55:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030829235510.GA897@tuba.home>
References: <200308282352.54486.annabellesgarden@yahoo.de> <200308291734.20533.plcl@telefonica.net> <200308292012.06078.annabellesgarden@yahoo.de> <200308292159.13652.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200308292159.13652.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, usb-midi-fw-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, "'us428@drehmoment.org'" <us428@drehmoment.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 29, 2003 at 09:59:13PM +0200, Pedro Lopez-Cabanillas wrote:
> 
> We can use something like this for Tascam USB devices:
> 	pre-install snd-usb-us428 /usr/sbin/rbtload [...]
> 
> In this way we can be sure that rbtload is executed *before* the module is 
> installed. Of course, we still need to modify rbtload a bit, but it's not a 
> big change. It is not necessary to use the hwdep infrastructure at all.

I would prefer this "pre-install" way. Because we could use rbtload for
further FPGA, but non-Tascam devices in an easy way in the future.

I've just tried it out on us122 and it's working in my environment.
If you know your rbtload parameters it's even possible with an unchanged 
rbtload 0.1! But I believe in case of two tascam devices the device number
two won't get an fw download because the module is already loaded and
the "pre-install" option can't make the download for device number two.

But Karsten's proposal could handle more devices without such a restriction
and that's a good argument IMO.


martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
