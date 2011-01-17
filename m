From: Avinash Kurup <kurup.avinash@gmail.com>
Subject: ALSA: Sound barely audible since 2.6.37-rc1+
Date: Mon, 17 Jan 2011 20:54:29 +0530
Message-ID: <AANLkTinpBCweL8cvjaA1m0WpeqSkbXy9ZkNrvbJwXGg6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9814C10386D
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 16:24:30 +0100 (CET)
Received: by wyi11 with SMTP id 11so5233937wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 07:24:30 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

The sound on my computer since 2.6.37-rc1+ is barely audible (extremely
soft), The sound
remains the same even on increasing it on the desktop or the application.

On accessing alsa-mixer I get the error, cannot load mixer controls: Invalid
argument.

I bisected the problem to this commit.

03b7a1ab557efe34e8f79b78660e514bd7374248 is the first bad commit
commit 03b7a1ab557efe34e8f79b78660e514bd7374248
Author: David Henningsson <david.henningsson@canonical.com>
Date:   Tue Nov 9 14:35:30 2010 +0100

    ALSA: HDA: Create mixers on ALC887

    BugLink: http://launchpad.net/bugs/669092

    ALC887 does not have any volume control ability on the mixer NIDs,
    so put the volume controls on the dac NIDs instead. Without this
    patch, ALC887 users cannot use alsamixer at all.

    Cc: stable@kernel.org
    Signed-off-by: David Henningsson <david.henningsson@canonical.com>
    Signed-off-by: Takashi Iwai <tiwai@suse.de>

:040000 040000 f1e34cf6301ebd2ee2108af5195e2786c135e348
1e5d012759d201af4102a822dd94328080aa3a0b M sound

Other related info...
----------------------

avinash@neurolink:~/GIT_KERNEL_REPO/linux-2.6$ uname -a
Linux neurolink 2.6.37-rc1+ #164 SMP Mon Jan 17 20:15:43 IST 2011 x86_64
GNU/Linux

-----------------------

00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition
Audio Controller (rev 01)
        Subsystem: ASUSTeK Computer Inc. Device 840b
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 41
        Region 0: Memory at feaf8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: HDA Intel

-----------------------

[    0.705574] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 21 (level, low) ->
IRQ 21
[    0.705614] HDA Intel 0000:00:1b.0: irq 41 for MSI/MSI-X
[    0.705631] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    0.718522] hda_codec: ALC887: BIOS auto-probing.
[    0.723019] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[    0.723065] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[    0.723299] ALSA device list:
[    0.723300]   #0: HDA Intel at 0xfeaf8000 irq 41

[   11.871675] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   11.873023] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   11.876868] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   11.877050] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.194611] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.198401] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.202090] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.205695] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.209255] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.213087] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.216947] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.220568] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.224190] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.227777] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.231447] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.235007] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.238700] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.243109] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.246691] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.251026] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.254755] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.258345] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.262087] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.265796] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.269377] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.273008] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.276692] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.280294] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.285131] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.288754] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.292446] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.296148] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.299781] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.303378] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.306921] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.310713] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.314817] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.318398] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.322047] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.326940] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.330627] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.334215] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.337925] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.341670] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.345255] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.348877] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.352547] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.356359] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.356549] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.360214] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   12.360405] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   15.192801] EXT4-fs (sda9): re-mounted. Opts: errors=remount-ro
[   15.483245] EXT4-fs (sda8): mounted filesystem without journal. Opts:
(null)
[   15.855082] EXT4-fs (sda10): mounted filesystem with ordered data mode.
Opts: (null)
[   16.148277] EXT4-fs (sda11): mounted filesystem with ordered data mode.
Opts: (null)
[   16.462206] EXT4-fs (sda12): mounted filesystem with ordered data mode.
Opts: (null)
[   16.572061] EXT4-fs (sda13): mounted filesystem with ordered data mode.
Opts: (null)
[   16.617379] EXT4-fs (sda14): mounted filesystem with ordered data mode.
Opts: (null)
[   18.412393] ATL1E 0000:01:00.0: irq 42 for MSI/MSI-X
[   18.412895] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   18.414087] ATL1E 0000:01:00.0: eth0: NIC Link is Up <100 Mbps Full
Duplex>
[   18.414493] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   20.964039] uhci_hcd 0000:00:1d.1: reserve dev 2 ep81-INT, period 8,
phase 4, 93 us
[   22.398020] netconsole: network logging stopped, interface sit0
unregistered
[   22.409016] netconsole: network logging stopped, interface lo
unregistered
[   25.975782] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   26.036097] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   29.410004] eth0: no IPv6 routers present
[   38.350974] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)
[   38.365301] hda_codec: num_steps = 0 for NID=0x2 (ctl = Front Playback
Volume)

Please let me know if u need any more info...Any help would be appreciated.

Thanks,
Avinash.
