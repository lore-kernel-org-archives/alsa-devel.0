From: Niek van der Maas <webmaster@refstart.nl>
Subject: Re: [Alsa-user] Alsa 0.9 / chipset 8233 : audio OK but not Midi
Date: Wed, 31 Jul 2002 16:59:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207311659.04032.webmaster@refstart.nl>
References: <200207301257.g6UCuvB07981@cnes.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200207301257.g6UCuvB07981@cnes.fr>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Vintenat Lionel <Lionel.Vintenat@cnes.fr>, "'alsa-user@lists.sourceforge.net'" <alsa-user@lists.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Lionel and others,

I've a KT333 motherboard with the VIA8233A chipset, and I've the same probl=
em=20
as you. "cat /proc/asound/oss/sndstat" gives me the following output:

=2D---------
Sound Driver:3.8.1a-980706 (ALSA v0.9.0rc2 emulation code)
Kernel: Linux tussen.huis 2.4.19-gentoo-r7 #2 SMP Fri Jun 14 18:48:35 WEST=
=20
2002 i686
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
VIA 8233 at 0xe000, irq 11

Audio devices:
0: VIA 8233 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: mixer00
=2D---------


If I try to load the snd-seq-oss module (I think that's the problem) I get=
=20
these errors:

=2D---------
tussen root # modprobe snd-seq-oss
/lib/modules/2.4.19-gentoo-r7/kernel/sound/acore/seq/oss/snd-seq-oss.o:=20
init_module: Device or resource busy
Hint: insmod errors can be caused by incorrect module parameters, including=
=20
invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.19-gentoo-r7/kernel/sound/acore/seq/oss/snd-seq-oss.o: ins=
mod=20
/lib/modules/2.4.19-gentoo-r7/kernel/sound/acore/seq/oss/snd-seq-oss.o fail=
ed
/lib/modules/2.4.19-gentoo-r7/kernel/sound/acore/seq/oss/snd-seq-oss.o: ins=
mod=20
snd-seq-oss failed
=2D---------

When I look at my dmesg, I see this:

=2D---------
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss.c:223: can't register device=
=20
seq
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss.c:223: can't register device=
=20
seq
=2D---------

Perhaps it's a problem with the driver or so? Sound is working very well,=20
except for midi. Anyone with a VIA8233A who got midi working?

Thanks,

Niek.

On Tuesday 30 July 2002 14:55, Vintenat Lionel wrote:
> Hi everybody,
>
> 	I've just bought a PC mainly in order to control a Midi synthesizer.
> This PC is based on a DFI motherboard (AD70-SC model) with KT266A/VT8233
> Via chipset. I've installed the RedHat 7.3 distribution of Linux which is
> based on 2.4.18 kernel. At the beginning, sound didn't work at all. So I
> searched through internet and found drivers for VT8233 chipset and 2.4.18
> kernel at the Via website (http://www.viaarena.com). Then sound started to
> work but not midi (still no device for /dev/sequencer).
>
> 	Then I've installed Alsa 0.9rc2 (drivers, libs and utils packages).
> Compilation (--with-debug=3Dfull --with-sequencer=3Dyes --with-oss=3Dyes
> --with-isapnp=3Dno) and installation ran without any problem, but the
> situation remains the same : sound works very well (I can play samples,
> movies, etc.) but midi seems to be completely "ignored", both by Alsa
> (jazz complains that it can't find any midi port) and OSS emulation
> (see below /proc/asound/oss/sndstat).
>
> 	Here is my /etc/modules.conf :
>
> alias parport_lowlevel parport_pc
> alias char-major-116 snd
> alias snd-card-0 snd-via8233
> alias char-major-14 soundcore
> alias sound-slot-0 snd-card-0
> alias sound-service-0-0 snd-mixer-oss
> alias sound-service-0-1 snd-seq-oss
> alias sound-service-0-3 snd-pcm-oss
> alias sound-service-0-8 snd-seq-oss
> alias sound-service-0-12 snd-pcm-oss
> alias usb-controller usb-uhci
>
> 	Here is what I get with lsmod command after login in KDE environment :
>
> Module                  Size  Used by    Not tainted
> nls_iso8859-1           3488   1  (autoclean)
> nls_cp437               5120   1  (autoclean)
> vfat                   12092   1  (autoclean)
> fat                    37432   0  (autoclean) [vfat]
> snd-pcm-oss            50596   1  (autoclean)
> snd-mixer-oss          12896   0  (autoclean) [snd-pcm-oss]
> snd-via8233             8100   1  (autoclean)
> snd-pcm                78688   0  (autoclean) [snd-pcm-oss snd-via8233]
> snd-timer              15840   0  (autoclean) [snd-pcm]
> snd-ac97-codec         30564   0  (autoclean) [snd-via8233]
> snd                    47080   0  (autoclean) [snd-pcm-oss snd-mixer-oss
> snd-via8233 snd-pcm snd-timer snd-ac97-codec] soundcore               669=
2=20
>  3  (autoclean) [snd]
> binfmt_misc             7556   1
> autofs                 12132   0  (autoclean) (unused)
> ipchains               43528   7
> ide-cd                 30272   0  (autoclean)
> cdrom                  32224   0  (autoclean) [ide-cd]
> usb-uhci               24452   0  (unused)
> usbcore                73216   1  [usb-uhci]
> ext3                   67136   5
> jbd                    49400   5  [ext3]
>
> 	As it can be seen : all sound modules are well loaded except sequencer
> and midi ones.
>
> 	Now here is the result of "cat /proc/asound/cards" :
>
> 0 [card0          ]: VIA8233 - VIA 8233
>                      VIA 8233 at 0xe000, irq 5
>
> 	And now the result of "cat /proc/asound/oss/sndstat" :
>
> Sound Driver:3.8.1a-980706 (ALSA v0.9.0rc2 emulation code)
> Kernel: Linux localhost.localdomain 2.4.18-3 #1 Thu Apr 18 07:32:41 EDT
> 2002 i686 Config options: 0
>
> Installed drivers:
> Type 10: ALSA emulation
>
> Card config:
> VIA 8233 at 0xe000, irq 5
>
> Audio devices:
> 0: VIA 8233 (DUPLEX)
>
> Synth devices: NOT ENABLED IN CONFIG
>
> Midi devices: NOT ENABLED IN CONFIG
>
> Timers:
> 7: system timer
>
> Mixers:
> 0: mixer00
>
> 	I'm worried by those "NOT ENABLED IN CONFIG" messages ! I'm
> sure that my motherboard has Midi support because it is written inside the
> provided manual and a Midi connector is present at the backside of the PC.
> Moreover I checked the jumpers of the motherboard : they are set to enable
> audio chipset and anyway sound works well.
> 	I also played with bios settings without more success :
> 	- The "Midi Port Address" parameter is by default set to 330. Other
> possible choices are 300, 290 and disable. None works.
> 	- The "Midi Port IRQ" is by default set to 10. Other possible choice is
> 5. But setting it to 5 makes the "Card config:" become "Via 8233 at 0xe00=
0,
> irq 10" in the /proc/asound/oss/sndstat, but midi remains "NOT ENABLED IN
> CONFIG".
>
> 	Finally I looked the logged events in /var/log/messages, but didn't see
> any alsa stuff despite the debug switch set to full during compilation.
> However, there are some "worrying" messages logged by the kernel during
> reboot. Here they are :
>
> Jul 29 23:51:28 localhost syslogd 1.4.1: restart.
> Jul 29 23:51:28 localhost kernel: klogd 1.4.1, log source =3D /proc/kmsg
> started. Jul 29 23:51:28 localhost kernel: Linux version 2.4.18-3
> (bhcompile@porky.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat
> Linux 7.3 2.96-110)) #1 Thu Apr 18 07:32:41 EDT 2002 [non significant stu=
ff
> cut]
> Jul 29 23:51:29 localhost kernel: PCI: PCI BIOS revision 2.10 entry at
> 0xfb400, last bus=3D1 Jul 29 23:51:29 localhost kernel: PCI: Using
> configuration type 1
> Jul 29 23:51:29 localhost kernel: PCI: Probing PCI hardware
> Jul 29 23:51:29 localhost kernel: Unknown bridge resource 0: assuming
> transparent Jul 29 23:51:29 localhost kernel: PCI: Using IRQ router defau=
lt
> [1106/3099] at 00:00.0 Jul 29 23:51:29 localhost kernel: isapnp: Scanning
> for PnP cards... Jul 29 23:51:29 localhost kernel: isapnp: No Plug & Play
> device found [non significant stuff cut]
> Jul 29 23:51:29 localhost kernel: VP_IDE: IDE controller on PCI bus 00 dev
> 89 Jul 29 23:51:29 localhost kernel: PCI: No IRQ known for interrupt pin A
> of device 00:11.1. Please try using pci=3Dbiosirq. Jul 29 23:51:29 localh=
ost
> kernel: VP_IDE: chipset revision 6
> Jul 29 23:51:29 localhost kernel: VP_IDE: not 100%% native mode: will pro=
be
> irqs later Jul 29 23:51:29 localhost kernel: ide: Assuming 33MHz system b=
us
> speed for PIO modes; override with idebus=3Dxx Jul 29 23:51:29 localhost
> kernel: VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
>
> 	At that point, I'm completely stuck and don't see what to do
> now to make my computer communicate with my synthesizer...
> So any help would be appreciated.
>
> 	Thanks, Lionel
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by: Dice - The leading online job board
> for high-tech professionals. Search and apply for tech jobs today!
> http://seeker.dice.com/seeker.epl?rel_code=3D31
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
