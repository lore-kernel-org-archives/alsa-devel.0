From: Luka Karinja <lk@bazdara.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Wed, 8 Jul 2015 22:57:29 +0200
Message-ID: <559D8EB9.60007@bazdara.com>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
 <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org> <559A90CE.2030105@gmail.com>
 <20150707031950.GD11002@localhost> <559BDB7F.9010105@gmail.com>
 <20150707170821.GL11002@localhost> <559C3F4A.5030307@gmail.com>
 <20150708033604.GM11002@localhost>
 <20150708102308.91b7258f243e354b1365a47e@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.bazdara.com (server.bazdara.com [84.255.206.229])
 by alsa0.perex.cz (Postfix) with ESMTP id D258E265A81
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 22:57:30 +0200 (CEST)
In-Reply-To: <20150708102308.91b7258f243e354b1365a47e@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@ao2.it>, Vinod Koul <vinod.koul@intel.com>
Cc: Tyler Yeomans <tyeo098@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

Hello guys. I have been trying to get sound on my Asus T100TAF with rt5642.
I have been following your various threads but i'm not succesfull with 
getting sound working.
Hoppfully you can give me a hand

The changes i made to the kernel:
----------------
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c 
b/sound/soc/intel/atom/sst/sst_acpi.c
index bb19b58..b45cf3e 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -118,7 +118,7 @@ static const struct sst_res_info byt_rvp_res_info = {
      .mbox_size = 0x1000,
      .acpi_lpe_res_index = 0,
      .acpi_ddr_index = 2,
-    .acpi_ipc_irq_index = 5,
+    .acpi_ipc_irq_index = 0,
  };

  static struct sst_platform_info byt_rvp_platform_data = {
@@ -345,6 +345,8 @@ static int sst_acpi_remove(struct platform_device *pdev)
  static struct sst_machines sst_acpi_bytcr[] = {
      {"10EC5640", "T100", "bytt100_rt5640", NULL, "intel/fw_sst_0f28.bin",
                          &byt_rvp_platform_data },
+    {"10EC5642", "T100", "bytt100_rt5640", NULL, 
"intel/fw_sst_0f28_ssp0.bin",
+                        &byt_rvp_platform_data },
      {},
  };

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c 
b/sound/soc/intel/boards/bytcr_rt5640.c
index 7f55d59..90793f4 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -171,7 +171,7 @@ static struct snd_soc_dai_link byt_dailink[] = {
          .platform_name = "sst-mfld-platform",
          .no_pcm = 1,
          .codec_dai_name = "rt5640-aif1",
-        .codec_name = "i2c-10EC5640:00",
+        .codec_name = "i2c-10EC5642:00",
          .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
                          | SND_SOC_DAIFMT_CBS_CFS,
          .be_hw_params_fixup = byt_codec_fixup,


Interupts while playing audio
----------------
pinkflozd@bazdara-t100taf:~$ cat /proc/interrupts | grep sst
    6:          0          0          0          0   IO-APIC 
28-fasteoi   intel_sst_driver


DSP routing
from: 
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/094080.html

Dmesg
----------------
[    6.562793] intel_sst_acpi 80860F28:00: LPE base: 0x50a00000 
size:0x200000
[    6.562803] intel_sst_acpi 80860F28:00: IRAM base: 0x50ac0000
[    6.562831] intel_sst_acpi 80860F28:00: DRAM base: 0x50b00000
[    6.562845] intel_sst_acpi 80860F28:00: SHIM base: 0x50b40000
[    6.562866] intel_sst_acpi 80860F28:00: Mailbox base: 0x50b44000
[    6.562877] intel_sst_acpi 80860F28:00: DDR base: 0x20000000
[    6.568009] intel_sst_acpi 80860F28:00: Got drv data max stream 25
[    6.569148] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    6.570822] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    6.575327] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    6.589434] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    6.602879] i2c i2c-10: Added multiplexed i2c bus 13
[    6.615651] Adding 1049596k swap on /dev/mmcblk0p4.  Priority:-1 
extents:1 across:1049596k SSFS
[    6.920871] asus_wmi: ASUS WMI generic driver loaded
[    6.990835] genirq: Flags mismatch irq 8. 00000083 (volume_down) vs. 
00000000 (rtc0)
[    6.990861] gpio-keys gpio-keys.0.auto: Unable to claim irq 8; error -16
[    6.990955] gpio-keys: probe of gpio-keys.0.auto failed with error -16
[    6.991366] input: gpio-keys as 
/devices/platform/gpio-keys.1.auto/input/input6
[    7.052474] asus_wmi: Initialization: 0x1
[    7.052596] asus_wmi: BIOS WMI version: 7.9
[    7.052686] asus_wmi: SFUN value: 0x37
[    7.056197] input: Asus WMI hotkeys as 
/devices/platform/asus-nb-wmi/input/input7
[    7.071732] asus_wmi: Number of fans: 1
[    7.089951] intel_rapl: Found RAPL domain package
[    7.089971] intel_rapl: Found RAPL domain core
[    7.151622] bytt100_rt5640 bytt100_rt5640: snd-soc-dummy-dai <-> 
media-cpu-dai mapping ok
[    7.151673] compress asoc: snd-soc-dummy-dai <-> compress-cpu-dai 
mapping ok
[    7.151725] bytt100_rt5640 bytt100_rt5640: rt5640-aif1 <-> ssp2-port 
mapping ok
[    7.151822] bytt100_rt5640 bytt100_rt5640: Connecting non-supply 
widget to supply widget is not supported (Int Mic -> LDO2)
[    7.151830] bytt100_rt5640 bytt100_rt5640: ASoC: no dapm match for 
Int Mic --> (null) --> LDO2
[    7.151836] bytt100_rt5640 bytt100_rt5640: ASoC: Failed to add route 
Int Mic -> direct -> LDO2
[    7.242205] input: SIS0817:00 0457:1071 as 
/devices/platform/80860F41:03/i2c-11/i2c-SIS0817:00/0018:0457:1071.0004/input/input8
[    7.242608] hid-multitouch 0018:0457:1071.0004: input,hidraw2: 
<UNKNOWN> HID v1.00 Device [SIS0817:00 0457:1071] on
[    7.311281] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[    7.311316] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[    7.311347] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[    7.311380] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[    7.311407] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    7.311436] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    7.311466] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    7.311498] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
[    9.723874] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[    9.723910] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[    9.723955] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[    9.724011] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[    9.724040] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    9.724069] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    9.724100] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    9.724132] sst-mfld-platform sst-mfld-platform: Slot control: 
codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
[   24.513187]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.513608]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.513815]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.514811]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.515238]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.515443]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.519270]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.519859]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.520205]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.522128]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.522738]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.523205]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.528612]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.529267]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.529734]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.530941]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.531520]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.531713]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.533304]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.533983]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.534607]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.536547]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.537367]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   24.537956]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   25.540482] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   25.540492] intel_sst_acpi 80860F28:00: fw returned err -16
[   26.576173] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x0 fw_state 0x1
[   26.576185] intel_sst_acpi 80860F28:00: fw download failed -16
[   26.576199] intel_sst_acpi 80860F28:00: FW download fail -16
[   26.576434] sst-mfld-platform sst-mfld-platform: Enter: enable=0 
port_name=ssp2-port
[   27.578658] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   27.578672] intel_sst_acpi 80860F28:00: fw returned err -16
[   28.578938] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   28.578972] intel_sst_acpi 80860F28:00: fw returned err -16
[   29.578106] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   29.578120] intel_sst_acpi 80860F28:00: fw returned err -16
[   29.578394] sst-mfld-platform sst-mfld-platform: Enter: enable=0 
port_name=ssp2-port
[   30.577645] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   30.577659] intel_sst_acpi 80860F28:00: fw returned err -16
[   31.578110] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   31.578124] intel_sst_acpi 80860F28:00: fw returned err -16
[   32.580594] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   32.580625] intel_sst_acpi 80860F28:00: fw returned err -16
[   32.580967] sst-mfld-platform sst-mfld-platform: Enter: enable=0 
port_name=ssp2-port
[   33.580576] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   33.580607] intel_sst_acpi 80860F28:00: fw returned err -16
[   34.580573] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   34.580607] intel_sst_acpi 80860F28:00: fw returned err -16
[   35.583999] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   35.584013] intel_sst_acpi 80860F28:00: fw returned err -16
[   35.584866] sst-mfld-platform sst-mfld-platform: Enter: enable=0 
port_name=ssp2-port
[   36.582188] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   36.582202] intel_sst_acpi 80860F28:00: fw returned err -16
[   37.584558] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   37.584572] intel_sst_acpi 80860F28:00: fw returned err -16
[   38.586887] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   38.586901] intel_sst_acpi 80860F28:00: fw returned err -16
[   38.645414] sst-mfld-platform sst-mfld-platform: Enter: enable=1 
port_name=ssp2-port
[   39.646574] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   39.646603] intel_sst_acpi 80860F28:00: fw returned err -16
[   39.646826] intel_sst_acpi 80860F28:00: Alloc for str 1 pipe 0x90
[   40.647453] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   40.647469] intel_sst_acpi 80860F28:00: FW alloc failed ret -16
[   40.647476] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
[   40.647485] sst-mfld-platform sst-mfld-platform: ASoC: cpu DAI 
prepare error: -5
[   40.647492]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio 
Port failed
[   40.647781] sst-mfld-platform sst-mfld-platform: Enter: enable=1 
port_name=ssp2-port
[   41.646768] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   41.646782] intel_sst_acpi 80860F28:00: fw returned err -16
[   41.666738] sst-mfld-platform sst-mfld-platform: Enter: enable=0 
port_name=ssp2-port
[   42.665789] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   42.665829] intel_sst_acpi 80860F28:00: fw returned err -16
[   43.666192] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   43.666220] intel_sst_acpi 80860F28:00: fw returned err -16
[   43.666247] intel_sst_acpi 80860F28:00: free stream returned err -19
[   43.670277]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.670692]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.670880]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.672562]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.672955]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.673163]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.674748]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.675712]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.676054]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.678391]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.679146]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   43.679644]  Baytrail Audio Port: ASoC: no backend DAIs enabled for 
Baytrail Audio Port
[   44.692984] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   44.693018] intel_sst_acpi 80860F28:00: fw returned err -16
[   44.693460] sst-mfld-platform sst-mfld-platform: Enter: enable=1 
port_name=ssp2-port
[   45.697876] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   45.697919] intel_sst_acpi 80860F28:00: fw returned err -16
[   45.698345] intel_sst_acpi 80860F28:00: Alloc for str 1 pipe 0x90
[   46.695853] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   46.695888] intel_sst_acpi 80860F28:00: FW alloc failed ret -16
[   46.695907] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
[   46.695927] sst-mfld-platform sst-mfld-platform: ASoC: cpu DAI 
prepare error: -5
[   46.695944]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio 
Port failed
[   46.696658] sst-mfld-platform sst-mfld-platform: Enter: enable=1 
port_name=ssp2-port
[   47.695069] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   47.695101] intel_sst_acpi 80860F28:00: fw returned err -16
[   47.746657]  Baytrail Audio Port: sst: error code = -22
[   47.746670] snd_pcm_update_hw_ptr0: 42 callbacks suppressed
[   47.746681] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   47.746719]  Baytrail Audio Port: sst: error code = -22
[   47.746729] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   47.946408]  Baytrail Audio Port: sst: error code = -22
[   47.946425] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   47.946469]  Baytrail Audio Port: sst: error code = -22
[   47.946478] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   47.946551]  Baytrail Audio Port: sst: error code = -22
[   47.946560] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   47.946583]  Baytrail Audio Port: sst: error code = -22
[   47.946591] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   47.946719]  Baytrail Audio Port: sst: error code = -22
[   47.946727] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   47.946748]  Baytrail Audio Port: sst: error code = -22
[   47.946755] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   47.946803]  Baytrail Audio Port: sst: error code = -22
[   47.946812] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   47.946833]  Baytrail Audio Port: sst: error code = -22
[   47.946841] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   52.774296]  Baytrail Audio Port: sst: error code = -22
[   52.774315] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[   52.774477] sst-mfld-platform sst-mfld-platform: Enter: enable=0 
port_name=ssp2-port
[   53.772062] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   53.772077] intel_sst_acpi 80860F28:00: fw returned err -16
[   54.771714] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[   54.771725] intel_sst_acpi 80860F28:00: fw returned err -16
[   54.771748] intel_sst_acpi 80860F28:00: free stream returned err -19
[   55.996693] FAT-fs (sda1): Volume was not properly unmounted. Some 
data may be corrupt. Please run fsck.
[  114.676516] sst-mfld-platform sst-mfld-platform: rx slot - slot 0 map 
= 0x1
[  114.676544] sst-mfld-platform sst-mfld-platform: rx slot - slot 1 map 
= 0x2
[  114.676575] sst-mfld-platform sst-mfld-platform: rx slot - slot 2 map 
= 0x4
[  114.676599] sst-mfld-platform sst-mfld-platform: rx slot - slot 3 map 
= 0x8
[  114.676777] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_0 map = 0x1
[  114.676803] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_1 map = 0x2
[  114.676826] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_0 map = 0x4
[  114.676858] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_1 map = 0x8
[  119.608428] sst-mfld-platform sst-mfld-platform: rx slot - slot 0 map 
= 0x1
[  119.608457] sst-mfld-platform sst-mfld-platform: rx slot - slot 1 map 
= 0x2
[  119.608488] sst-mfld-platform sst-mfld-platform: rx slot - slot 2 map 
= 0x4
[  119.608511] sst-mfld-platform sst-mfld-platform: rx slot - slot 3 map 
= 0x8
[  119.608642] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_0 map = 0x1
[  119.608667] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_1 map = 0x2
[  119.608691] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_0 map = 0x4
[  119.608724] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_1 map = 0x8
[  126.227581] sst-mfld-platform sst-mfld-platform: rx slot - slot 0 map 
= 0x1
[  126.227608] sst-mfld-platform sst-mfld-platform: rx slot - slot 1 map 
= 0x2
[  126.227643] sst-mfld-platform sst-mfld-platform: rx slot - slot 2 map 
= 0x4
[  126.227666] sst-mfld-platform sst-mfld-platform: rx slot - slot 3 map 
= 0x8
[  126.227795] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_0 map = 0x1
[  126.227821] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_1 map = 0x2
[  126.227844] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_0 map = 0x4
[  126.227877] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_1 map = 0x8
[  139.005333] sst-mfld-platform sst-mfld-platform: enable=1, usage=0
[  139.005445] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff 
ff ff 55 00 00 00  ............U...
[  140.003289] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  140.003301] intel_sst_acpi 80860F28:00: fw returned err -16
[  140.003551] sst-mfld-platform sst-mfld-platform: Enter: enable=1 
port_name=ssp2-port
[  140.003560] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[  140.003568] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff 
ff ff 75 00 12 00  ............u...
[  140.003573] writing to lpe: 00000010: 03 00 03 00 18 09 0f ff 0f ff 
03 00 01 01 01 00  ................
[  140.003578] writing to lpe: 00000020: 00 
00                                            ..
[  141.003926] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  141.003957] intel_sst_acpi 80860F28:00: fw returned err -16
[  141.101092] intel_sst_acpi 80860F28:00: Alloc for str 1 pipe 0x90
[  142.098744] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  142.098759] intel_sst_acpi 80860F28:00: FW alloc failed ret -16
[  142.098767] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
[  142.098775] sst-mfld-platform sst-mfld-platform: ASoC: cpu DAI 
prepare error: -5
[  142.098782]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio 
Port failed
[  142.098916] sst-mfld-platform sst-mfld-platform: Enter: enable=1 
port_name=ssp2-port
[  142.098925] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[  142.098934] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff 
ff ff 75 00 12 00  ............u...
[  142.098940] writing to lpe: 00000010: 03 00 03 00 18 09 0f ff 0f ff 
03 00 01 01 01 00  ................
[  142.098945] writing to lpe: 00000020: 00 
00                                            ..
[  143.099029] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  143.099059] intel_sst_acpi 80860F28:00: fw returned err -16
[  143.101177] sst-mfld-platform sst-mfld-platform: Enter: widget=codec_out0
[  143.101190] writing to lpe: 00000000: 01 02 01 01 00 00 1e 00 ff ff 
ff ff 82 00 16 00  ................
[  143.101196] writing to lpe: 00000010: 82 00 12 00 03 00 01 02 04 08 
10 20 40 80 01 02  ........... @...
[  143.101201] writing to lpe: 00000020: 04 08 10 20 40 
80                                ... @.
[  144.098176] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x2 fw_state 0x3
[  144.098187] intel_sst_acpi 80860F28:00: fw returned err -16
[  144.098198] sst-mfld-platform sst-mfld-platform: Enter: widget=codec_out0
[  144.098203] sst-mfld-platform sst-mfld-platform: control 
name=codec_out0 Gain 0 Volume
[  144.098208] sst-mfld-platform sst-mfld-platform: Enter
[  144.098215] writing to lpe: 00000000: 01 02 01 01 00 00 14 00 ff ff 
ff ff 21 00 0c 00  ............!...
[  144.098219] writing to lpe: 00000010: 01 00 00 02 67 00 01 00 01 00 
32 00              ....g.....2.
[  145.098502] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x2 fw_state 0x3
[  145.098533] intel_sst_acpi 80860F28:00: fw returned err -16
[  145.098569] sst-mfld-platform sst-mfld-platform: widget = codec_out0 
mix 0
[  145.098590] sst-mfld-platform sst-mfld-platform: val = 0x2000
[  145.098607] sst-mfld-platform sst-mfld-platform: reg: 0x2000
[  145.098625] sst-mfld-platform sst-mfld-platform: input id: 0x8dff, 
nb_inputs: 1
[  145.098645] writing to lpe: 00000000: 01 01 01 01 00 00 14 00 ff ff 
ff ff 72 00 0c 00  ............r...
[  145.098661] writing to lpe: 00000010: ff 02 ff ff 03 00 01 00 ff 8d 
ff ff              ............
[  146.098047] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  146.098063] intel_sst_acpi 80860F28:00: fw returned err -16
[  146.098081] sst-mfld-platform sst-mfld-platform: widget = media0_out 
mix 0
[  146.098091] sst-mfld-platform sst-mfld-platform: val = 0x40000
[  146.098099] sst-mfld-platform sst-mfld-platform: reg: 0x40000
[  146.098108] sst-mfld-platform sst-mfld-platform: input id: 0x90ff, 
nb_inputs: 1
[  146.098118] writing to lpe: 00000000: 01 01 01 03 00 00 14 00 ff ff 
ff ff 72 00 0c 00  ............r...
[  146.098126] writing to lpe: 00000010: ff 12 ff ff 03 00 01 00 ff 90 
ff ff              ............
[  147.099238] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  147.099269] intel_sst_acpi 80860F28:00: fw returned err -16
[  147.101296] sst-mfld-platform sst-mfld-platform: widget=media0_out
[  147.101305] sst-mfld-platform sst-mfld-platform: task=3, location=0x12ff
[  147.101352] writing to lpe: 00000000: 01 01 01 03 00 00 0a 00 ff 12 
ff ff 77 00 02 00  ............w...
[  147.101360] writing to lpe: 00000010: 01 
00                                            ..
[  148.105710] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  148.105741] intel_sst_acpi 80860F28:00: fw returned err -16
[  148.105770] sst-mfld-platform sst-mfld-platform: Enter: widget=media0_out
[  148.105794] sst-mfld-platform sst-mfld-platform: widget=pcm0_in
[  148.105813] sst-mfld-platform sst-mfld-platform: task=1, location=0x8dff
[  148.105833] writing to lpe: 00000000: 01 01 01 01 00 00 0a 00 ff 8d 
ff ff 77 00 02 00  ............w...
[  148.105848] writing to lpe: 00000010: 01 
00                                            ..
[  149.105371] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  149.105402] intel_sst_acpi 80860F28:00: fw returned err -16
[  149.105431] sst-mfld-platform sst-mfld-platform: Enter: widget=pcm0_in
[  149.105450] sst-mfld-platform sst-mfld-platform: control name=pcm0_in 
Gain 0 Volume
[  149.105466] sst-mfld-platform sst-mfld-platform: Enter
[  149.105485] writing to lpe: 00000000: 01 02 01 01 00 00 14 00 ff ff 
ff ff 21 00 0c 00  ............!...
[  149.105501] writing to lpe: 00000010: 01 00 00 8d 67 00 01 00 01 00 
32 00              ....g.....2.
[  150.105105] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x2 fw_state 0x3
[  150.105136] intel_sst_acpi 80860F28:00: fw returned err -16
[  150.106429] sst-mfld-platform sst-mfld-platform: enter, 
dai-name=media-cpu-dai dir=0
[  150.106454] sst-mfld-platform sst-mfld-platform: Stream name=Headset 
Playback
[  150.106473] sst-mfld-platform sst-mfld-platform: send gains for 
widget=media1_in
[  150.106491] sst-mfld-platform sst-mfld-platform: control 
name=media1_in Gain 0 Volume
[  150.106507] sst-mfld-platform sst-mfld-platform: Enter
[  150.106527] writing to lpe: 00000000: 01 02 01 03 00 00 14 00 ff ff 
ff ff 21 00 0c 00  ............!...
[  150.106543] writing to lpe: 00000010: 01 00 00 90 67 00 01 00 01 00 
32 00              ....g.....2.
[  151.104979] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x2 fw_state 0x3
[  151.104994] intel_sst_acpi 80860F28:00: fw returned err -16
[  151.116671] sst-mfld-platform sst-mfld-platform: enter, 
dai-name=media-cpu-dai dir=0
[  151.116683] sst-mfld-platform sst-mfld-platform: Stream name=Headset 
Playback
[  151.116691] sst-mfld-platform sst-mfld-platform: send gains for 
widget=media1_in
[  151.116698] sst-mfld-platform sst-mfld-platform: control 
name=media1_in Gain 0 Volume
[  151.116704] sst-mfld-platform sst-mfld-platform: Enter
[  151.116712] writing to lpe: 00000000: 01 02 01 03 00 00 14 00 ff ff 
ff ff 21 00 0c 00  ............!...
[  151.116718] writing to lpe: 00000010: 01 00 00 90 67 00 01 00 01 00 
32 00              ....g.....2.
[  152.120545] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x2 fw_state 0x3
[  152.120576] intel_sst_acpi 80860F28:00: fw returned err -16
[  152.124357]  Baytrail Audio Port: sst_platform_pcm_trigger called
[  152.124372]  Baytrail Audio Port: sst: Trigger Start
[  152.124385]  SSP2-Codec: sst_platform_pcm_trigger called
[  152.124417]  Baytrail Audio Port: sst: error code = -22
[  152.124435] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  152.124482]  Baytrail Audio Port: sst: error code = -22
[  152.124497] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  152.125016]  Baytrail Audio Port: sst: error code = -22
[  152.125033] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  152.125070]  Baytrail Audio Port: sst: error code = -22
[  152.125083] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  152.125356]  Baytrail Audio Port: sst: error code = -22
[  152.125371] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  152.125406]  Baytrail Audio Port: sst: error code = -22
[  152.125419] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  152.125581]  Baytrail Audio Port: sst: error code = -22
[  152.125597] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  152.125857]  Baytrail Audio Port: sst: error code = -22
[  152.125874] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  152.126241]  Baytrail Audio Port: sst: error code = -22
[  152.126256] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  152.126299]  Baytrail Audio Port: sst: error code = -22
[  152.130083]  Baytrail Audio Port: sst: error code = -22
[  152.130144]  Baytrail Audio Port: sst: error code = -22
[  152.130422]  Baytrail Audio Port: sst: error code = -22
[  152.130456]  Baytrail Audio Port: sst: error code = -22
[  152.130692]  Baytrail Audio Port: sst: error code = -22
[  152.130724]  Baytrail Audio Port: sst: error code = -22
[  152.189058]  Baytrail Audio Port: sst: error code = -22
[  152.189082]  Baytrail Audio Port: sst: error code = -22
[  152.189142]  Baytrail Audio Port: sst: error code = -22
[  152.189155]  Baytrail Audio Port: sst: error code = -22
[  152.189273]  Baytrail Audio Port: sst: error code = -22
[  152.189291]  Baytrail Audio Port: sst: error code = -22
[  168.245085]  Baytrail Audio Port: sst: error code = -22
[  168.245101] snd_pcm_update_hw_ptr0: 43 callbacks suppressed
[  168.245112] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  168.245256]  Baytrail Audio Port: sst: error code = -22
[  168.245267] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  168.245278]  Baytrail Audio Port: sst: error code = -22
[  168.245286] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  168.245307]  Baytrail Audio Port: sst: error code = -22
[  168.245316] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  168.245630]  Baytrail Audio Port: sst: error code = -22
[  168.245644] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  168.245660]  Baytrail Audio Port: sst: error code = -22
[  168.245668] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  168.246477]  Baytrail Audio Port: sst: error code = -22
[  168.246488] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  168.246512]  Baytrail Audio Port: sst: error code = -22
[  168.246521] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  168.247993]  Baytrail Audio Port: sst: error code = -22
[  168.248008] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  168.248028]  Baytrail Audio Port: sst: error code = -22
[  168.248037] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  168.248126]  Baytrail Audio Port: sst: error code = -22
[  168.248142]  Baytrail Audio Port: sst: error code = -22
[  168.263803]  Baytrail Audio Port: sst: error code = -22
[  168.263879]  Baytrail Audio Port: sst: error code = -22
[  168.263903]  Baytrail Audio Port: sst: error code = -22
[  173.301480]  Baytrail Audio Port: sst: error code = -22
[  173.301503] snd_pcm_update_hw_ptr0: 10 callbacks suppressed
[  173.301521] bytt100_rt5640 bytt100_rt5640: BUG: , pos = -22, buffer 
size = 203830, period size = 1199
[  173.301559]  Baytrail Audio Port: sst_platform_pcm_trigger called
[  173.301570]  Baytrail Audio Port: sst: in stop
[  173.301582]  SSP2-Codec: sst_platform_pcm_trigger called
[  173.301875] sst-mfld-platform sst-mfld-platform: Enter: enable=0 
port_name=ssp2-port
[  173.301890] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[  173.301904] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff 
ff ff 75 00 12 00  ............u...
[  173.301915] writing to lpe: 00000010: 03 00 00 00 18 09 0f ff 0f ff 
03 00 01 01 01 00  ................
[  173.301924] writing to lpe: 00000020: 00 
00                                            ..
[  174.311858] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  174.311887] intel_sst_acpi 80860F28:00: fw returned err -16
[  174.311905] sst-mfld-platform sst-mfld-platform: enable=0, usage=1
[  174.311917] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff 
ff ff 0e 00 00 00  ................
[  175.325750] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  175.325781] intel_sst_acpi 80860F28:00: fw returned err -16
[  175.325830] sst-mfld-platform sst-mfld-platform: enter, 
dai-name=media-cpu-dai dir=0
[  175.325850] sst-mfld-platform sst-mfld-platform: Stream name=Headset 
Playback
[  175.325867] sst-mfld-platform sst-mfld-platform: send gains for 
widget=media1_in
[  175.325885] sst-mfld-platform sst-mfld-platform: control 
name=media1_in Gain 0 Volume
[  175.325901] sst-mfld-platform sst-mfld-platform: Enter
[  175.325921] writing to lpe: 00000000: 01 02 01 03 00 00 14 00 ff ff 
ff ff 21 00 0c 00  ............!...
[  175.325936] writing to lpe: 00000010: 01 00 00 90 67 00 60 fa 60 fa 
32 00              ....g.`.`.2.
[  176.333273] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x2 fw_state 0x3
[  176.333286] intel_sst_acpi 80860F28:00: fw returned err -16
[  176.333302] intel_sst_acpi 80860F28:00: free stream returned err -19
[  176.356161] sst-mfld-platform sst-mfld-platform: widget=pcm0_in
[  176.356192] sst-mfld-platform sst-mfld-platform: task=1, location=0x8dff
[  176.356210] writing to lpe: 00000000: 01 01 01 01 00 00 0a 00 ff 8d 
ff ff 77 00 02 00  ............w...
[  176.356215] writing to lpe: 00000010: 00 
00                                            ..
[  177.362454] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  177.362485] intel_sst_acpi 80860F28:00: fw returned err -16
[  177.362519] sst-mfld-platform sst-mfld-platform: widget=media0_out
[  177.362539] sst-mfld-platform sst-mfld-platform: task=3, location=0x12ff
[  177.362559] writing to lpe: 00000000: 01 01 01 03 00 00 0a 00 ff 12 
ff ff 77 00 02 00  ............w...
[  177.362574] writing to lpe: 00000010: 00 
00                                            ..
[  178.374015] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  178.374031] intel_sst_acpi 80860F28:00: fw returned err -16
[  178.395355] sst-mfld-platform sst-mfld-platform: widget = codec_out0 
mix 0
[  178.395370] sst-mfld-platform sst-mfld-platform: val = 0x2000
[  178.395377] sst-mfld-platform sst-mfld-platform: reg: 0x2000
[  178.395384] sst-mfld-platform sst-mfld-platform: input id: 0x8dff, 
nb_inputs: 1
[  178.395393] writing to lpe: 00000000: 01 01 01 01 00 00 14 00 ff ff 
ff ff 72 00 0c 00  ............r...
[  178.395399] writing to lpe: 00000010: ff 02 ff ff 00 00 01 00 ff 8d 
ff ff              ............
[  179.402276] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  179.402295] intel_sst_acpi 80860F28:00: fw returned err -16
[  179.402317] sst-mfld-platform sst-mfld-platform: widget = media0_out 
mix 0
[  179.402329] sst-mfld-platform sst-mfld-platform: val = 0x40000
[  179.402339] sst-mfld-platform sst-mfld-platform: reg: 0x40000
[  179.402350] sst-mfld-platform sst-mfld-platform: input id: 0x90ff, 
nb_inputs: 1
[  179.402363] writing to lpe: 00000000: 01 01 01 03 00 00 14 00 ff ff 
ff ff 72 00 0c 00  ............r...
[  179.402372] writing to lpe: 00000010: ff 12 ff ff 00 00 01 00 ff 90 
ff ff              ............
[  180.404428] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, 
msg_id:0x1 fw_state 0x3
[  180.404459] intel_sst_acpi 80860F28:00: fw returned err -16
[  180.429028] sst-mfld-platform sst-mfld-platform: Enter: widget=codec_out0
[  188.094698] sst-mfld-platform sst-mfld-platform: rx slot - slot 0 map 
= 0x1
[  188.094726] sst-mfld-platform sst-mfld-platform: rx slot - slot 1 map 
= 0x2
[  188.094757] sst-mfld-platform sst-mfld-platform: rx slot - slot 2 map 
= 0x4
[  188.095278] sst-mfld-platform sst-mfld-platform: rx slot - slot 3 map 
= 0x8
[  188.095463] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_0 map = 0x1
[  188.095490] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_1 map = 0x2
[  188.095514] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_0 map = 0x4
[  188.095549] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_1 map = 0x8
[  195.598755] sst-mfld-platform sst-mfld-platform: rx slot - slot 0 map 
= 0x1
[  195.598788] sst-mfld-platform sst-mfld-platform: rx slot - slot 1 map 
= 0x2
[  195.598828] sst-mfld-platform sst-mfld-platform: rx slot - slot 2 map 
= 0x4
[  195.598856] sst-mfld-platform sst-mfld-platform: rx slot - slot 3 map 
= 0x8
[  195.599011] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_0 map = 0x1
[  195.599040] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_1 map = 0x2
[  195.599069] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_0 map = 0x4
[  195.599107] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_1 map = 0x8
[  201.401358] sst-mfld-platform sst-mfld-platform: rx slot - slot 0 map 
= 0x1
[  201.401396] sst-mfld-platform sst-mfld-platform: rx slot - slot 1 map 
= 0x2
[  201.401438] sst-mfld-platform sst-mfld-platform: rx slot - slot 2 map 
= 0x4
[  201.401471] sst-mfld-platform sst-mfld-platform: rx slot - slot 3 map 
= 0x8
[  201.401647] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_0 map = 0x1
[  201.401682] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out0_1 map = 0x2
[  201.401715] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_0 map = 0x4
[  201.401759] sst-mfld-platform sst-mfld-platform: tx channel - 
codec_out1_1 map = 0x8
