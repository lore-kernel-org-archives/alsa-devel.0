From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Help! HDSP firmware suddenly fails to load...
Date: 25 Jan 2005 17:31:30 -0800
Message-ID: <1106703090.15847.1384.camel@cmn37.stanford.edu>
References: <1106621237.3554.27.camel@localhost.localdomain>
	 <1106634961.14021.28.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <planetccrma-admin@ccrma.stanford.edu>
In-Reply-To: <1106634961.14021.28.camel@cmn37.stanford.edu>
Sender: planetccrma-admin@ccrma.Stanford.EDU
Errors-To: planetccrma-admin@ccrma.Stanford.EDU
List-Help: <mailto:planetccrma-request@ccrma.stanford.edu?subject=help>
List-Post: <mailto:planetccrma@ccrma.stanford.edu>
List-Subscribe: <http://ccrma-mail.stanford.edu/mailman/listinfo/planetccrma>,
	<mailto:planetccrma-request@ccrma.stanford.edu?subject=subscribe>
List-Unsubscribe: <http://ccrma-mail.stanford.edu/mailman/listinfo/planetccrma>,
	<mailto:planetccrma-request@ccrma.stanford.edu?subject=unsubscribe>
List-Archive: <http://ccrma-mail.stanford.edu/pipermail/planetccrma/>
To: "Michael E. Smith" <melkhorn@gmx.de>
Cc: planetccrma@ccrma.Stanford.EDU, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-01-24 at 22:36, Fernando Lopez-Lezcano wrote:
> On Mon, 2005-01-24 at 18:47, Michael E. Smith wrote:
> > [MUNCH]
> > Both machines refuse to load the firmware similarly, but not quite the
> > same. To wit, the laptop (cardbus/digiface) consistantly produces the
> > above error, while the desktop (pci/digiface) does it once and then
> > doesn't see a card at all.
> > 
> > It does, however, show up (on both machines) on an lspci listing. Also,
> > snd-hdsp shows up in lsmod.
> > 
> > dmesg snippet:
> > 
> >         ALSA /usr/src/rpm/BUILD/alsa-driver-1.0.8/alsa-kernel/pci/rme9652/hdsp.c:647: 
> >         	Hammerfall-DSP: no Digiface or Multiface connected!
> >         ALSA /usr/src/rpm/BUILD/alsa-driver-1.0.8/alsa-kernel/pci/rme9652/hdsp.c:5086:
> >         	 card initialization pending : waiting for firmware
> >         
> > It would appear as though the firmware is attempting to be loaded
> > automatically at some point during user login (I can see from the lights
> > on the digiface), resulting in the error even before I attempt to load
> > it using hdsploader. 
[MUNCH]
> I think it is alsa 1.0.8. From what I've read it has changed the way in
> which it loads (surprise!) firmware. It now uses the hotplug subsystem.
> Darn!. I thought it was working fine as some people have reported
> success with echoaudio cards (which now have a driver included in 1.0.8
> and also require firmware downloads). Apparently not. 

Did you manage to do more tests? And/or get more information from dmesg
or /var/log/messages regarding the firmware load?

I just installed a 9652 + DigiFace on a test machine and while I had
some problems the firmware was loaded and eventually the card worked
fine. This is, regretfully, on fc3 so there may be problems that are
specific to fc2 then. 

On the first try after a reboot the card, for some reason, does not come
up. I suspect a problem with udev... this is what I find in
/var/log/messages on that first try:

=====
eth0: VIA Networking Velocity Family Gigabit Ethernet Adapter
eth0: Ethernet Address: 00:50:8D:E9:46:F5
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
hm: ioapic cache empty for irq 17 (e:00000000/d:00010000) 0001a9b1
ALSA
/usr/src/rpm/BUILD/alsa-driver-1.0.8/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:662: loading firmware
ALSA
/usr/src/rpm/BUILD/alsa-driver-1.0.8/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:700: finished firmware loading
ALSA
/usr/src/rpm/BUILD/alsa-driver-1.0.8/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:5110: Firmware already loaded, initializing card.
ALSA /usr/src/rpm/BUILD/alsa-driver-1.0.8/acore/control.c:322: control
3:0:0:IEC958 Playback Default:0 is already present
ALSA
/usr/src/rpm/BUILD/alsa-driver-1.0.8/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:4879: Error creating ctl interface
RME Hammerfall DSP: probe of 0000:00:09.0 failed with error -16
=====

And then if I restart the alsa subsystem through the alsasound scripts I
get this:

=====
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
ALSA
/usr/src/rpm/BUILD/alsa-driver-1.0.8/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:5110: Firmware already loaded, initializing card.
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.5 to 64
=====

And after that the card works fine. 
I only tried twice. 
I'll see if I can test on fc2...

-- Fernando
