From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: VIA 8237 with CMedia CMI9761 Report issues, problems and some
 sucess
Date: Sun, 13 Feb 2005 03:34:54 +0000
Message-ID: <1108265694.1791.30.camel@bastov>
References: <1108233173.874.3.camel@bastov>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1108233173.874.3.camel@bastov>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user <alsa-user@alsa-project.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

After search on https://bugtrack.alsa-project.org/ for CMI9761, I found
3 issues, all resolved !=20
The most similar is "ASRock k7vt4a+ with CMedia CMI9761 no mixer!", I
have one ASRock P4VT8+ with CMedia CMI9761.

Try boot with pci=3Dnoacpi (that put the interrupts on XT-PIC) but is not
one ACPI problem, because sound have same behavior with a normal boot.=20

After play around with alsamixer,=20
I got sound when unmute PCM and Off (mute) IEC958 Capture Monitor.

All others controls does change anything include mute or unmute the
Master.
Except VIA DXS (this one can do sound balance, left and right). =20
VIA DXS 1, VIA DXS 2 and VIA DXS 3 also doesn't do nothing.

Play around with=20
options snd-via82xx dxs_support
on file /etc/modprobe.conf
only with "options snd-via82xx dxs_support=3D2" I see any difference but
for worst, make disappear VIA DXS, VIA DXS 1, VIA DXS 2 and VIA DXS 3
controls.

Sorry for my weak English, if you don't understand something just ask
me, that I will try explain again.

lspci -nv
00:11.5 Class 0401: 1106:3059 (rev 60)
        Subsystem: 1849:9739
        Flags: medium devsel, IRQ 185
        I/O ports at c000 [size=3D256]
        Capabilities: [c0] Power Management version 2

lspci -vv
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235=
/8237 AC97 Audio Controller (rev 60)
        Subsystem: ASRock Incorporation: Unknown device 9739
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 185
        Region 0: I/O ports at c000 [size=3D256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,=
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-


Thanks,

On Sat, 2005-02-12 at 18:32 +0000, Sergio Monteiro Basto wrote:
> Hi=20
> Fwd to alsa-devel can be more appropriated !
> any information about this VIA 8237 ?
> google around have a very few information and on alsa site either.
>=20
> TIA,
>=20
> -------- Forwarded Message --------
> > From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
> > Reply-To: sergio@sergiomb.no-ip.org
> > To: alsa-user <alsa-user@alsa-project.org>
> > Subject: [Alsa-user] VIA 8237 issues and problems
> > Date: Sat, 12 Feb 2005 03:25:19 +0000
> > Hi,
> >=20
> > After trying everything , no sound still on my desktop
> > I with Fedora Core 3 , and even try install alsa-drive, lib, and util=
s
> > 1.0.8 from sources.=20
> >=20
> > about:=20
> > kernel: Please try dxs_support=3D1 or dxs_support=3D4 option
> > kernel:          and report if it works on your machine.
> >=20
> > adding options snd-via82xx dxs_support=3D1 or dxs_support=3D4 doesn't=
 help.
> >=20
> > system-config-soundcard give me this warning :=20
> > Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' :
> > Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> > Warning: rate is not accurate (requested =3D 44100Hz, got =3D 48000Hz=
)
> >          please, try the plug plugin (-Dplug:hw:0,0)
> >=20
> > alsamixer says:=20
> >=20
> > Card: VIA 8237
> > Chip: C-Media Electronics CMI9761
> >=20
> > lspci:
> > 00:00.0 Host bridge: VIA Technologies, Inc. VT8374 P4X400 Host Contro=
ller/AGP Bridge (rev 82)
> > 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
> > 00:0b.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01=
)
> > 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA R=
AID Controller (rev 80)
> > 00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/=
B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> > 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
 Controller (rev 81)
> > 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
 Controller (rev 81)
> > 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
 Controller (rev 81)
> > 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
 Controller (rev 81)
> > 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> > 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K=
8T800 South]
> > 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/=
8235/8237 AC97 Audio Controller (rev 60)
> > 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]=
 (rev 78)
> >=20
> >=20
> >=20
> > TIA,
--=20
S=E9rgio M.B.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
