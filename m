From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.6.4
Date: Mon, 21 Jun 2004 22:57:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406212257.48375.annabellesgarden@yahoo.de>
References: <Pine.HPX.4.33n.0406211245160.7655-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0406211245160.7655-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Montag 21 Juni 2004 13:21 schrieb Clemens Ladisch:
<snip>
> Logically, these functions operate on a usb_midi structure/object, not
> on a list entry.  AFAICS current pratice would put the list_entry()
> call int the list iteration loop (in the caller of these functions).
>
> >         for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
> > -               if (umidi->endpoints[i].in)
> > -                      
> > snd_usbmidi_submit_urb(umidi->endpoints[i].in->urb, -                    
> >                          GFP_KERNEL);
> > +               snd_usbmidi_in_start_do(umidi->endpoints[i].in);
>
> .... and then the entire loop could be replaced by a call to
> snd_usbmidi_in_start().

I followed the model given by 
	snd_usb_audio_disconnect():
and
	snd_usbmidi_disconnect()
If you change that, I'll change my patch ;-)
Though I'd vote against doing so, 'cause as things are,
struct snd_usb_midi and the corresponding typedef may stay hidden in 
usbmidi.c.

Regards,
Karsten


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
