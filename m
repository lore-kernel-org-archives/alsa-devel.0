From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: Midiman Quattro USB drivers
Date: Thu, 15 Aug 2002 18:27:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208151827.37301.plcl@telefonica.net>
References: <004d01c243f0$b9f8af50$a6ed3b42@eclipse> <3D5B689F.3060109@boosthardware.com> <s5h8z38mn60.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z38mn60.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Eric Griffis <egriffis@netconcentric.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

El Jue 15 Ago 2002 12:28, Takashi Iwai escribió:
> Patrick Shirkey wrote:
> > this card is working now. If you look in the docs via the sound card
> > matrix you can ifnd out how to install it. there is even a working
> > asoundrc so that you can use all four channels at one time.
> >
> > Midi is untested but should work because it is a midisport.
>
> then you need a corresponding firmware (1x1)?

I don't have the hardware, and cannot confirm that, and also I don't know if 
its an EZ-USB device. But if it is, and you load the midisport1x1 firmware on 
it is rather unlikely that worked as Audio+MIDI together. Perhaps MIDI only, 
or nothing at all.

The reason is that the EZ-USB devices have different descriptor sets before 
and after renumeration, that is the last step on firmware loading.  The 
ezusbmidi firmware program, when running, replaces the original descriptors 
with its own set, that has only AudioControl and MIDIStreaming interfaces, 
but not AudioStreaming ones. And without such interface and its corresponding 
endpoints, the driver will not work. A specific firmware driver should be 
written, but perhaps it is not needed at all, if a ROM one is supplied inside 
the Duo/Quattro devices, as I suspect from the fact that audio function works 
without that.

> also, please note that when you load both snd-usb-audio and
> snd-usb-midi, they are assigned as different cards (i.e. pcm hw:0 and
> midi hw:1) even if the device is identical.
> it would be of course better to have an integrated interface for
> them...

For some devices that have Audio and MIDI together (a few ones today, but more 
coming, surely) this will be a good thing. But IMHO, the two modules 
snd-usb-audio and snd-usb-midi should remain as is: two different modules 
that you can load separately, for those USB devices that only have an audio 
or MIDI function, but not both.

Regards,
Pedro





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
