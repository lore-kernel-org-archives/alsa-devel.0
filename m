From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [BUG] snd-usb-audio still crashes when unplugging
Date: Thu, 13 Mar 2003 10:03:25 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303131000570.7535-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0303121355300.1328-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.44.0303121355300.1328-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 12 Mar 2003, Clemens Ladisch wrote:
> > Unplugging a currently playing USB audio (not MIDI) device results in a
> > big kernel oops.
> > ...
> > with the changes below, aplay hangs (when draining?) after the device
> > is unplugged.
>
> Thanks for report. I've tried to fix this problem in another way. Could
> you try the current CVS code?

Works better: no crash, and aplay gives an error without hanging.


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
