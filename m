From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Edirol UA-20 PCM support
Date: Tue, 25 Feb 2003 12:53:24 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302251242540.13260-100000@studcom.urz.uni-halle.de>
References: <s5hof50zmhx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hof50zmhx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Frank Barknecht <fbar@footils.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > That's a bug in my patch. I'll have to rewrite it.

The header descriptor in if #0 doesn't mention if#3, so we'd need a
composite quirk and a new quirk type to call snd_usb_create_streams.
That code would be cleaner if the descriptorss would be read from
host_if->extra instead of the seperately allocated buffer.

> could you resend the patch if finished?
> or, the previous patch is enough?

In the current CVS, we get MIDI but no PCM.
With my previous patch, we get PCM but not MIDI.

I don't have time today for this, but I think I'll have finished it
Thursday.


Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
