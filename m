Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62983CD5BD0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 15:08:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E667660243;
	Tue, 26 May 2026 17:08:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E667660243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779808119;
	bh=aBYjLvh52aSUw+omcBS/wYXvYbt/nKKLZBl1AxAZI38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uLi5WmvzkiE9wJ/iJGbKopCSsnACqcmYpoZDxDcxnxmaYx8s/vEaEz4Bd+UR/l7/Q
	 33okJWTlgP2IlCu3M7oBPvDyhNvUWKPnNMSwKSw9n8EUs2VAZIW52q0pcJ48NqsPhr
	 wA0TYr2ruECvyVbPaeRUnDHLc8hYHbiEaQMJSUB0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B40BEF80642; Tue, 26 May 2026 17:07:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 82251F80642;
	Tue, 26 May 2026 17:07:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CEF2AF80557; Mon, 25 May 2026 09:54:18 +0200 (CEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F53FF8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 09:54:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F53FF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JG1dxYSg
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-3939d2bd739so72635011fa.0
        for <alsa-devel@alsa-project.org>;
 Mon, 25 May 2026 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779695655; x=1780300455;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNxMH/EEanXxXfO40w9xmKBG/3BeRhAxRg0kaKMO7jY=;
        b=JG1dxYSg6TViSlskD/i+hT6ujh7mO3woNwawRJzyPVQpnT69X1UNRM6nNYN7wle7P/
         X89JQnp6QqicO/EbvIoYoDIaEBvDIIpQU9vaDTVhUWej2hh/IUECqUbHwLp1nJwHf8O5
         VOw14y6ylvdjchAteufSU2DkFi7awUTgs7nu+oqvpZoOoL7dyeKPtpI0Uqmelm9noZUN
         IkNPd4VsZyVVUbK+BoRhSTMuevJLqO+dXi83A4KqIFekSVClTbFwI5YP1nM208alfSFA
         4nCXeo3ZuAFIct5a1+pHTZuqTn6howx/K1x61AEar4tK1wpAkUo2R2dfZH/DYfIvPXzM
         7jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779695655; x=1780300455;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNxMH/EEanXxXfO40w9xmKBG/3BeRhAxRg0kaKMO7jY=;
        b=oL+iBzsehMzUQX47/2RjKbU63czw9e+kwn0RF17+g16tRoleateIxSQYh6i7dGxnsZ
         S6YV05eLym90y4n0cSsEs5m8zoFPlOsp7oZFK1VR3yO4b0QEJqnNfqpB44YKvN1dPagT
         KpA85LM55gSgBOEEV6TGaDbmla9XpJt3H09C5WYPvlzxFle3lPHXIM+cRaGaKv09iUCh
         5eIm8bvLJ2BTmqo5CY0q0+MCfHhX3yn6RcqH3pV4tzc1l4q1qH5sjwd0RVqVY+yxPtbW
         nVhVPHuLrosaoHcy4RUItVV+X1G/elFE5Cvm0ffgxIaf16PyV2g2PgEGUCcdl1ns3V20
         Xj+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HUfq98T4K5VHjxirlmgvsrJu4I+gyPLEqMiY1shVG7+0y405qQvrWBja4ohFNjydweh8YmYZeDAVo@alsa-project.org
X-Gm-Message-State: AOJu0Yzv0YzU/YrD1rzGYBGMpi1wipwhMzud2HQRApbpbHJHaWT58qSz
	tM5qxd9xQ8cIl1pOXBddzjkQXGHPxzHSV1HJw2s71ZUqJQMJHjxZbtCnSSy+ouOo3obsWQ==
X-Gm-Gg: Acq92OG/EuCRSFrbFDf9T8MJajBYJgOjMjRM4F7fHl6ltlD+Cp7tlR5YsyaG31AONaQ
	kTD7Wq23Ux2HNPUm1ytR6qCnGsSthlqRbfuzWM8v19rv1+4RL94vJRzQ/a2UeHG3kHA/oTPPCV6
	2Od6vIMkeXGW09FHzTLKNZr2lcjlchC3TCLdZF6OedFAAYMaQGeNp0FACHPHIz6g1hDFY5hU4GA
	pMYVw+xib7NfJVXzzaPwu7jOn/jpBiD/6UXfo85zC6JFfLUpv0FZs7Ls9EROUyPMtD82D3KhJW6
	0u2f7cMt8TUMgmQgTGCCjzJNERHvE3b0cKh6ADRQgbphdZpicPYuAzg7/TPKs1vQ4LD7+BcUhbI
	j08s2sIheFnDQGayxvCMLJN1ODk9tmc41OVfYbQpuqxKm1Xm0z6Izweow0Ox1faQFWavDguc8Nn
	3Nb3SuipGB94qt/OovXmRlqZo2O5pOUhfkLPzqfuIpkcGb7atnEkQJ2NlbZmg7NvtB
X-Received: by 2002:a05:6512:1116:b0:5aa:b6b:a3f0 with SMTP id
 2adb3069b0e04-5aa323d7d26mr1234913e87.44.1779455245336;
        Fri, 22 May 2026 06:07:25 -0700 (PDT)
Received: from [192.168.1.149] (host-80-73-162-2.rev.as20985.net.
 [80.73.162.2])
        by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cb36bbsm420954e87.6.2026.05.22.06.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 06:07:25 -0700 (PDT)
Message-ID: <c3bf6b9f-a041-48c6-8d38-f168bb93daaf@gmail.com>
Date: Fri, 22 May 2026 16:07:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASoC: amd: ps / soundwire: SDW peripherals unrecoverable
 after s0i3 on Strix Halo (ACP7.0)
To: Mark Brown <broonie@kernel.org>
Cc: Vijendar.Mukunda@amd.com, superm1@kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.de,
 yung-chuan.liao@linux.intel.com, Shenghao Ding <shenghao-ding@ti.com>,
 Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>
References: <7328cdbf-10fb-46a1-a28c-2f7365fd767d@gmail.com>
 <9a017983-c4ce-4abb-a9cf-8e6c2bafac70@sirena.org.uk>
From: Adnrey Golovko <andrey.golovko@gmail.com>
Content-Language: en-US, ru
In-Reply-To: <9a017983-c4ce-4abb-a9cf-8e6c2bafac70@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MailFrom: andrey.golovko@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: W6SHFACMWOUKGUHLON64FQIBTBXT6GVY
X-Message-ID-Hash: W6SHFACMWOUKGUHLON64FQIBTBXT6GVY
X-Mailman-Approved-At: Tue, 26 May 2026 15:07:30 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W6SHFACMWOUKGUHLON64FQIBTBXT6GVY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

   Checked the codec driver path — it does clear hw_init on UNATTACHED
   and re-runs tas_io_init() (which calls request_firmware_nowait) on 
the next
   ATTACHED. Problem is ATTACHED never comes. Bus log:

     amd_sdw_manager.1: SCP_addrpage ignored for Slave 1
     sdw-master-0-1: trf on Slave 1 failed:-5
     sdw-master-0-1: PING status: 0x1

   The peripherals don't ACK any SoundWire command after resume — not 
even SCP
   page addressing, which is pre-firmware. RT721 (SDCA, separate codec 
driver)
   is in the same state. So the codec is willing to re-download fw but the
   chip is not on the wire to begin with.

   No GPIO/_RST in DSDT under SDWC, no FLR on the ACP PCI function. Looks
   board/SMU level rather than codec — but maybe TI knows a SoundWire-side
   recovery sequence that wakes the chip from this state?

On 5/22/26 16:01, Mark Brown wrote:
> On Fri, May 22, 2026 at 03:54:06PM +0300, Adnrey Golovko wrote:
>>    SoundWire slaves lose firmware after s2idle on AMD ACP7.0 (Strix Halo) —
>>    TAS2783 cannot resume
> Adding the TI people (not deleting context for their benefit), my first
> thought here is that this is the CODEC driver not redownloading firmware
> after power loss.
>
>>    ## Summary
>>
>>    On ASUS ProArt PX13 HN7306EAC (AMD Ryzen AI MAX+ 395, Strix Halo) with
>> ACP  PCI
>>    rev  0x70  (ACP7.0), entering  s2idle  for as little as 3.8 seconds causes
>> the
>>    Realtek RT721 SDCA and TI TAS2783 SoundWire peripherals to enter an
>>    unrecoverable state. After resume,  Peripheral status = unattached  and
>> the
>>    TAS2783 driver reports  error playback without fw download . No
>> software-only
>>    recovery is possible — driver re-bind, PCI hot remove+rescan, and module
>> reload
>>    all fail. Only a full machine reboot restores audio.
>>
>>    Filed because all available fixes in current upstream/-next are already
>> applied
>>    and do not address the root cause.
>>
>>    ## Hardware
>>
>>      DMI:               ASUS HN7306EAC, BIOS HN7306EAC.307 (2026-01-27)
>>      CPU:               AMD Ryzen AI MAX+ 395 w/ Radeon 8060S (Strix Halo)
>>      ACP PCI ID:        1022:15e2 rev 0x70  (sysfs: 0000:c4:00.5)
>>      ACP driver:        snd_pci_ps
>>      SoundWire link 1:  Realtek RT721 SDCA  (sdw:0:1:025d:0721:01)
>>                         2× TI TAS2783        (sdw:0:1:0102:0000:01:8,
>> ...:01:b)
>>      TAS2783 firmware:  /lib/firmware/1714-1-{8,B}.bin  (extracted from
>> Windows
>>                         driver — ASUS does not ship to linux-firmware as of
>> 2026-
>>    05)
>>      ACPI path:         \_SB.PCI0.GPPA.ACP.SDWC.SWM1
>>
>>    ## Kernel
>>
>>      Linux 7.1.0-rc3 + 3 backports:
>>        c368dd5cbd61 soundwire: don't program SDW_SCP_BUSCLOCK_SCALE on a
>> unattached
>>    Peripheral
>>        9a0afdd19a01 soundwire: stream: sdw_stream_remove_slave(): Check
>> stream is
>>    valid
>>        e09bbf11b53f HID: input: delete hid_battery on disconnect (unrelated)
>>
>>     git log v7.1-rc3..v7.1-rc4 -- sound/soc/amd drivers/soundwire/ is empty.
>>     broonie/sound#for-next  adds  sound/soc/amd/acp7x/  (ACP7.D/E/F, rev
>> 0x7D-0x7F)
>>    —
>>    not applicable to ACP7.0.
>>
>>    ## DSDT / ACPI properties
>>
>>    SWM1 (active link) has:
>>
>>      amd-sdw-power-mode                    = 0x02  (AMD_SDW_POWER_OFF_MODE)
>>      amd-sdw-enable                        = 1
>>      amd-sdw-wakeup-enable                 = 1
>>      mipi-sdw-clock-stop-mode0-supported   = 1
>>      mipi-sdw-clock-stop-mode1-supported   = 0
>>
>>    No  _PS0 / _PS3 / _PR0 / _PR3  methods for \_SB.PCI0.GPPA.ACP.SDWC  or its
>>     SWM0 / SWM1  children, no  _RST  method.
>>
>>    With  power_mode_mask = AMD_SDW_POWER_OFF_MODE ,
>>    drivers/soundwire/amd_manager.c
>>    correctly takes the full deinit/init path: amd_deinit_sdw_manager()  on
>>    suspend,
>>     sdw_clear_slave_status(SDW_UNATTACH_REQUEST_MASTER_RESET) +
>>    amd_sdw_clk_init_ctrl +
>>    amd_init_sdw_manager + amd_enable_sdw_manager + amd_sdw_set_frameshape  on
>>    resume.
>>     snd_acp70_resume()  in  sound/soc/amd/ps/ps-common.c  correctly takes the
>> slow
>>    path ( acp_hw_init  + pad-keeper restore) because  sdw_en_stat  is cleared
>>    during
>>    suspend by  amd_deinit_sdw_manager . So the driver-level resume code paths
>> are
>>    exercised correctly. The failure is at a lower level.
>>
>>    ## Reproducer
>>
>>      # Cold boot, audio works.
>>      $ aplay -l | grep amdsoundwire
>>      card 1: amdsoundwire ... SDW1-PIN1-PLAYBACK-SmartAmp multicodec-2 []
>>      $ speaker-test -D plughw:1,2 -c2  # → works
>>
>>      # One s2idle cycle:
>>      $ systemctl suspend
>>      # (3.8 sec residency in s0i3, /sys/kernel/debug/amd_pmc/s0ix_stats
>> confirms)
>>      # (woken by i2c-ASCF1A03:00 touchpad wake event, but issue reproduces
>> with
>>      #  any wake source including RTC alarm)
>>
>>      # After resume:
>>      $ speaker-test -D plughw:1,2 -c2
>>      Setting of hwparams failed: Invalid argument
>>
>>    ## Evidence — kernel trace
>>
>>     /sys/power/suspend_stats :
>>
>>      last_failed_dev    = sdw:0:1:0102:0000:01:b
>>      last_failed_step   = resume
>>      last_hw_sleep      = 3825561   (µs)
>>
>>     journalctl -k  around suspend/resume:
>>
>>      PM: suspend entry (s2idle)
>>      Freezing user space processes completed
>>      printk: Suspending console(s)
>>      ACPI: EC: interrupt blocked
>>      ACPI: EC: interrupt unblocked
>>      slave-tas2783 sdw:0:1:0102:0000:01:8: PM: dpm_run_callback():
>>    acpi_subsys_resume returns -110
>>      slave-tas2783 sdw:0:1:0102:0000:01:8: PM: failed to resume: error -110
>>      slave-tas2783 sdw:0:1:0102:0000:01:b: PM: dpm_run_callback():
>>    acpi_subsys_resume returns -110
>>      slave-tas2783 sdw:0:1:0102:0000:01:b: PM: failed to resume: error -110
>>      PM: suspend exit
>>      snd_pci_ps 0000:c4:00.5: AMD-Vi: Event logged [IO_PAGE_FAULT
>>         domain=0x0018 address=0xfffffffffffffffc flags=0x0030]
>>
>>    The  0xfffffffffffffffc  IOMMU fault address is the sentinel returned when
>> PCI
>>    config reads return  0xff..ff , i.e., ACP is in an inaccessible state at
>> the
>>    moment of DMA.
>>
>>    Detailed resume-path trace (excerpts):
>>
>>      amd_sdw_manager amd_sdw_manager.1: SCP_addrpage ignored for Slave 1
>>      soundwire sdw-master-0-1: trf on Slave 1 failed:-5 write addr 8089 count
>> 0
>>      amd_sdw amd_sdw: ASoC: PRE_PMD: tas2783-2 FU21 event failed: -5
>>      amd_sdw_manager amd_sdw_manager.1: SCP_addrpage ignored for Slave 2
>>      soundwire sdw-master-0-1: trf on Slave 2 failed:-5 write addr 8089 count
>> 0
>>      rt721-sdca sdw:0:1:025d:0721:01: Initialization not complete, timed out
>>      amd_sdw_manager amd_sdw_manager.1: slave_stat:0x1
>>      soundwire sdw-master-0-1: PING status: 0x1
>>      amd_sdw_manager amd_sdw_manager.1: SDW1 clock stop successful
>>      amd_sdw_manager amd_sdw_manager.1: AMD_SDW_DEVICE_STATE:0xc
>>      amd_sdw_manager amd_sdw_manager.1: mclk 24000000 max 12000000 row 50 col
>> 10
>>    frame_rate:48000
>>      amd_sdw_manager amd_sdw_manager.1: AMD_SDW_DEVICE_STATE:0x0
>>      snd_pci_ps 0000:c4:00.5: AMD-Vi: Event logged [IO_PAGE_FAULT ...
>>    0xfffffffffffffffc ...]
>>      slave-tas2783 sdw:0:1:0102:0000:01:8: resume: initialization timed out
>>      soundwire sdw-master-0-1: PING status: 0x1
>>
>>    Note  PING status: 0x1  — the SoundWire PING-frame status returns the same
>> low
>>    value before and after the manager attempts to re-enumerate. Peripherals
>> are
>>    not responding on the wire even though clock is running.
>>
>>    Steady-state symptoms after the resume path completes (slave drivers
>> loaded,
>>    codec link tries to prepare PCM):
>>
>>      slave-tas2783 sdw:0:1:0102:0000:01:8: Peripheral status = unattached
>>      slave-tas2783 sdw:0:1:0102:0000:01:8: error playback without fw download
>>      slave-tas2783 sdw:0:1:0102:0000:01:8: ASoC error (-22): at
>>    snd_soc_dai_hw_params()
>>      soundwire sdw-master-0-1: Program transport params failed: -61
>>      amd_sdw_manager amd_sdw_manager.1: command is ignored for Slave 2
>>
>>     command is ignored for Slave N  from  amd_sdw_fill_msg_resp() indicates
>> the
>>    SoundWire bus sees no ACK for any peripheral command — the peripherals are
>> not
>>    responding on the wire.
>>
>>    The  error playback without fw download  from  tas2783-sdw.c  is the
>> giveaway —
>>    the TAS2783 driver explicitly knows its firmware blob is no longer loaded.
>>    During cold boot the firmware is downloaded after slave attach; after
>> s0i3, the
>>    slave never reaches attached state, so the firmware download path is never
>>    re-entered.
>>
>>    ## Recovery attempts — ALL FAIL
>>
>>    Attempt                                │Result
>> ───────────────────────────────────────┼────────────────────────────────────────
>>    Stop PipeWire,  rmmod snd_soc_tas2783_…│ EBUSY  — kernel ALSA-SOC retry
>> loop ho…
>>     echo 0000:c4:00.5 > /sys/bus/pci/driv…│Probe replays cleanly ( probe
>> complete …
>>    PCIe Function-Level Reset ( /sys/.../r…│File does not exist — ACP does not
>> adve…
>>     echo 1 > /sys/bus/pci/devices/0000:c4…│Same as unbind+bind — slaves
>> enumerate …
>>    pm-utils system-sleep hook running the…│Same
>>    BIOS update 305 → 307                  │No change
>>
>>    This is consistent with the underlying SMU behaviour on Strix Halo s0i3:
>>    the ACP power island is power-gated, peripherals connected to the
>> SoundWire
>>    pads lose state including firmware. There is no software path from the OS
>>    to re-power the slave chips short of a full machine reboot.
>>
>>    ## What I think the bug is
>>
>>    Either (a) the AMD SMU should hold the ACP power island powered during
>> s0i3
>>    when SoundWire link is active and peripherals require firmware (BIOS or
>> SMU
>>    firmware change), or (b) the kernel needs an explicit recovery path that:
>>
>>    1. Detects in  snd_acp70_resume()  that ACP was actually power-gated (e.g.
>>    by reading a sentinel register that survives only across non-power-gated
>>    suspend).
>>    2. If power-gated, performs a full peripheral-chip reset (some
>> platform-specific
>>    GPIO toggle? secondary bus reset on the ACP's PCIe link?) before the SDW
>>    manager attempts to re-enumerate.
>>    3. Triggers each slave driver's firmware-download path on resume.
>>
>>    I cannot find any GPIO under  \_SB.PCI0.GPPA.ACP  in DSDT that would let
>> the
>>    kernel toggle slave chip power. Is there an SMU command available via
>>     amd_pmc  that would force a re-power of the ACP island? Or is this a BIOS
>>    deficiency on this specific HN7306EAC firmware?
>>
>>    ## Workaround currently used
>>
>>     suspend  is disabled in GNOME.  hibernate  (S4) works because it goes
>> through
>>    a full cold-boot path.
>>
>>    ## Asks
>>
>>    1. Is there a known software path to recover SoundWire peripherals after
>>    ACP power-gate that I missed?
>>    2. If not — would AMD consider adding either a full ACP island re-power
>>    sequence in  snd_acp70_resume()  or a peripheral-reset hook that
>>    slave drivers can call from their resume path?
>>    3. Should ASUS BIOS be updated to either advertise  _RST  for SDW nodes
>>    or prevent SMU from power-gating ACP during s0i3 when SDW is active?
>>    (Happy to file with ASUS Linux team if you can confirm direction.)
>>
>>    I have full DSDT/SSDT decode, complete dmesg traces, and a reproducer
>>    environment if more data is helpful. Source tree with all backports at
>>     https://github.com/...  (will set up on request).
>>
>>    Tested on  7.1.0-rc3  + backports above. Confirmed same failure on stock
>>     7.1.0-070100rc3-generic  from kernel.ubuntu.com/mainline/v7.1-rc3/ .
>>
>>    Thanks,
>>    Andrey Golovko
>>          Device (SDWC)
>>          {
>>              Name (_ADR, 0x05)  // _ADR: Address
>>              Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
>>              {
>>                  ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
>>                  Package (0x03)
>>                  {
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-sw-interface-revision",
>>                          0x00010000
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-manager-list",
>>                          0x03
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "amd-sdw-aggregation-master-id",
>>                          0xFFFF
>>                      }
>>                  },
>>
>>                  ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */,
>>                  Package (0x02)
>>                  {
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-link-0-subproperties",
>>                          "SWM0"
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-link-1-subproperties",
>>                          "SWM1"
>>                      }
>>                  }
>>              })
>>              Name (SWM0, Package (0x02)
>>              {
>>                  ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
>>                  Package (0x0E)
>>                  {
>>                      Package (0x02)
>>                      {
>>
>> --- SWM1 properties (active link with RT721 + 2× TAS2783) ---
>>              Name (SWM1, Package (0x02)
>>              {
>>                  ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
>>                  Package (0x0E)
>>                  {
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-sw-interface-revision",
>>                          0x00010000
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-clock-stop-mode0-supported",
>>                          One
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-clock-stop-mode1-supported",
>>                          Zero
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-max-clock-frequency",
>>                          0x00B71B00
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-supported-clock-scales",
>>                          Zero
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-default-frame-rate",
>>                          0xBB80
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-default-frame-row-size",
>>                          0x32
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-default-frame-col-size",
>>                          0x0A
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-dynamic-frame-shape",
>>                          Zero
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "mipi-sdw-command-error-threshold",
>>                          Zero
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "amd-sdw-enable",
>>                          One
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "amd-sdw-wakeup-enable",
>>                          One
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "amd-sdw-power-mode",
>>                          0x02
>>                      },
>>
>>                      Package (0x02)
>>                      {
>>                          "amd-sdw-multi-lane-enable",
>>                          One
>>                      }
>>                  }
>>              })
>> # System info
>>
>> ## DMI
>> ASUS
>> ProArt PX13 HN7306EAC
>> ProArt PX13
>> BIOS: American Megatrends International, LLC. HN7306EAC.307 01/27/2026
>>
>> ## CPU
>> model name	: AMD RYZEN AI MAX+ 395 w/ Radeon 8060S
>>
>> ## Kernel
>> Linux asus-px 7.1.0-rc3-px13fix #2 SMP PREEMPT_DYNAMIC Thu May 14 20:38:57 MSK 2026 x86_64 GNU/Linux
>>
>> ## ACP PCI
>> c4:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] Audio Coprocessor [1022:15e2] (rev 70)
>> rev: 0x0x70
>> driver: snd_pci_ps
>>
>> ## SoundWire devices
>> sdw-master-0-0
>> sdw-master-0-1
>> sdw:0:1:0102:0000:01:8
>> sdw:0:1:0102:0000:01:b
>> sdw:0:1:025d:0721:01
>> # Trace of one failing s2idle cycle (captured 2026-05-22)
>>
>> ## PM events
>> May 22 15:10:43 asus-px kernel: PM: suspend entry (s2idle)
>> May 22 15:11:05 asus-px kernel: Freezing user space processes
>> May 22 15:11:05 asus-px kernel: Freezing user space processes completed (elapsed 0.001 seconds)
>> May 22 15:11:05 asus-px kernel: Freezing remaining freezable tasks
>> May 22 15:11:05 asus-px kernel: Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
>> May 22 15:11:05 asus-px kernel: printk: Suspending console(s) (use no_console_suspend to debug)
>> May 22 15:11:05 asus-px kernel: ACPI: EC: interrupt blocked
>> May 22 15:11:05 asus-px kernel: ACPI: EC: interrupt unblocked
>> May 22 15:11:05 asus-px kernel: snd_pci_ps 0000:c4:00.5: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0018 address=0xfffffffffffffffc flags=0x0030]
>> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:8: PM: dpm_run_callback(): acpi_subsys_resume returns -110
>> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:8: PM: failed to resume: error -110
>> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:b: PM: dpm_run_callback(): acpi_subsys_resume returns -110
>> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:b: PM: failed to resume: error -110
>> May 22 15:11:05 asus-px kernel: PM: suspend exit
>>
>> ## Steady-state symptoms after resume (first 20 lines)
>> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: SCP_addrpage ignored for Slave 1
>> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: trf on Slave 1 failed:-5 write addr 8089 count 0
>> May 22 15:11:05 asus-px kernel: amd_sdw amd_sdw: ASoC: PRE_PMD: tas2783-2 FU21 event failed: -5
>> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: SCP_addrpage ignored for Slave 1
>> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: trf on Slave 1 failed:-5 write addr 8109 count 0
>> May 22 15:11:05 asus-px kernel: amd_sdw amd_sdw: ASoC: PRE_PMD: tas2783-2 FU23 event failed: -5
>> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: SCP_addrpage ignored for Slave 2
>> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: trf on Slave 2 failed:-5 write addr 8089 count 0
>> May 22 15:11:05 asus-px kernel: amd_sdw amd_sdw: ASoC: PRE_PMD: tas2783-1 FU21 event failed: -5
>> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: SCP_addrpage ignored for Slave 2
>> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: trf on Slave 2 failed:-5 write addr 8109 count 0
>> May 22 15:11:05 asus-px kernel: amd_sdw amd_sdw: ASoC: PRE_PMD: tas2783-1 FU23 event failed: -5
>> May 22 15:11:05 asus-px kernel: rt721-sdca sdw:0:1:025d:0721:01: Initialization not complete, timed out
>> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: slave_stat:0x1
>> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: PING status: 0x1
>> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: SDW1 clock stop successful
>> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: AMD_SDW_DEVICE_STATE:0xc
>> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: mclk 24000000 max 12000000 row 50 col 10 frame_rate:48000
>> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: AMD_SDW_DEVICE_STATE:0x0
>> May 22 15:11:05 asus-px kernel: snd_pci_ps 0000:c4:00.5: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0018 address=0xfffffffffffffffc flags=0x0030]
>> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:8: resume: initialization timed out
>> May 22 15:11:05 asus-px kernel: amd_sdw_manager amd_sdw_manager.1: slave_stat:0x1
>> May 22 15:11:05 asus-px kernel: soundwire sdw-master-0-1: PING status: 0x1
>> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:8: PM: dpm_run_callback(): acpi_subsys_resume returns -110
>> May 22 15:11:05 asus-px kernel: slave-tas2783 sdw:0:1:0102:0000:01:8: PM: failed to resume: error -110
>>
>> ## suspend_stats after failure
>> last_failed_dev:  sdw:0:1:0102:0000:01:b
>> last_failed_step: resume
>> (captured 2026-05-22)
