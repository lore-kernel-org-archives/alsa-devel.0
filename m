From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb-midi rc3 patch request
Date: Tue, 20 Aug 2002 10:41:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D6200D0.6D789CA3@ladisch.de>
References: <20020819181700.67854.qmail@web12206.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: karsten wiese <annabellesgarden@yahoo.de>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

karsten wiese wrote:
> Takashi Iwai <tiwai@suse.de> wrote:
> > i think we need rather rewrite the top of usb device
> > management (on
> > alsa).  there is also another problem in this
> > regard, for example,
> > a device with both midi and audio is assigned to two
> > different cards,
> > since midi and audio handles it individually.
> 
> the patch adresses just that.
> ...
> Would it be sufficient to add an extra function like
> snd_usbmidi_card_attach() instead of overloading
> snd_usbmidi_card_create()?

This two-cards problem should be fixed for all USB devices,
not only for the Tascam. Then it wouldn't be necessary
to have special code for the MIDI part of the US428 at all.

I'm looking into this. usbaudio.c needs a function similar to
snd_usb_create_pcm(), but creating a sequencer device for
MIDI streaming interfaces. The sequencer device driver would
still be a separate module, but doesn't need to create
another card anymore.

> > (BTW, could you check the legal condition of
> > firmware on tascam
> >  device?  i'd like to put the stuffs but without
> > this permission it's
> >  of course unacceptable...)
> 
> what exactly do you need? I once tried to get an
> answer from turtle beach,
> which did not happen...
> tascam will most likely not agree to release the
> firmware under GPL in any form nor object- nor
> source-code.
> is it sufficient, if tascam just allows ALSA to use &
> publish their firmware as it is now?

I don't think they will allow their firmware to be
distributed with ALSA. (GPL requires to publish the
source.)

The Turtle Beach MultiSound driver uploads DSP code
from files installed with the Windows driver.
It may be possible to do the same for the US428.


Clemens


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
