From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.6.4
Date: Wed, 23 Jun 2004 14:49:26 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406231442240.4564-100000@studcom.urz.uni-halle.de>
References: <200406212257.48375.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200406212257.48375.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> Am Montag 21 Juni 2004 13:21 schrieb Clemens Ladisch:
> > Logically, these functions operate on a usb_midi structure/object, not
> > on a list entry.  AFAICS current pratice would put the list_entry()
> > call int the list iteration loop (in the caller of these functions).
>
> I followed the model given by
> 	snd_usb_audio_disconnect():
> and
> 	snd_usbmidi_disconnect()
> If you change that, I'll change my patch ;-)

Well, the USB driver as a whole isn't as modular as I'd like it to be,
but just now I'm too lazy to rewrite the entire thing.  :-)

Applied, with some minor changes.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
