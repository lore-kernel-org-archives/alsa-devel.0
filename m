From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: ES8316
Date: Wed, 13 Dec 2017 15:53:00 +0200
Message-ID: <Mahogany-0.68.0-8070-20171213-155300.01@nerijus.sat.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bluegene.sat.lt (bluegene.sat.lt [88.119.145.12])
 by alsa0.perex.cz (Postfix) with SMTP id D444A266B67
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 14:54:02 +0100 (CET)
Content-Disposition: INLINE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Onda obook 20 plus tablet, Fedora 27, kernel 4.13.16-302.fc27.x86_64:

[    8.910172] bytcht_es8316 bytcht_es8316: ASoC: CODEC DAI ES8316 HiFi not registered
[    8.910306] bytcht_es8316 bytcht_es8316: snd_soc_register_card failed -517

kernel 4.14.3-300.fc27.x86_64:

[    8.561159] rt5645 i2c-10EC5645:00: Device with ID register 0xffff8d85 is not rt5645 or rt5650
[    9.344562] cht-bsw-rt5645 cht-bsw-rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
[    9.344695] cht-bsw-rt5645 cht-bsw-rt5645: snd_soc_register_card failed -517

On both kernels snd_soc_sst_byt_cht_es8316 and snd_soc_es8316
modules are loaded automatically.
How to make audio work?

dmesg from Android 5.1 kernel 3.14.37-x86_64:

<3>[    3.900404] snd_intel_sst: sst_platform_get_resources_edk
<3>[    3.900442] snd_intel_sst: LPE base: 0xd1600000 size:0x200000
<3>[    3.900452] snd_intel_sst: IRAM base: 0xd16c0000
<3>[    3.900461] snd_intel_sst: DRAM base: 0xd1700000
<3>[    3.900535] snd_intel_sst: SHIM base: 0xd1740000
<3>[    3.900547] snd_intel_sst: Mailbox base: 0xd1744000
<3>[    3.900720] snd_intel_sst: DDR base: 0x20000000
<6>[    3.900720] snd_intel_sst: Enter: sst_audio_platform_init
<6>[    3.900723] snd_intel_sst: audio:set_cht_platform_config
<6>[    3.900958] snd_soc_sst_platform: sst_platform_probe is deferred
<3>[    3.900977] snd_intel_sst: board_name:Cherry Trail CR
<6>[    3.900979] snd_intel_sst: Registering machine device cht_es8316
<3>[    3.901147] snd_intel_sst: Requesting FW fw_sst_22a8.bin now...
<6>[    3.986899] snd_soc_sst_platform: sst_platform_probe is deferred
<6>[    4.260819] snd_soc_sst_platform: sst_platform_probe is deferred
<6>[    4.262978] snd_soc_sst_platform: sst_platform_probe is deferred
<6>[    4.696961] snd_soc_sst_platform: sst_platform_probe is deferred
<6>[    7.361346] snd_soc_sst_platform: sst_platform_probe is deferred
<6>[    7.373893] snd_soc_sst_platform: sst_platform_probe is deferred
<3>[    7.374140] cht_es8316 cht_es8316: ASoC: CPU DAI Headset-cpu-dai not registered
<3>[    7.382393] snd_soc_register_card failed -517
<6>[    7.387358] platform cht_es8316: Driver cht_es8316 requests probe deferral
<6>[    7.387542] Cherrytrail Machine Driver cht_es8316 registerd
<7>[   10.604513] ---es8316_probe--start--
<4>[   10.695451] snd-soc-dummy snd-soc-dummy: ASoC: Failed to create platform debugfs directory
<3>[   10.706037] chuangang:********************************* codec->name = es8316.1-0011
<6>[   10.739210] cht_es8316 cht_es8316: snd-soc-dummy-dai <-> Headset-cpu-dai mapping ok
<6>[   10.739332] cht_es8316 cht_es8316: snd-soc-dummy-dai <-> Deepbuffer-cpu-dai mapping ok
<6>[   10.739410] compress asoc: snd-soc-dummy-dai <-> Compress-cpu-dai mapping ok
<6>[   10.739530] cht_es8316 cht_es8316: snd-soc-dummy-dai <-> Voip-cpu-dai mapping ok
<6>[   10.739656] cht_es8316 cht_es8316: snd-soc-dummy-dai <-> Lowlatency-cpu-dai mapping ok
<6>[   10.740017] cht_es8316 cht_es8316: snd-soc-dummy-dai <-> Probe-cpu-dai mapping ok
<6>[   10.740253] cht_es8316 cht_es8316: ES8316 HiFi <-> ssp2-port mapping ok
<6>[   10.740321] cht_es8316 cht_es8316: snd-soc-dummy-dai <-> snd-soc-dummy-dai mapping ok
<6>[   10.740388] cht_es8316 cht_es8316: snd-soc-dummy-dai <-> snd-soc-dummy-dai mapping ok
<3>[   10.740503] cht_es8316 cht_es8316: ASoC: Failed to add Headphone Switch: -16
<7>[   10.748616] es8316_set_dai_fmt----649, fmt[4305]
<7>[   10.750744] es8316 in slave mode
<7>[   10.763965] es8316 1-0011: es8316_set_bias_level standby
<6>[   10.792289] input: cherrytrailaud Headset Jack as /devices/platform/cht_es8316/sound/card1/input10
<6>[   10.795340] snd_cht_mc_probe successful
<6>[   11.568221] ES8316_GPIO_FLAG:26

Regards,
Nerijus
