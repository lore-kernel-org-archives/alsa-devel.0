From: Thomas Wagner <thomas@thowabu.de>
Subject: Intel-HDA Realtek Codec //  double matching PCI IDs
Date: Sun, 26 Dec 2010 19:51:11 +0100
Message-ID: <4D178E9F.4040701@thowabu.de>
References: <4D14A309.9030603@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ips-amsel.de (mail.ips-amsel.de [85.10.202.234])
	by alsa0.perex.cz (Postfix) with ESMTP id B6F48245EE
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2010 18:51:19 +0100 (CET)
In-Reply-To: <4D14A309.9030603@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello there,

I am in trouble with Sound on my Asus N53Jf Notebook.
Full Story at : https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D51=
88


Raymond noticed that My and the ASUS N63Jn share the same PCI ID.
Forcing ALSA to BIOS autoprobe is my current workaround.
The PCI QUIRK for N63Jn spoils the Autodetect for my N53Jf.


Second Issue the "Subwoofer" isn=B4t connected.

I think it=B4s like the

          ALC269_FIXUP_ASUS_G73JW


I didn=B4t find a way to seperate both Hardware behaviours...
Or is it an mistake ?

Maybe someone give me an hint?
Through the code I can=B4t understand the whole design/Structure.


Sorry,
    Thomas

---
thomas@arthur:~$ lspci -vvvvvnnnnnnnnnnnn
...
00:1b.0 Audio device [0403]: Intel Corporation 5 Series/3400 Series =

Chipset High Definition Audio [8086:3b56] (rev 06)
         Subsystem: ASUSTeK Computer Inc. Device [1043:1113]
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =

ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =

<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 49
         Region 0: Memory at d9c00000 (64-bit, non-prefetchable) [size=3D16=
K]
         Capabilities: <access denied>
         Kernel driver in use: HDA Intel
---

thomas@arthur:~$ dmesg | grep ALSA
[    6.926061] ALSA sound/pci/hda/hda_intel.c:2530: chipset global =

capabilities =3D 0x4401
[    6.951268] ALSA sound/pci/hda/hda_intel.c:913: codec_mask =3D 0x1
[    6.951435] ALSA sound/pci/hda/hda_intel.c:1351: codec #0 probed OK
[    7.100521] ALSA sound/pci/hda/patch_realtek.c:1524: SKU: Nid=3D0x1d =

sku_cfg=3D0x40079a2d
[    7.100526] ALSA sound/pci/hda/patch_realtek.c:1526: SKU: =

port_connectivity=3D0x1
[    7.100529] ALSA sound/pci/hda/patch_realtek.c:1527: SKU: =

enable_pcbeep=3D0x0
[    7.100531] ALSA sound/pci/hda/patch_realtek.c:1528: SKU: =

check_sum=3D0x00000007
[    7.100533] ALSA sound/pci/hda/patch_realtek.c:1529: SKU: =

customization=3D0x0000009a
[    7.100536] ALSA sound/pci/hda/patch_realtek.c:1530: SKU: =

external_amp=3D0x5
[    7.100538] ALSA sound/pci/hda/patch_realtek.c:1531: SKU: =

platform_type=3D0x1
[    7.100540] ALSA sound/pci/hda/patch_realtek.c:1532: SKU: swap=3D0x0
[    7.100542] ALSA sound/pci/hda/patch_realtek.c:1533: SKU: override=3D0x1
[    7.100941] ALSA sound/pci/hda/hda_codec.c:3726: hda_codec: model =

'#4' is selected for config 1043:1113 (ASUS N63Jn)
[    7.100949] ALSA sound/pci/hda/hda_codec.c:4630: autoconfig: =

line_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
[    7.100952] ALSA sound/pci/hda/hda_codec.c:4634:    speaker_outs=3D0 =

(0x0/0x0/0x0/0x0/0x0)
[    7.100955] ALSA sound/pci/hda/hda_codec.c:4638:    hp_outs=3D1 =

(0x21/0x0/0x0/0x0/0x0)
[    7.100958] ALSA sound/pci/hda/hda_codec.c:4639:    mono: mono_out=3D0x0
[    7.100960] ALSA sound/pci/hda/hda_codec.c:4642:    dig-out=3D0x1e/0x0
[    7.100962] ALSA sound/pci/hda/hda_codec.c:4643:    inputs:
[    7.100964] ALSA sound/pci/hda/hda_codec.c:4647:  Mic=3D0x18
[    7.100967] ALSA sound/pci/hda/hda_codec.c:4647:  Internal Mic=3D0x19
[    7.100969] ALSA sound/pci/hda/hda_codec.c:4649:
[    7.101464] ALSA sound/pci/hda/patch_realtek.c:1581: realtek: No =

valid SSID, checking pincfg 0x40079a2d for NID 0x1d
[    7.101467] ALSA sound/pci/hda/patch_realtek.c:1597: realtek: =

Enabling init ASM_ID=3D0x9a2d CODEC_ID=3D10ec0269
[    7.101470] ALSA sound/pci/hda/patch_realtek.c:1411: realtek: Enable =

HP auto-muting on NID 0x21
[    7.101475] ALSA sound/pci/hda/patch_realtek.c:1456: realtek: Enable =

auto-mic switch on NID 0x18/0x19
[    8.103979] ALSA sound/pci/hda/hda_intel.c:706: azx_get_response =

timeout, polling the codec once: last cmd=3D0x023b0000
[    8.106522] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Front Playback Volume, skipped
[    8.106525] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Surround Playback Volume, skipped
[    8.106528] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Center Playback Volume, skipped
[    8.106530] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

LFE Playback Volume, skipped
[    8.106533] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Side Playback Volume, skipped
[    8.106536] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Headphone Playback Volume, skipped
[    8.106541] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Mono Playback Volume, skipped
[    8.106544] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Line-Out Playback Volume, skipped
[    8.106546] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

PCM Playback Volume, skipped
[    8.106552] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Front Playback Switch, skipped
[    8.106555] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Surround Playback Switch, skipped
[    8.106557] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Center Playback Switch, skipped
[    8.106560] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

LFE Playback Switch, skipped
[    8.106563] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Side Playback Switch, skipped
[    8.106567] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Mono Playback Switch, skipped
[    8.106572] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

Line-Out Playback Switch, skipped
[    8.106574] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave =

PCM Playback Switch, skipped
[   20.330511] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: =

bufsize=3D0x10000, format=3D0x31
[   20.330532] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   20.330683] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[   20.627244] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x3
[   20.627254] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x6
[   77.245942] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x6
[   77.316467] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: =

bufsize=3D0x10000, format=3D0x31
[   77.316487] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   77.316493] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[   77.318191] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x3
[   77.318195] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x6
[   77.654029] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: =

bufsize=3D0x10000, format=3D0x31
[   77.654049] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   77.654055] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[   77.655089] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x3
[   77.655093] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x6
[   77.656024] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: =

bufsize=3D0x10000, format=3D0x31
[   77.656037] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   77.656042] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[   77.656254] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x3
[   77.656257] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x6
[   78.816820] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: =

bufsize=3D0x10000, format=3D0x31
[   78.816840] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   78.816846] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[   87.131884] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x3
[   87.131893] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x6
[   94.313660] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: =

bufsize=3D0x10000, format=3D0x31
[   94.313679] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   94.313685] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[  107.788608] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x3
[  107.788659] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x6
[  108.329971] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: =

bufsize=3D0x10000, format=3D0x31
[  108.329991] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[  108.329998] ALSA sound/pci/hda/hda_codec.c:1227: =

hda_codec_setup_stream: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[  121.804827] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x3
[  121.804834] ALSA sound/pci/hda/hda_codec.c:1290: =

hda_codec_cleanup_stream: NID=3D0x6
thomas@arthur:~$

---

patch_realtek.c


static struct snd_pci_quirk alc269_cfg_tbl[] =3D {
     SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_QUANTA_FL1),
     SND_PCI_QUIRK(0x1025, 0x047c, "ACER ZGA", ALC271_ACER),
     SND_PCI_QUIRK(0x1043, 0x8330, "ASUS Eeepc P703 P900A",
               ALC269_AMIC),
     SND_PCI_QUIRK(0x1043, 0x1013, "ASUS N61Da", ALC269VB_AMIC),
     SND_PCI_QUIRK(0x1043, 0x1113, "ASUS N63Jn", ALC269VB_AMIC), <----- =

Quirk spoils Autodetect.
     SND_PCI_QUIRK(0x1043, 0x1143, "ASUS B53f", ALC269VB_AMIC),


---
