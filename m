From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [BUG] snd-usb-audio still crashes when unplugging
Date: Wed, 12 Mar 2003 13:55:50 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303121355300.1328-100000@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0303121039460.11828-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0303121039460.11828-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Mar 2003, Clemens Ladisch wrote:

> 
> Unplugging a currently playing USB audio (not MIDI) device results in a
> big kernel oops.
> 
> When chip->shutdown is set, deactivate_urbs() doesn't do anything, but
> that's the case where the URB unlinking is really needed.
> 
> And, in the shutdown case, the URBs must not be resubmitted. I'm not
> really sure if reporting an xrun (like below) is a good idea; with the
> changes below, aplay hangs (when draining?) after the device is unplugged.

Thanks for report. I've tried to fix this problem in another way. Could 
you try the current CVS code?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
