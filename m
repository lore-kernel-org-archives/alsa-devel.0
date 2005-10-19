From: Eric Shattow <lucent@gmail.com>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Wed, 19 Oct 2005 01:03:15 -0500
Message-ID: <2c746f620510182303k782e04f2xa18b60cea49030a@mail.gmail.com>
References: <2c746f620510180211hf803801mdda93f93aeae84c2@mail.gmail.com>
	 <Pine.HPX.4.33n.0510181124030.2094-100000@studcom.urz.uni-halle.de>
	 <2c746f620510182301j3419d000o857c2c72ef29880a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f620510182301j3419d000o857c2c72ef29880a@mail.gmail.com>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/18/05, Clemens Ladisch <clemens@ladisch.de> wrote:
> Eric Shattow wrote:
> > I have been able to make capture logs of the USB transactions as the
> > device is plugged in and initialized by the Hercules Windows (tm)
> > driver.  Would anyone be interested?
>
> Yes.  Are there any vendor-specific commands, i.e., is there anything
> that snd-usb-audio wouldn't be able to do?
>
>
> Regards,
> Clemens
>
>

I believe there are vendor specific commands, to handle the "push to
talk" potentiometer with built in momentary push switch. My basis for
this is I enabled the feature using Hercules software mixer control
program, and there is output in the capture program log. Then I push
the aforementioned button on the HPCDJ Console hardware, and there is
(what must be) a vendor specific command in the event viewer.

Some functions which I think may apply:  selecting which output the
headphone preamp is routed from, 44.1k / 48k function, MIDI button or
MIDI port (pick one), LED lamps and lights (not currently working for
me)

There may be other functions.  I have capture logs which are formatted
in HTML/Unicode/ASCII and quite large (about 30mb uncompressed). I
tried to keep the logs small, however they invariably contained data
of that annoyingly zen-like calming sound which Windows XP plays when
you plug in a new USB device. I activated and de-activated Hercules
software mixer features on the device. Omitted from the capture logs
are the device being used with user deejay software, as this resulted
in the device outputting many megabytes of ISO asynchronous data.

For a short while I will make these "giveitago.*" captures available,
at the following directory URL:

http://www.cuodan.net/~jnc/djconsolehacker/

I would like to note that the Macintosh edition of the DJ Console is
"hardwired" to be in MIDI button mode. The Windows edition (producing
"giveitago.*" output) is runtime selectable between a DirectInput+MIDI
USB device and a MIDI Button+Disabled MIDI USB i/o device. There are
reported hardware improvements in the sound chips of the Macintosh
edition versus the Windows edition.

Also of note is that upon using my DJ Console (windows edition)
hardware on a Windows XP system and Hercules drivers, the Hercules
software prompted a firmware upgrade. I allowed it, and the device
does not seem to behave any differently when used with ALSA sound
drivers. I am unsure which firmware was previously on the device. Also
unfortunate is I did not chance a capture of the firmware upgrade
process. Oh, well. The list of parts I gave should be enough to write
a firmware flasher, right?

Some of this may not apply to the scope of ALSA. Sorry about the
overlap, I know we have access to the DirectSound / DirectInput
specifications but it is covered by an NDA. I suck at coding. Anyone
else feel lucky?

 E

P.S. Apologies to Clemens for the duplicate mail. Gmail interface is
kind of clumsy for me.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
