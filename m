From: "ben.blilweb" <ben.blilweb@laposte.net>
Subject: Re: no sound and low mic on ALC883
Date: Sat, 15 Jul 2006 22:00:48 +0200
Message-ID: <J2GNLC$A8F2CB3BF23224C8ADAC7D152518027E@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi, sorry for being so long and thx for the reply.
I've try to put the old version, but the mic won't work has
befor .. really don't understand why. So I've try lots of
possibility (when using old version, dmesg say that is an
unknown model for ALC882, with newest, it say s ALC883).

options used and result (all with position_fix=3D0):
   - for most dmesg:
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) ->
IRQ 16
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC883, trying auto-probe from
BIOS...
ALSA /root/alsa/alsa-driver-fixbug1/pci/hda/hda_codec.c:2170:
autoconfig: line_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa/alsa-driver-fixbug1/pci/hda/hda_codec.c:2174:
   speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa/alsa-driver-fixbug1/pci/hda/hda_codec.c:2176:
   hp=3D0x14, dig_out=3D0x1e, din_in=3D0x0
ALSA /root/alsa/alsa-driver-fixbug1/pci/hda/hda_codec.c:2184:
   inputs: mic=3D0x18, fmic=3D0x0, line=3D0x1a, fline=3D0x0, cd=3D0x0,
aux=3D0x0

   - for most mic result:
mic works on a low level, recorded track listening on a
working box revels that the sound is really broken (lots of
parasits but we can understand)

   - model for this result:
          3stack        3-jack in back and a headphone out
          5stack-digout 5-jack in back, 2-jack in front, a
SPDIF out
          6stack        6-jack in back, 2-jack in front
          6stack-digout 6-jack with a SPDIF out
          w810          3-jack =

          z71v          3-jack (HP shared SPDIF)
          asus          3-jack =

          uniwill       3-jack
          F1734         2-jack
          lg            LG laptop (m1 express dual)
          lg-lw         LG LW20 laptop
          test          for testing/debugging purpose, almost
all controls can be
          auto          auto-config reading BIOS (default)
          hp            HP machines
          fujitsu       Fujitsu S7020
          acer          Acer TravelMate
          basic         fixed pin assignment (old default model)


for model that I have troubles:
          - 3stack-digout
          - 5stack
there dmesg:
hda_codec: Unknown model for ALC883, trying auto-probe from
BIOS...
ALSA /root/alsa/alsa-driver-fixbug1/pci/hda/hda_codec.c:2170:
autoconfig: line_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa/alsa-driver-fixbug1/pci/hda/hda_codec.c:2174:
   speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa/alsa-driver-fixbug1/pci/hda/hda_codec.c:2176:
   hp=3D0x14, dig_out=3D0x1e, din_in=3D0x0
ALSA /root/alsa/alsa-driver-fixbug1/pci/hda/hda_codec.c:2184:
   inputs: mic=3D0x18, fmic=3D0x0, line=3D0x1a, fline=3D0x0, cd=3D0x0,
aux=3D0x0

and lots of messages like those one:
ALSA
/root/alsa/alsa-driver-fixbug1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.=
c:574:
hda-intel: send_cmd timeout: IRS=3D0x1, val=3D0x870610
ALSA
/root/alsa/alsa-driver-fixbug1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.=
c:574:
hda-intel: send_cmd timeout: IRS=3D0x1, val=3D0x824011
ALSA
/root/alsa/alsa-driver-fixbug1/acore/../alsa-kernel/core/pcm_lib.c:1997:
capture read error (DMA or IRQ trouble?)

result: no sound at all, mic won't work and freeze a bit audacity


model for ALC883:
   - 3stack-dig:
       dmesg
        ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
low) -> IRQ 16
        PCI: Setting latency timer of device 0000:00:1b.0 to 64
        ALSA
/root/alsa/alsa-driver-fixbug1/pci/hda/hda_codec.c:1759:
hda_codec: model '3stack-dig' is selected

       result: more channel but no sound and no mic

   - 6stack-dig
       dmesg
        ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
low) -> IRQ 16
        PCI: Setting latency timer of device 0000:00:1b.0 to 64
        ALSA
/root/alsa/alsa-driver-fixbug1/pci/hda/hda_codec.c:1759:     =

 hda_codec: model '6stack-dig' is selected
        ALSA
/root/alsa/alsa-driver-fixbug1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.=
c:525:
hda_intel: azx_get_response timeout, switching to single_cmd
mode...

       result: same

   - 6stack-dig-demo
      like 3stack-dig

Getting wired ^^ don't know what to do to help more.
Don't even understand why mic was running correctly at the
first time, don't understand lots of things ..
I try to find people who have an ALC883 and tell them to go at
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D2261

Arpac

Cet =E9t=E9, pensez aux cartes postales de laposte.net !




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
