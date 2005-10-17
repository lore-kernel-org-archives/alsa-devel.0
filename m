From: Eric Shattow <lucent@gmail.com>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Mon, 17 Oct 2005 08:03:11 -0500
Message-ID: <2c746f620510170603r306a8235r64b5a314aeab3cbe@mail.gmail.com>
References: <2c746f620510040247h45af8fbaoa17c5276c97b8efc@mail.gmail.com>
	 <Pine.HPX.4.33n.0510041451160.10984-100000@studcom.urz.uni-halle.de>
	 <2c746f620510041522g6e5e1779vd8a143e161e402d9@mail.gmail.com>
	 <2c746f620510111424y6436dbf2of9fdb723c5772c4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f620510111424y6436dbf2of9fdb723c5772c4a@mail.gmail.com>
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

On 10/11/05, Eric Shattow <lucent@gmail.com> wrote:
> On 10/4/05, Eric Shattow <lucent@gmail.com> wrote:
> > On 10/4/05, Clemens Ladisch <clemens@ladisch.de> wrote:
> > > Eric Shattow wrote:
> > > > On 10/4/05, Clemens Ladisch <clemens@ladisch.de> wrote:
> > > > > Eric Shattow wrote:
> > > > > > It's not getting far enough to dump any packets.
> > > > >
> > > > > This means that no packets are sent by the device.
> > > > >
> > > > > It's possible that the controller data is reported by the HID
> > > > > interfaces.  Did you test those?
> > > >
> > > > How would I make it so that usbhid module does not interfere?
> > >
> > > You wouldn't.  The 'proper' way would be to write a utility that read=
s
> > > input events from the three HID interfaces and converts them to MIDI.
> > > Otherwise, somebody would have to write a new driver for this device,
> > > and change the usbhid driver accordingly.
> > >
> > >
> > > Regards,
> > > Clemens
> > >
> > >
> >
> > This HPCDJ Console is a USB MIDI device and from all indications I can
> > see, should be made to function as such. The device has an MIDI IN
> > port and an MIDI OUT port, as many USB-MIDI interfaces do. Event
> > device (evdev) support is irrelevent to function in ALSA, no? If
> > output from /dev/eventX for the HPCDJ would be helpful please let me
> > know and I can make some captures.
> >
> > The Macintosh edition of HPCDJ Console works as an ALSA sound and midi
> > device, and so I must question where you and fellow ALSA developers
> > feel support for these DJ Console devices is most appropriate.
> >
> > Should the HPCDJ Console (Mac, and Windows editions) be supported in
> > ALSA as sound devices only, ignoring the midi portion, or be supported
> > in ALSA as sound and MIDI devices?
> >
> > Is it appropriate to continue supporting all midi and sound usb
> > devices with a single kernel module?
> >
> > My target application is to use the HPCDJ Console with Mixxx software,
> > and Mixxx is requiring an OSS-style /dev/midi device to read data
> > from. Ideally I expect to debug and see function of the HPCDJ Console
> > Windows Edition approach that of the Mac edition, same device. It is
> > then a simple matter to have ALSA OSS provide the needed /dev/midiX
> > device.
> >
> > Besides the USB ID, are the Mac and Windows editions of HPCDJ Console d=
iffering?
> >
> > I'm eager to see this hardware work and have some fun. I'm not very
> > good at writing code. Help in answering my questions and offering
> > suggestions is most appreciated :)
> >
>
> I have hacked up some Ruby code that reports most of the HPCDJ Console
> control surfaces. No midi function yet, though. See attached files for
> the curious.
>
>  Eric
>
>
>

More news, I have cracked open the PC DJ Console (Windows edition) and
am looking at the ICs on the board...

DJ-CONSOLE REAR
020110-92
(c)2003

* Texas Instruments TUSB3200AC chip, with info from vendor site:
http://focus.ti.com/docs/prod/folders/print/tusb3200a.html
* AKM AK4529VQ, with data sheet from vendor site:
http://www.akm.com/datasheets/ek4529.pdf
* Fairchild Semiconductor 6N136 optocoupler, with data sheet from
vendor site: http://www.fairchildsemi.com/ds/6N/6N136.pdf
* Texas Instruments SN75179B, vendor datasheet:
http://www-s.ti.com/sc/ds/sn75179b.pdf
* Texas Instruments "SNxxF00" Quad 2-input positive-NAND gate
* Texas Instruments "SNxxHC04" Hex Inverter
* Texas Instruments "74HC/HCT14" Hex inverting Schmitt trigger
* Microchip 24LC64 (cmos serial EEPROM), datasheet:
http://www.kollar.com/observatory/dome/parts/24lc64.pdf
* Texas Instruments SN74ALVC126, vendor site info:
http://focus.ti.com/docs/prod/folders/print/sn74alvc126.html
* Cirrus Logic CS8427-CZ (96kHz Digital Audio Interface Transceiver),
vendor datasheet:
http://www.cirrus.com/en/pubs/proDatasheet/CS8427_F3.pdf

There's also three unknown chips labelled "33078 / 2203", physically
near the 6 output connectors.

I'll omit the other two boards, there's nothing too interesting on
them. Also I'd like to note that many screws were not securely
fastened, and some were in at an angle. Unksilled labor at time of
manufacture, perhaps?

 Eric


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
