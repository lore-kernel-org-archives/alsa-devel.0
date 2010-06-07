From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [alsa-devel] No mixers on ATI RS780 Azalia
Date: Mon, 7 Jun 2010 12:03:48 -0400
Message-ID: <AANLkTilGlw3DP6iu6F5famvRTy6WZsglMnEXevqQ9mUJ@mail.gmail.com>
References: <alpine.LSU.2.01.1005261303170.19406@obet.zrqbmnf.qr>
	<s5hmxvmzwwd.wl%tiwai@suse.de>
	<alpine.LSU.2.01.1005261413040.23865@obet.zrqbmnf.qr>
	<4BFD2901.20800@ladisch.de>
	<alpine.LSU.2.01.1005271230340.18087@obet.zrqbmnf.qr>
	<4BFE5AA1.7070103@ladisch.de>
	<4BFE66CA.5070400@ladisch.de>
	<alpine.LSU.2.01.1006071404210.11780@obet.zrqbmnf.qr>
	<AANLkTilqmEK7R26DmLg0_LZ4al4F0_bX4asCl1DVA6GH@mail.gmail.com>
	<alpine.LSU.2.01.1006071721310.8380@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.01.1006071721310.8380@obet.zrqbmnf.qr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, Dave Airlie <airlied@redhat.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 7, 2010 at 11:25 AM, Jan Engelhardt <jengelh@medozas.de> wr=
ote:
>
> On Monday 2010-06-07 17:03, Alex Deucher wrote:
>>> * Why is it that I am only allowed to have sound in graphics mode?
>>
>>HDMI audio is only enabled on active outputs during modeset.
>
> Bleh. If it shows text, that seems pretty active to me.

Do you mean vga console prior to loading radeon or fb console after
loading radeon?  The driver needs to be loaded.  Also, the attached
monitor has to announce itself as hdmi for audio to be enabled.

>
>>> * The radeon.ko module does not have any PCI IDs defined, thus does=
 not
>>> get autoloaded like i915.ko. Is this intentional? It also seems
>>> to default to modeset=3D0.
>>
>>What kernel are you using? =A0It definitely has pci ids and autoloads=
 just fine.
>
> 17:20 lxwks:~ > modinfo radeon
> filename:
> /lib/modules/2.6.31.12-jen93-rt/kernel/drivers/gpu/drm/radeon/radeon.=
ko
> license: =A0 =A0 =A0 =A0GPL and additional rights
> description: =A0 =A0ATI Radeon
> author: =A0 =A0 =A0 =A0 Gareth Hughes, Keith Whitwell, others.
> srcversion: =A0 =A0 D95F7F85D05C72112F277F3
> depends: =A0 =A0 =A0 =A0drm
> vermagic: =A0 =A0 =A0 2.6.31.12-jen93-rt SMP preempt mod_unload modve=
rsions 686
> parm: =A0 =A0 =A0 =A0 =A0 no_wb:Disable AGP writeback for scratch reg=
isters (int)
>
> 17:23 samsung:~ # modinfo radeon
> filename:
> /lib/modules/2.6.35-rc2-default+/kernel/drivers/gpu/drm/radeon/radeon=
=2Eko
> license: =A0 =A0 =A0 =A0GPL and additional rights
> description: =A0 =A0ATI Radeon
> author: =A0 =A0 =A0 =A0 Gareth Hughes, Keith Whitwell, others.
> firmware: =A0 =A0 =A0 radeon/R520_cp.bin
> firmware: =A0 =A0 =A0 radeon/RS600_cp.bin
> firmware: =A0 =A0 =A0 radeon/RS690_cp.bin
> firmware: =A0 =A0 =A0 radeon/R420_cp.bin
> firmware: =A0 =A0 =A0 radeon/R300_cp.bin
> firmware: =A0 =A0 =A0 radeon/R200_cp.bin
> firmware: =A0 =A0 =A0 radeon/R100_cp.bin
> firmware: =A0 =A0 =A0 radeon/RV710_me.bin
> firmware: =A0 =A0 =A0 radeon/RV710_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV730_me.bin
> firmware: =A0 =A0 =A0 radeon/RV730_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV770_me.bin
> firmware: =A0 =A0 =A0 radeon/RV770_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RS780_me.bin
> firmware: =A0 =A0 =A0 radeon/RS780_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV670_me.bin
> firmware: =A0 =A0 =A0 radeon/RV670_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV635_me.bin
> firmware: =A0 =A0 =A0 radeon/RV635_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV620_me.bin
> firmware: =A0 =A0 =A0 radeon/RV620_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV630_me.bin
> firmware: =A0 =A0 =A0 radeon/RV630_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV610_me.bin
> firmware: =A0 =A0 =A0 radeon/RV610_pfp.bin
> firmware: =A0 =A0 =A0 radeon/R600_me.bin
> firmware: =A0 =A0 =A0 radeon/R600_pfp.bin
> firmware: =A0 =A0 =A0 radeon/R520_cp.bin
> firmware: =A0 =A0 =A0 radeon/RS600_cp.bin
> firmware: =A0 =A0 =A0 radeon/RS690_cp.bin
> firmware: =A0 =A0 =A0 radeon/R420_cp.bin
> firmware: =A0 =A0 =A0 radeon/R300_cp.bin
> firmware: =A0 =A0 =A0 radeon/R200_cp.bin
> firmware: =A0 =A0 =A0 radeon/R100_cp.bin
> firmware: =A0 =A0 =A0 radeon/CYPRESS_rlc.bin
> firmware: =A0 =A0 =A0 radeon/CYPRESS_me.bin
> firmware: =A0 =A0 =A0 radeon/CYPRESS_pfp.bin
> firmware: =A0 =A0 =A0 radeon/JUNIPER_rlc.bin
> firmware: =A0 =A0 =A0 radeon/JUNIPER_me.bin
> firmware: =A0 =A0 =A0 radeon/JUNIPER_pfp.bin
> firmware: =A0 =A0 =A0 radeon/REDWOOD_rlc.bin
> firmware: =A0 =A0 =A0 radeon/REDWOOD_me.bin
> firmware: =A0 =A0 =A0 radeon/REDWOOD_pfp.bin
> firmware: =A0 =A0 =A0 radeon/CEDAR_rlc.bin
> firmware: =A0 =A0 =A0 radeon/CEDAR_me.bin
> firmware: =A0 =A0 =A0 radeon/CEDAR_pfp.bin
> firmware: =A0 =A0 =A0 radeon/R700_rlc.bin
> firmware: =A0 =A0 =A0 radeon/R600_rlc.bin
> firmware: =A0 =A0 =A0 radeon/RV710_me.bin
> firmware: =A0 =A0 =A0 radeon/RV710_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV730_me.bin
> firmware: =A0 =A0 =A0 radeon/RV730_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV770_me.bin
> firmware: =A0 =A0 =A0 radeon/RV770_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RS780_me.bin
> firmware: =A0 =A0 =A0 radeon/RS780_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV670_me.bin
> firmware: =A0 =A0 =A0 radeon/RV670_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV635_me.bin
> firmware: =A0 =A0 =A0 radeon/RV635_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV620_me.bin
> firmware: =A0 =A0 =A0 radeon/RV620_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV630_me.bin
> firmware: =A0 =A0 =A0 radeon/RV630_pfp.bin
> firmware: =A0 =A0 =A0 radeon/RV610_me.bin
> firmware: =A0 =A0 =A0 radeon/RV610_pfp.bin
> firmware: =A0 =A0 =A0 radeon/R600_me.bin
> firmware: =A0 =A0 =A0 radeon/R600_pfp.bin
> srcversion: =A0 =A0 DF143D97DD12F63E6EEAF3F
> depends: =A0 =A0 =A0 =A0drm,drm_kms_helper,ttm,i2c-core,i2c-algo-bit
> vermagic: =A0 =A0 =A0 2.6.35-rc2-default+ SMP mod_unload modversions
> parm: =A0 =A0 =A0 =A0 =A0 no_wb:Disable AGP writeback for scratch reg=
isters (int)
> parm: =A0 =A0 =A0 =A0 =A0 modeset:Disable/Enable modesetting (int)
> parm: =A0 =A0 =A0 =A0 =A0 dynclks:Disable/Enable dynamic clocks (int)
> parm: =A0 =A0 =A0 =A0 =A0 r4xx_atom:Enable ATOMBIOS modesetting for R=
4xx (int)
> parm: =A0 =A0 =A0 =A0 =A0 vramlimit:Restrict VRAM for testing (int)
> parm: =A0 =A0 =A0 =A0 =A0 agpmode:AGP Mode (-1 =3D=3D PCI) (int)
> parm: =A0 =A0 =A0 =A0 =A0 gartsize:Size of PCIE/IGP gart to setup in =
megabytes (32,64,
> etc)
> =A0(int)
> parm: =A0 =A0 =A0 =A0 =A0 benchmark:Run benchmark (int)
> parm: =A0 =A0 =A0 =A0 =A0 test:Run tests (int)
> parm: =A0 =A0 =A0 =A0 =A0 connector_table:Force connector table (int)
> parm: =A0 =A0 =A0 =A0 =A0 tv:TV enable (0 =3D disable) (int)
> parm: =A0 =A0 =A0 =A0 =A0 new_pll:Select new PLL code (int)
> parm: =A0 =A0 =A0 =A0 =A0 audio:Audio enable (0 =3D disable) (int)
> parm: =A0 =A0 =A0 =A0 =A0 disp_priority:Display Priority (0 =3D auto,=
 1 =3D normal, 2 =3D high)
> (int)
> parm: =A0 =A0 =A0 =A0 =A0 hw_i2c:hw i2c engine enable (0 =3D disable)=
 (int)
> 17:24 samsung:~/linux-2.6 # git describe
> v2.6.35-rc2-1-g386f40c
> 17:25 samsung:../gpu/drm # git grep PCI_DEVICE_TABLE radeon/
> 17:25 samsung:../gpu/drm #
>

The pci ids are in include/drm/drm_pciids.h

modinfo radeon
=2E..
srcversion:     0D187768753F1469A0E118E
alias:          pci:v00001002d00009715sv*sd*bc*sc*i*
alias:          pci:v00001002d00009714sv*sd*bc*sc*i*
alias:          pci:v00001002d00009713sv*sd*bc*sc*i*
alias:          pci:v00001002d00009712sv*sd*bc*sc*i*
alias:          pci:v00001002d00009711sv*sd*bc*sc*i*
alias:          pci:v00001002d00009710sv*sd*bc*sc*i*
alias:          pci:v00001002d00009616sv*sd*bc*sc*i*
alias:          pci:v00001002d00009615sv*sd*bc*sc*i*
alias:          pci:v00001002d00009614sv*sd*bc*sc*i*
alias:          pci:v00001002d00009613sv*sd*bc*sc*i*
alias:          pci:v00001002d00009612sv*sd*bc*sc*i*
alias:          pci:v00001002d00009611sv*sd*bc*sc*i*
alias:          pci:v00001002d00009610sv*sd*bc*sc*i*
alias:          pci:v00001002d000095CFsv*sd*bc*sc*i*
alias:          pci:v00001002d000095CEsv*sd*bc*sc*i*
alias:          pci:v00001002d000095CDsv*sd*bc*sc*i*
=2E..

Alex
