From: "Michael E. Smith" <melkhorn@gmx.de>
Subject: Re: [PlanetCCRMA] Help! HDSP firmware suddenly fails to load...
Date: Wed, 26 Jan 2005 07:27:51 +0100
Message-ID: <1106720871.3844.23.camel@localhost.localdomain>
References: <1106621237.3554.27.camel@localhost.localdomain>
	 <1106634961.14021.28.camel@cmn37.stanford.edu>
	 <1106703090.15847.1384.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106703090.15847.1384.camel@cmn37.stanford.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: planetccrma@ccrma.Stanford.EDU, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi, Fernando,

Holy cow you're on top of things. Do you ever sleep?

In any case, I've rebooting into 2.6.10-2.1.ll.rhfc2.ccrma on the laptop
(cardbus/digiface) and the /var/log/messages showed the same as my
previous dmesg snippet.

FWIW, the error light on the digiface went out by the time the login
screen popped up, when before (the first time with 1.0.8) it went out
after logging in, presumably as part of the login.

On your cue, I restarted alsa (service alsasound restart ???) and got
the following in /var/log/messages:

====
Jan 26 06:46:07 localhost alsasound: sound driver stop succeeded
Jan 26 06:46:08 localhost alsasound: Starting sound driver snd-hdsp
succeeded
Jan 26 06:46:08 localhost alsasound: Starting sound driver snd-via82xx
succeeded
Jan 26 06:46:08 localhost alsasound: Starting sequencer succeeded
Jan 26 06:46:08 localhost alsactl: /usr/sbin/alsactl: set_control:909:
failed to obtain info for control #1 (No such file or directory)
Jan 26 06:46:08 localhost alsasound: Restoring sound driver settings
failed
====

Hmmm. So, like all good little boys, I did it again, just for good
measure and:

====
Jan 26 06:49:37 localhost alsasound: sound driver stop succeeded
Jan 26 06:49:44 localhost kernel: ACPI: PCI interrupt 0000:00:11.5[C] ->
GSI 5 (level, low) -> IRQ 5
Jan 26 06:49:46 localhost kernel: ACPI: PCI interrupt 0000:02:00.0[A] ->
GSI 11 (level, low) -> IRQ 11
Jan 26 06:49:46 localhost kernel: ALSA
/usr/src/rpm/BUILD/alsa-driver-1.0.8/alsa-kernel/pci/rme9652/hdsp.c:5110: Firmware already loaded, initializing card.
Jan 26 06:49:46 localhost alsasound: Starting sound driver snd-hdsp
succeeded
Jan 26 06:49:46 localhost alsasound: Starting sound driver snd-via82xx
succeeded
Jan 26 06:49:47 localhost alsasound: Starting sequencer succeeded
Jan 26 06:49:47 localhost alsasound: Starting sequencer driver
snd-seq-midi succeeded
Jan 26 06:49:47 localhost alsasound: Restoring sound driver settings
succeeded
====

Hey! Lookie here! 

If I'm to believe what I see, the firmware has perhaps been loaded all
along, just the card had not been initialized, whatever that means. 

Oh crap, I just realized that I never powered down the digiface between
reboots. I suppose I should try that, too.

Anyway, Jack seems to be running happily after the second alsasound
restart. Haven't checked hdspmixer, hdspconf, or tried sound through it
yet, however. That remains to be a pain with the laptop, largely due to
my crappy Ene cardbus controller's memory handling which I have to
manually manipulate (if you're reading this, Ico, I never did thank you
for the fix. Thanks!).

I will now (or at least later today) try all this again with 1) reycling
the digiface's power 2) fully testing with sound 3) with the desktop
(pci/digiface) and 4) with the other various kernels.

Whew.

Thanks again,

Michael

On Wed, 2005-01-26 at 02:31, Fernando Lopez-Lezcano wrote:
> On Mon, 2005-01-24 at 22:36, Fernando Lopez-Lezcano wrote:
> > On Mon, 2005-01-24 at 18:47, Michael E. Smith wrote:
> > > [MUNCH]
> > > Both machines refuse to load the firmware similarly, but not quite the
> > > same. To wit, the laptop (cardbus/digiface) consistantly produces the
> > > above error, while the desktop (pci/digiface) does it once and then
> > > doesn't see a card at all.
> > > 
> > > It does, however, show up (on both machines) on an lspci listing. Also,
> > > snd-hdsp shows up in lsmod.
> > > 
> > > dmesg snippet:
> > > 
> > >         ALSA /usr/src/rpm/BUILD/alsa-driver-1.0.8/alsa-kernel/pci/rme9652/hdsp.c:647: 
> > >         	Hammerfall-DSP: no Digiface or Multiface connected!
> > >         ALSA /usr/src/rpm/BUILD/alsa-driver-1.0.8/alsa-kernel/pci/rme9652/hdsp.c:5086:
> > >         	 card initialization pending : waiting for firmware
> > >         
> > > It would appear as though the firmware is attempting to be loaded
> > > automatically at some point during user login (I can see from the lights
> > > on the digiface), resulting in the error even before I attempt to load
> > > it using hdsploader. 
> [MUNCH]
> > I think it is alsa 1.0.8. From what I've read it has changed the way in
> > which it loads (surprise!) firmware. It now uses the hotplug subsystem.
> > Darn!. I thought it was working fine as some people have reported
> > success with echoaudio cards (which now have a driver included in 1.0.8
> > and also require firmware downloads). Apparently not. 
> 
> Did you manage to do more tests? And/or get more information from dmesg
> or /var/log/messages regarding the firmware load?
> 
> I just installed a 9652 + DigiFace on a test machine and while I had
> some problems the firmware was loaded and eventually the card worked
> fine. This is, regretfully, on fc3 so there may be problems that are
> specific to fc2 then. 
> 
> On the first try after a reboot the card, for some reason, does not come
> up. I suspect a problem with udev... this is what I find in
> /var/log/messages on that first try:
> 
> =====
> eth0: VIA Networking Velocity Family Gigabit Ethernet Adapter
> eth0: Ethernet Address: 00:50:8D:E9:46:F5
> ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
> hm: ioapic cache empty for irq 17 (e:00000000/d:00010000) 0001a9b1
> ALSA
> /usr/src/rpm/BUILD/alsa-driver-1.0.8/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:662: loading firmware
> ALSA
> /usr/src/rpm/BUILD/alsa-driver-1.0.8/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:700: finished firmware loading
> ALSA
> /usr/src/rpm/BUILD/alsa-driver-1.0.8/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:5110: Firmware already loaded, initializing card.
> ALSA /usr/src/rpm/BUILD/alsa-driver-1.0.8/acore/control.c:322: control
> 3:0:0:IEC958 Playback Default:0 is already present
> ALSA
> /usr/src/rpm/BUILD/alsa-driver-1.0.8/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:4879: Error creating ctl interface
> RME Hammerfall DSP: probe of 0000:00:09.0 failed with error -16
> =====
> 
> And then if I restart the alsa subsystem through the alsasound scripts I
> get this:
> 
> =====
> ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
> ALSA
> /usr/src/rpm/BUILD/alsa-driver-1.0.8/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:5110: Firmware already loaded, initializing card.
> ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
> PCI: Setting latency timer of device 0000:00:11.5 to 64
> =====
> 
> And after that the card works fine. 
> I only tried twice. 
> I'll see if I can test on fc2...
> 
> -- Fernando
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
