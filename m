From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] usbaudio fixes
Date: Mon, 24 Nov 2003 13:10:55 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0311241254590.20532-100000@studcom.urz.uni-halle.de>
References: <s5hwu9q2ehv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hwu9q2ehv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Clemens Ladisch wrote:
> >
> > - initialize active_mask and unlink_mask each time before URBs are
> >   started
>
> we still need to check here whether the urbs are really free, since
> a path like trigger stop -> prepare -> trigger_start is possible.
> in this case, the operation can be done quickly enough before urbs are
> really unlinked.
>
> the question is then where we can do a long wait.  perpare would be a
> better place than trigger, but unfortunately, prepare callback is also
> regarded as atomic because of linked streams.

If we cannot sleep until the URBs are completely unlinked, we have to
1) busy-wait until the URBs are inactive (*ouch!*), or
2) let trigger_start fail with "device not yet ready", or
3) allocate a new set of URBs, and put the old ones in some list to be
   freed later.

(1) would be really evil; (2) a quick hack; (3) would be most useful,
but it's anything but elegant.


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
