Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38955CD5BBF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 08:47:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B49E560193;
	Mon, 25 May 2026 10:47:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B49E560193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779698876;
	bh=n+jEYNQZoGNU/00B+OCCVs53IAZRKNiCjUbE8eV9Dm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=okFBi00lXd7cISdeJEg0IsdGuGkGwWNa6TjYviOvIUlnILeb8/8+EwgVreq7WULW7
	 dk9dmxz3Tadn1nx660wU8FnQEmr8ZtozDgf69t4l5FxAA1M1hAhePUyqWyHsbLdEn1
	 0KmMi9dv5+Je9nLgKAJeWCiDWZgdguFtU0q7jkIk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65C64F805F5; Mon, 25 May 2026 10:47:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 08F66F805E4;
	Mon, 25 May 2026 10:47:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 389E0F80557; Mon, 25 May 2026 10:47:17 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 58A92F8001F
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 10:47:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58A92F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Fmy7j1ju
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E1D8E600BB;
	Fri, 22 May 2026 13:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512ED1F000E9;
	Fri, 22 May 2026 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454881;
	bh=3zsJLMaXTshqtgEyzR+DgI3rSwCYBOuWRbhutPrMydM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fmy7j1juaTFR6jJw9baSkgIZTi+Z8eXL2dvaZmX6sUnR3aIUpO1xvWWMXTlyBSm03
	 3YiFHuEeYZ4nD8BCvfSAVghlUSip/QrpG6rRCmDWPrZUkHV6KkTEnK+N7swDNhaZpS
	 2nANsvivQirZDiz/y9S80dNgi6zB6jBYwj2dwOMO9PwXDCOl7IEWBDRGjufsCQ5vLl
	 bon0/RzdtfodhdtlUg0Ylb4gnNhImNRW3Y93mV/55N+EWe8EVaz8Dteqk8vNDW2/OD
	 DVHdqK4a5LhD4wdp4t8jaHIa9mpuxBMbyji/thDXdK+tFwDWaAVHT9kWQC2Slh3g73
	 y3knO8jy5S8cw==
Date: Fri, 22 May 2026 14:01:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Adnrey Golovko <andrey.golovko@gmail.com>
Cc: Vijendar.Mukunda@amd.com, superm1@kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, tiwai@suse.de,
	yung-chuan.liao@linux.intel.com,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>
Subject: Re: [BUG] ASoC: amd: ps / soundwire: SDW peripherals unrecoverable
 after s0i3 on Strix Halo (ACP7.0)
Message-ID: <9a017983-c4ce-4abb-a9cf-8e6c2bafac70@sirena.org.uk>
References: <7328cdbf-10fb-46a1-a28c-2f7365fd767d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G5ctiBjKCadam6UL"
Content-Disposition: inline
In-Reply-To: <7328cdbf-10fb-46a1-a28c-2f7365fd767d@gmail.com>
X-Cookie: Celebrity voices impersonated.
Message-ID-Hash: XUVMWZ4MK5IK4ELSIMXDDTIGWFKIDYPO
X-Message-ID-Hash: XUVMWZ4MK5IK4ELSIMXDDTIGWFKIDYPO
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XUVMWZ4MK5IK4ELSIMXDDTIGWFKIDYPO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--G5ctiBjKCadam6UL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 03:54:06PM +0300, Adnrey Golovko wrote:
> =C2=A0 SoundWire slaves lose firmware after s2idle on AMD ACP7.0 (Strix H=
alo) =E2=80=94
> =C2=A0 TAS2783 cannot resume

Adding the TI people (not deleting context for their benefit), my first
thought here is that this is the CODEC driver not redownloading firmware
after power loss.

>=20
> =C2=A0 ## Summary
>=20
> =C2=A0 On ASUS ProArt PX13 HN7306EAC (AMD Ryzen AI MAX+ 395, Strix Halo) =
with=C2=A0
> ACP=C2=A0 PCI
> =C2=A0 rev=C2=A0 0x70=C2=A0 (ACP7.0), entering=C2=A0 s2idle=C2=A0 for as =
little as 3.8 seconds causes
> the
> =C2=A0 Realtek RT721 SDCA and TI TAS2783 SoundWire peripherals to enter an
> =C2=A0 unrecoverable state. After resume,=C2=A0 Peripheral status =3D una=
ttached=C2=A0 and
> the
> =C2=A0 TAS2783 driver reports=C2=A0 error playback without fw download . =
No
> software-only
> =C2=A0 recovery is possible =E2=80=94 driver re-bind, PCI hot remove+resc=
an, and module
> reload
> =C2=A0 all fail. Only a full machine reboot restores audio.
>=20
> =C2=A0 Filed because all available fixes in current upstream/-next are al=
ready
> applied
> =C2=A0 and do not address the root cause.
>=20
> =C2=A0 ## Hardware
>=20
> =C2=A0 =C2=A0 DMI:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
ASUS HN7306EAC, BIOS HN7306EAC.307 (2026-01-27)
> =C2=A0 =C2=A0 CPU:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
AMD Ryzen AI MAX+ 395 w/ Radeon 8060S (Strix Halo)
> =C2=A0 =C2=A0 ACP PCI ID:=C2=A0 =C2=A0 =C2=A0 =C2=A0 1022:15e2 rev 0x70=
=C2=A0 (sysfs: 0000:c4:00.5)
> =C2=A0 =C2=A0 ACP driver:=C2=A0 =C2=A0 =C2=A0 =C2=A0 snd_pci_ps
> =C2=A0 =C2=A0 SoundWire link 1:=C2=A0 Realtek RT721 SDCA=C2=A0 (sdw:0:1:0=
25d:0721:01)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A02=C3=97 TI TAS2783=C2=A0 =C2=A0 =C2=A0 =C2=A0 (sdw:0:1:0102:0000:=
01:8,
> ...:01:b)
> =C2=A0 =C2=A0 TAS2783 firmware:=C2=A0 /lib/firmware/1714-1-{8,B}.bin=C2=
=A0 (extracted from
> Windows
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0driver =E2=80=94 ASUS does not ship to linux-firmware as of
> 2026-
> =C2=A0 05)
> =C2=A0 =C2=A0 ACPI path:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\_SB.PCI0.GPPA.=
ACP.SDWC.SWM1
>=20
> =C2=A0 ## Kernel
>=20
> =C2=A0 =C2=A0 Linux 7.1.0-rc3 + 3 backports:
> =C2=A0 =C2=A0 =C2=A0 c368dd5cbd61 soundwire: don't program SDW_SCP_BUSCLO=
CK_SCALE on a
> unattached
> =C2=A0 Peripheral
> =C2=A0 =C2=A0 =C2=A0 9a0afdd19a01 soundwire: stream: sdw_stream_remove_sl=
ave(): Check
> stream is
> =C2=A0 valid
> =C2=A0 =C2=A0 =C2=A0 e09bbf11b53f HID: input: delete hid_battery on disco=
nnect (unrelated)
>=20
> =C2=A0 =C2=A0git log v7.1-rc3..v7.1-rc4 -- sound/soc/amd drivers/soundwir=
e/ is empty.
> =C2=A0 =C2=A0broonie/sound#for-next=C2=A0 adds=C2=A0 sound/soc/amd/acp7x/=
=C2=A0 (ACP7.D/E/F, rev
> 0x7D-0x7F)
> =C2=A0 =E2=80=94
> =C2=A0 not applicable to ACP7.0.
>=20
> =C2=A0 ## DSDT / ACPI properties
>=20
> =C2=A0 SWM1 (active link) has:
>=20
> =C2=A0 =C2=A0 amd-sdw-power-mode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x02 =C2=A0(AMD_SDW_POWER_OFF_MODE)
> =C2=A0 =C2=A0 amd-sdw-enable=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1
> =C2=A0 =C2=A0 amd-sdw-wakeup-enable=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D 1
> =C2=A0 =C2=A0 mipi-sdw-clock-stop-mode0-supported=C2=A0 =C2=A0=3D 1
> =C2=A0 =C2=A0 mipi-sdw-clock-stop-mode1-supported=C2=A0 =C2=A0=3D 0
>=20
> =C2=A0 No=C2=A0 _PS0 / _PS3 / _PR0 / _PR3=C2=A0 methods for \_SB.PCI0.GPP=
A.ACP.SDWC=C2=A0 or its
> =C2=A0 =C2=A0SWM0 / SWM1=C2=A0 children, no=C2=A0 _RST=C2=A0 method.
>=20
> =C2=A0 With=C2=A0 power_mode_mask =3D AMD_SDW_POWER_OFF_MODE ,
> =C2=A0 drivers/soundwire/amd_manager.c
> =C2=A0 correctly takes the full deinit/init path: amd_deinit_sdw_manager(=
)=C2=A0 on
> =C2=A0 suspend,
> =C2=A0 =C2=A0sdw_clear_slave_status(SDW_UNATTACH_REQUEST_MASTER_RESET) +
> =C2=A0 amd_sdw_clk_init_ctrl +
> =C2=A0 amd_init_sdw_manager + amd_enable_sdw_manager + amd_sdw_set_frames=
hape=C2=A0 on
> =C2=A0 resume.
> =C2=A0 =C2=A0snd_acp70_resume()=C2=A0 in=C2=A0 sound/soc/amd/ps/ps-common=
=2Ec=C2=A0 correctly takes the
> slow
> =C2=A0 path ( acp_hw_init=C2=A0 + pad-keeper restore) because=C2=A0 sdw_e=
n_stat=C2=A0 is cleared
> =C2=A0 during
> =C2=A0 suspend by=C2=A0 amd_deinit_sdw_manager . So the driver-level resu=
me code paths
> are
> =C2=A0 exercised correctly. The failure is at a lower level.
>=20
> =C2=A0 ## Reproducer
>=20
> =C2=A0 =C2=A0 # Cold boot, audio works.
> =C2=A0 =C2=A0 $ aplay -l | grep amdsoundwire
> =C2=A0 =C2=A0 card 1: amdsoundwire ... SDW1-PIN1-PLAYBACK-SmartAmp multic=
odec-2 []
> =C2=A0 =C2=A0 $ speaker-test -D plughw:1,2 -c2=C2=A0 # =E2=86=92 works
>=20
> =C2=A0 =C2=A0 # One s2idle cycle:
> =C2=A0 =C2=A0 $ systemctl suspend
> =C2=A0 =C2=A0 # (3.8 sec residency in s0i3, /sys/kernel/debug/amd_pmc/s0i=
x_stats
> confirms)
> =C2=A0 =C2=A0 # (woken by i2c-ASCF1A03:00 touchpad wake event, but issue =
reproduces
> with
> =C2=A0 =C2=A0 #=C2=A0 any wake source including RTC alarm)
>=20
> =C2=A0 =C2=A0 # After resume:
> =C2=A0 =C2=A0 $ speaker-test -D plughw:1,2 -c2
> =C2=A0 =C2=A0 Setting of hwparams failed: Invalid argument
>=20
> =C2=A0 ## Evidence =E2=80=94 kernel trace
>=20
> =C2=A0 =C2=A0/sys/power/suspend_stats :
>=20
> =C2=A0 =C2=A0 last_failed_dev=C2=A0 =C2=A0 =3D sdw:0:1:0102:0000:01:b
> =C2=A0 =C2=A0 last_failed_step=C2=A0 =C2=A0=3D resume
> =C2=A0 =C2=A0 last_hw_sleep=C2=A0 =C2=A0 =C2=A0 =3D 3825561=C2=A0 =C2=A0(=
=C2=B5s)
>=20
> =C2=A0 =C2=A0journalctl -k=C2=A0 around suspend/resume:
>=20
> =C2=A0 =C2=A0 PM: suspend entry (s2idle)
> =C2=A0 =C2=A0 Freezing user space processes completed
> =C2=A0 =C2=A0 printk: Suspending console(s)
> =C2=A0 =C2=A0 ACPI: EC: interrupt blocked
> =C2=A0 =C2=A0 ACPI: EC: interrupt unblocked
> =C2=A0 =C2=A0 slave-tas2783 sdw:0:1:0102:0000:01:8: PM: dpm_run_callback(=
):
> =C2=A0 acpi_subsys_resume returns -110
> =C2=A0 =C2=A0 slave-tas2783 sdw:0:1:0102:0000:01:8: PM: failed to resume:=
 error -110
> =C2=A0 =C2=A0 slave-tas2783 sdw:0:1:0102:0000:01:b: PM: dpm_run_callback(=
):
> =C2=A0 acpi_subsys_resume returns -110
> =C2=A0 =C2=A0 slave-tas2783 sdw:0:1:0102:0000:01:b: PM: failed to resume:=
 error -110
> =C2=A0 =C2=A0 PM: suspend exit
> =C2=A0 =C2=A0 snd_pci_ps 0000:c4:00.5: AMD-Vi: Event logged [IO_PAGE_FAULT
> =C2=A0 =C2=A0 =C2=A0 =C2=A0domain=3D0x0018 address=3D0xfffffffffffffffc f=
lags=3D0x0030]
>=20
> =C2=A0 The=C2=A0 0xfffffffffffffffc=C2=A0 IOMMU fault address is the sent=
inel returned when
> PCI
> =C2=A0 config reads return=C2=A0 0xff..ff , i.e., ACP is in an inaccessib=
le state at
> the
> =C2=A0 moment of DMA.
>=20
> =C2=A0 Detailed resume-path trace (excerpts):
>=20
> =C2=A0 =C2=A0 amd_sdw_manager amd_sdw_manager.1: SCP_addrpage ignored for=
 Slave 1
> =C2=A0 =C2=A0 soundwire sdw-master-0-1: trf on Slave 1 failed:-5 write ad=
dr 8089 count
> 0
> =C2=A0 =C2=A0 amd_sdw amd_sdw: ASoC: PRE_PMD: tas2783-2 FU21 event failed=
: -5
> =C2=A0 =C2=A0 amd_sdw_manager amd_sdw_manager.1: SCP_addrpage ignored for=
 Slave 2
> =C2=A0 =C2=A0 soundwire sdw-master-0-1: trf on Slave 2 failed:-5 write ad=
dr 8089 count
> 0
> =C2=A0 =C2=A0 rt721-sdca sdw:0:1:025d:0721:01: Initialization not complet=
e, timed out
> =C2=A0 =C2=A0 amd_sdw_manager amd_sdw_manager.1: slave_stat:0x1
> =C2=A0 =C2=A0 soundwire sdw-master-0-1: PING status: 0x1
> =C2=A0 =C2=A0 amd_sdw_manager amd_sdw_manager.1: SDW1 clock stop successf=
ul
> =C2=A0 =C2=A0 amd_sdw_manager amd_sdw_manager.1: AMD_SDW_DEVICE_STATE:0xc
> =C2=A0 =C2=A0 amd_sdw_manager amd_sdw_manager.1: mclk 24000000 max 120000=
00 row 50 col
> 10
> =C2=A0 frame_rate:48000
> =C2=A0 =C2=A0 amd_sdw_manager amd_sdw_manager.1: AMD_SDW_DEVICE_STATE:0x0
> =C2=A0 =C2=A0 snd_pci_ps 0000:c4:00.5: AMD-Vi: Event logged [IO_PAGE_FAUL=
T ...
> =C2=A0 0xfffffffffffffffc ...]
> =C2=A0 =C2=A0 slave-tas2783 sdw:0:1:0102:0000:01:8: resume: initializatio=
n timed out
> =C2=A0 =C2=A0 soundwire sdw-master-0-1: PING status: 0x1
>=20
> =C2=A0 Note=C2=A0 PING status: 0x1=C2=A0 =E2=80=94 the SoundWire PING-fra=
me status returns the same
> low
> =C2=A0 value before and after the manager attempts to re-enumerate. Perip=
herals
> are
> =C2=A0 not responding on the wire even though clock is running.
>=20
> =C2=A0 Steady-state symptoms after the resume path completes (slave drive=
rs
> loaded,
> =C2=A0 codec link tries to prepare PCM):
>=20
> =C2=A0 =C2=A0 slave-tas2783 sdw:0:1:0102:0000:01:8: Peripheral status =3D=
 unattached
> =C2=A0 =C2=A0 slave-tas2783 sdw:0:1:0102:0000:01:8: error playback withou=
t fw download
> =C2=A0 =C2=A0 slave-tas2783 sdw:0:1:0102:0000:01:8: ASoC error (-22): at
> =C2=A0 snd_soc_dai_hw_params()
> =C2=A0 =C2=A0 soundwire sdw-master-0-1: Program transport params failed: =
-61
> =C2=A0 =C2=A0 amd_sdw_manager amd_sdw_manager.1: command is ignored for S=
lave 2
>=20
> =C2=A0 =C2=A0command is ignored for Slave N=C2=A0 from=C2=A0 amd_sdw_fill=
_msg_resp() indicates
> the
> =C2=A0 SoundWire bus sees no ACK for any peripheral command =E2=80=94 the=
 peripherals are
> not
> =C2=A0 responding on the wire.
>=20
> =C2=A0 The=C2=A0 error playback without fw download=C2=A0 from=C2=A0 tas2=
783-sdw.c=C2=A0 is the
> giveaway =E2=80=94
> =C2=A0 the TAS2783 driver explicitly knows its firmware blob is no longer=
 loaded.
> =C2=A0 During cold boot the firmware is downloaded after slave attach; af=
ter
> s0i3, the
> =C2=A0 slave never reaches attached state, so the firmware download path =
is never
> =C2=A0 re-entered.
>=20
> =C2=A0 ## Recovery attempts =E2=80=94 ALL FAIL
>=20
> =C2=A0 Attempt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=82Result
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> =C2=A0 Stop PipeWire,=C2=A0 rmmod snd_soc_tas2783_=E2=80=A6=E2=94=82 EBUS=
Y=C2=A0 =E2=80=94 kernel ALSA-SOC retry
> loop ho=E2=80=A6
> =C2=A0 =C2=A0echo 0000:c4:00.5 > /sys/bus/pci/driv=E2=80=A6=E2=94=82Probe=
 replays cleanly ( probe
> complete =E2=80=A6
> =C2=A0 PCIe Function-Level Reset ( /sys/.../r=E2=80=A6=E2=94=82File does =
not exist =E2=80=94 ACP does not
> adve=E2=80=A6
> =C2=A0 =C2=A0echo 1 > /sys/bus/pci/devices/0000:c4=E2=80=A6=E2=94=82Same =
as unbind+bind =E2=80=94 slaves
> enumerate =E2=80=A6
> =C2=A0 pm-utils system-sleep hook running the=E2=80=A6=E2=94=82Same
> =C2=A0 BIOS update 305 =E2=86=92 307=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=82No change
>=20
> =C2=A0 This is consistent with the underlying SMU behaviour on Strix Halo=
 s0i3:
> =C2=A0 the ACP power island is power-gated, peripherals connected to the
> SoundWire
> =C2=A0 pads lose state including firmware. There is no software path from=
 the OS
> =C2=A0 to re-power the slave chips short of a full machine reboot.
>=20
> =C2=A0 ## What I think the bug is
>=20
> =C2=A0 Either (a) the AMD SMU should hold the ACP power island powered du=
ring
> s0i3
> =C2=A0 when SoundWire link is active and peripherals require firmware (BI=
OS or
> SMU
> =C2=A0 firmware change), or (b) the kernel needs an explicit recovery pat=
h that:
>=20
> =C2=A0 1. Detects in=C2=A0 snd_acp70_resume()=C2=A0 that ACP was actually=
 power-gated (e.g.
> =C2=A0 by reading a sentinel register that survives only across non-power=
-gated
> =C2=A0 suspend).
> =C2=A0 2. If power-gated, performs a full peripheral-chip reset (some
> platform-specific
> =C2=A0 GPIO toggle? secondary bus reset on the ACP's PCIe link?) before t=
he SDW
> =C2=A0 manager attempts to re-enumerate.
> =C2=A0 3. Triggers each slave driver's firmware-download path on resume.
>=20
> =C2=A0 I cannot find any GPIO under=C2=A0 \_SB.PCI0.GPPA.ACP=C2=A0 in DSD=
T that would let
> the
> =C2=A0 kernel toggle slave chip power. Is there an SMU command available =
via
> =C2=A0 =C2=A0amd_pmc=C2=A0 that would force a re-power of the ACP island?=
 Or is this a BIOS
> =C2=A0 deficiency on this specific HN7306EAC firmware?
>=20
> =C2=A0 ## Workaround currently used
>=20
> =C2=A0 =C2=A0suspend=C2=A0 is disabled in GNOME.=C2=A0 hibernate=C2=A0 (S=
4) works because it goes
> through
> =C2=A0 a full cold-boot path.
>=20
> =C2=A0 ## Asks
>=20
> =C2=A0 1. Is there a known software path to recover SoundWire peripherals=
 after
> =C2=A0 ACP power-gate that I missed?
> =C2=A0 2. If not =E2=80=94 would AMD consider adding either a full ACP is=
land re-power
> =C2=A0 sequence in=C2=A0 snd_acp70_resume()=C2=A0 or a peripheral-reset h=
ook that
> =C2=A0 slave drivers can call from their resume path?
> =C2=A0 3. Should ASUS BIOS be updated to either advertise=C2=A0 _RST=C2=
=A0 for SDW nodes
> =C2=A0 or prevent SMU from power-gating ACP during s0i3 when SDW is activ=
e?
> =C2=A0 (Happy to file with ASUS Linux team if you can confirm direction.)
>=20
> =C2=A0 I have full DSDT/SSDT decode, complete dmesg traces, and a reprodu=
cer
> =C2=A0 environment if more data is helpful. Source tree with all backport=
s at
> =C2=A0 =C2=A0https://github.com/...=C2=A0 (will set up on request).
>=20
> =C2=A0 Tested on=C2=A0 7.1.0-rc3=C2=A0 + backports above. Confirmed same =
failure on stock
> =C2=A0 =C2=A07.1.0-070100rc3-generic=C2=A0 from kernel.ubuntu.com/mainlin=
e/v7.1-rc3/ .
>=20
> =C2=A0 Thanks,
> =C2=A0 Andrey Golovko

>         Device (SDWC)
>         {
>             Name (_ADR, 0x05)  // _ADR: Address
>             Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device=
 Properties for _DSD */,=20
>                 Package (0x03)
>                 {
>                     Package (0x02)
>                     {
>                         "mipi-sdw-sw-interface-revision",=20
>                         0x00010000
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-manager-list",=20
>                         0x03
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "amd-sdw-aggregation-master-id",=20
>                         0xFFFF
>                     }
>                 },=20
>=20
>                 ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierar=
chical Data Extension */,=20
>                 Package (0x02)
>                 {
>                     Package (0x02)
>                     {
>                         "mipi-sdw-link-0-subproperties",=20
>                         "SWM0"
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-link-1-subproperties",=20
>                         "SWM1"
>                     }
>                 }
>             })
>             Name (SWM0, Package (0x02)
>             {
>                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device=
 Properties for _DSD */,=20
>                 Package (0x0E)
>                 {
>                     Package (0x02)
>                     {
>=20
> --- SWM1 properties (active link with RT721 + 2=C3=97 TAS2783) ---
>             Name (SWM1, Package (0x02)
>             {
>                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device=
 Properties for _DSD */,=20
>                 Package (0x0E)
>                 {
>                     Package (0x02)
>                     {
>                         "mipi-sdw-sw-interface-revision",=20
>                         0x00010000
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-clock-stop-mode0-supported",=20
>                         One
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-clock-stop-mode1-supported",=20
>                         Zero
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-max-clock-frequency",=20
>                         0x00B71B00
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-supported-clock-scales",=20
>                         Zero
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-default-frame-rate",=20
>                         0xBB80
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-default-frame-row-size",=20
>                         0x32
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-default-frame-col-size",=20
>                         0x0A
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-dynamic-frame-shape",=20
>                         Zero
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "mipi-sdw-command-error-threshold",=20
>                         Zero
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "amd-sdw-enable",=20
>                         One
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "amd-sdw-wakeup-enable",=20
>                         One
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "amd-sdw-power-mode",=20
>                         0x02
>                     },=20
>=20
>                     Package (0x02)
>                     {
>                         "amd-sdw-multi-lane-enable",=20
>                         One
>                     }
>                 }
>             })

> # System info
>=20
> ## DMI
> ASUS
> ProArt PX13 HN7306EAC
> ProArt PX13
> BIOS: American Megatrends International, LLC. HN7306EAC.307 01/27/2026
>=20
> ## CPU
> model name	: AMD RYZEN AI MAX+ 395 w/ Radeon 8060S
>=20
> ## Kernel
> Linux asus-px 7.1.0-rc3-px13fix #2 SMP PREEMPT_DYNAMIC Thu May 14 20:38:5=
7 MSK 2026 x86_64 GNU/Linux
>=20
> ## ACP PCI
> c4:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] =
Audio Coprocessor [1022:15e2] (rev 70)
> rev: 0x0x70
> driver: snd_pci_ps
>=20
> ## SoundWire devices
> sdw-master-0-0
> sdw-master-0-1
> sdw:0:1:0102:0000:01:8
> sdw:0:1:0102:0000:01:b
> sdw:0:1:025d:0721:01

> # Trace of one failing s2idle cycle (captured 2026-05-22)
>=20
> ## PM events
> May 22 15:10:43 asus-px kernel: PM: suspend entry (s2idle)
> May 22 15:11:05 asus-px kernel: Freezing user space processes
> May 22 15:11:05 asus-px kernel: Freezing user space processes completed (=
elapsed 0.001 seconds)
> May 22 15:11:05 asus-px kernel: Freezing remaining freezable tasks
> May 22 15:11:05 asus-px kernel: Freezing remaining freezable tasks comple=
ted (elapsed 0.000 seconds)
> May 22 15:11:05 asus-px kernel: printk: Suspending console(s) (use no_con=
sole_suspend to debug)
> May 22 15:11:05 asus-px kernel: ACPI: EC: interrupt blocked
> May 22 15:11:05 asus-px kernel: ACPI: EC: interrupt unblocked
> May 22 15:11:05 asus-px kernel: snd_pci_ps 0000:c4:00.5: AMD-Vi: Event lo=
gged [IO_PAGE_FAULT domain=3D0x0018 address=3D0xfffffffffffffffc flags=3D0x=
0030]
> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:8: PM:=
 dpm_run_callback(): acpi_subsys_resume returns -110
> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:8: PM:=
 failed to resume: error -110
> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:b: PM:=
 dpm_run_callback(): acpi_subsys_resume returns -110
> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:b: PM:=
 failed to resume: error -110
> May 22 15:11:05 asus-px kernel: PM: suspend exit
>=20
> ## Steady-state symptoms after resume (first 20 lines)
> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: SCP_ad=
drpage ignored for Slave 1
> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: trf on Slave 1 =
failed:-5 write addr 8089 count 0
> May 22 15:11:05 asus-px kernel: amd_sdw amd_sdw: ASoC: PRE_PMD: tas2783-2=
 FU21 event failed: -5
> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: SCP_ad=
drpage ignored for Slave 1
> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: trf on Slave 1 =
failed:-5 write addr 8109 count 0
> May 22 15:11:05 asus-px kernel: amd_sdw amd_sdw: ASoC: PRE_PMD: tas2783-2=
 FU23 event failed: -5
> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: SCP_ad=
drpage ignored for Slave 2
> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: trf on Slave 2 =
failed:-5 write addr 8089 count 0
> May 22 15:11:05 asus-px kernel: amd_sdw amd_sdw: ASoC: PRE_PMD: tas2783-1=
 FU21 event failed: -5
> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: SCP_ad=
drpage ignored for Slave 2
> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: trf on Slave 2 =
failed:-5 write addr 8109 count 0
> May 22 15:11:05 asus-px kernel: amd_sdw amd_sdw: ASoC: PRE_PMD: tas2783-1=
 FU23 event failed: -5
> May 22 15:11:05 asus-px kernel: rt721-sdca sdw:0:1:025d:0721:01: Initiali=
zation not complete, timed out
> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: slave_=
stat:0x1
> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: PING status: 0x1
> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: SDW1 c=
lock stop successful
> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: AMD_SD=
W_DEVICE_STATE:0xc
> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: mclk 2=
4000000 max 12000000 row 50 col 10 frame_rate:48000
> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: AMD_SD=
W_DEVICE_STATE:0x0
> May 22 15:11:05 asus-px kernel: snd_pci_ps 0000:c4:00.5: AMD-Vi: Event lo=
gged [IO_PAGE_FAULT domain=3D0x0018 address=3D0xfffffffffffffffc flags=3D0x=
0030]
> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:8: res=
ume: initialization timed out
> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: slave_=
stat:0x1
> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: PING status: 0x1
> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:8: PM:=
 dpm_run_callback(): acpi_subsys_resume returns -110
> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:8: PM:=
 failed to resume: error -110
>=20
> ## suspend_stats after failure
> last_failed_dev:  sdw:0:1:0102:0000:01:b
> last_failed_step: resume
> (captured 2026-05-22)


--G5ctiBjKCadam6UL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoQU5wACgkQJNaLcl1U
h9D1Awf/ZrduY2Rfo/MG9LkGK8Y7c6joodGJekuh0J5pPsr+dbJ3HHlSXEV7saqq
MkpTRdoWSEVa19iiE5uZ1jcOOQtNmSXqTUTtOqlfYv2EjacizAvLi07n398y7qXW
QSdQoHvAqCG4fSpW1P6lRH8hi9S1NIzD60K1NOyy8bW/vMqLprG6iMZj2o3ZYK00
3tRBR3qxKzecY60wpvP3sRqScY7BiBYWrduX6uIhFftK6LYEQME5xzqW0V1p58SR
sF10tFs8tX96ATaCGSBAzhn4T+dCpfcCPymlCjV57CE5IqZaNyBqXwnzOcD8loM6
R0u6z9SuwP9mjpNRC2w0xpEN3zSc6A==
=Jj9A
-----END PGP SIGNATURE-----

--G5ctiBjKCadam6UL--
