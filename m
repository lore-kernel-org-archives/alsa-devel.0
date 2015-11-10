From: Zhihe Tu <tuzhihe@pcasl.com>
Subject: Intel Cherry Trail  --  No sound in linux
Date: Tue, 10 Nov 2015 16:38:48 +0800
Message-ID: <000a01d11b93$38632860$a9297920$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.pcasl.com (mail.pcasl.com [211.154.131.149])
 by alsa0.perex.cz (Postfix) with ESMTP id A291B2606CA
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 09:39:04 +0100 (CET)
References: 
In-Reply-To: 
Content-Language: zh-cn
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

Hi All,

I'm trying to make the CherryTrail tablet works in ubuntu14.04.3,  there's
no sound at all,  but it works in win8 & android.

...
[    5.463371] cht-bsw-rt5672 cht-bsw-rt5672: snd-soc-dummy-dai <->
media-cpu-dai mapping ok
[    5.463406] compress asoc: snd-soc-dummy-dai <-> compress-cpu-dai mapping
ok
[    5.475786] cht-bsw-rt5672 cht-bsw-rt5672: rt5670-aif1 <-> ssp2-port
mapping ok
[    5.507355] hid-generic 0003:413C:2003.0002: input,hidraw1: USB HID v1.10
Keyboard [Dell Dell USB Keyboard] on usb-0000:00:14.0-4.2/input0
[    5.695892] Console: switching to colour frame buffer device 170x48
[    5.712458] i915_bpo 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    5.712461] i915_bpo 0000:00:02.0: registered panic notifier
[    5.725983] cfg80211: Calling CRDA to update world regulatory domain
[    5.872710] scsi 0:0:0:0: Direct-Access     ASMT     2115             0
PQ: 0 ANSI: 6
[    5.873522] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.875671] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    5.907038] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 0 doesn't have DAPM widget!!!
[    5.922073] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 1 doesn't have DAPM widget!!!
[    5.935876] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 2 doesn't have DAPM widget!!!
[    5.949941] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 3 doesn't have DAPM widget!!!
[    5.968241] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    5.968267] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    5.968292] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    5.968318] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
...
 [    6.617144] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 0 doesn't have DAPM widget!!!
[    6.632519] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 1 doesn't have DAPM widget!!!
[    6.647501] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 2 doesn't have DAPM widget!!!
[    6.662176] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 3 doesn't have DAPM widget!!!
[    6.677049] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    6.692739] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    6.692765] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    6.692792] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
[    7.541669] init: plymouth-upstart-bridge main process ended, respawning
[    9.804555]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
 [   10.139952]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.147834]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.159472] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.162179] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   10.163874] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.164488] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   10.165994] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.166626] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   10.168438] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.169549] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   10.171607] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.189856] intel_sst_acpi 808622A8:00: Alloc for str 1 pipe 0x90
[   10.204244] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   10.205026] intel_sst_acpi 808622A8:00: Free for str 1 pipe 0x90
[   10.215195] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port

[   12.182265] intel_sst_acpi 808622A8:00: Alloc for str 1 pipe 0x90
[   13.181361] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x2
[   13.181374] intel_sst_acpi 808622A8:00: fw returned err -16
[   14.181735] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[   14.181764] intel_sst_acpi 808622A8:00: fw returned err -16
[   15.181611] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[   15.181641] intel_sst_acpi 808622A8:00: fw returned err -16
[   16.181346] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[   16.181376] intel_sst_acpi 808622A8:00: fw returned err -16
[   16.210605] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   17.209115] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[   17.209144] intel_sst_acpi 808622A8:00: fw returned err -16
[   17.209183] intel_sst_acpi 808622A8:00: free stream returned err -19
[   18.262035] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[   18.262053] intel_sst_acpi 808622A8:00: fw returned err -16
[   19.260719] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[   19.260749] intel_sst_acpi 808622A8:00: fw returned err -16
[   19.313903] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   19.445415] intel_sst_acpi 808622A8:00: Alloc for str 1 pipe 0x90
[   19.445862] intel_sst_acpi 808622A8:00: FW sent error response 0x40034
[   19.445883] intel_sst_acpi 808622A8:00: FW alloc failed ret -4
[   19.445888] intel_sst_acpi 808622A8:00: sst_get_stream returned err -5
[   19.445893] sst-mfld-platform sst-mfld-platform: ASoC: DAI prepare error:
-5
[   19.445898]  Audio Port: ASoC: prepare FE Audio Port failed
[   20.444493] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[   20.444522] intel_sst_acpi 808622A8:00: fw returned err -16
[   21.444427] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[   21.444456] intel_sst_acpi 808622A8:00: fw returned err -16
[   22.444126] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[   22.444155] intel_sst_acpi 808622A8:00: fw returned err -16
[   23.443906] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[   23.443934] intel_sst_acpi 808622A8:00: fw returned err -16
[   23.474492]  Audio Port: sst: error code = -22
[   23.474504] snd_pcm_update_hw_ptr0: 123 callbacks suppressed
[   23.474512] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   23.474589]  Audio Port: sst: error code = -22
[   23.474596] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   23.474612]  Audio Port: sst: error code = -22
[   23.474617] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   23.741085]  Audio Port: sst: error code = -22
[   23.741104] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   23.741140]  Audio Port: sst: error code = -22
[   23.741147] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   23.741206]  Audio Port: sst: error code = -22
[   23.741213] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   23.741233]  Audio Port: sst: error code = -22
[   23.741240] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   23.741350]  Audio Port: sst: error code = -22
[   23.741358] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   23.741379]  Audio Port: sst: error code = -22
[   23.741385] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   23.741427]  Audio Port: sst: error code = -22
[   23.741434] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   23.741455]  Audio Port: sst: error code = -22
[   23.785062]  Audio Port: sst: error code = -22
[   23.785108]  Audio Port: sst: error code = -22
[   23.785185]  Audio Port: sst: error code = -22
[   23.785210]  Audio Port: sst: error code = -22
[   23.785343]  Audio Port: sst: error code = -22
[   23.785367]  Audio Port: sst: error code = -22
[   23.785416]  Audio Port: sst: error code = -22
 [   28.496573] snd_pcm_update_hw_ptr0: 13 callbacks suppressed
[   28.496582] cht-bsw-rt5672 cht-bsw-rt5672: BUG: , pos = -22, buffer size
= 96000, period size = 48000
[   28.496707] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   29.494259] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[   29.494269] intel_sst_acpi 808622A8:00: fw returned err -16
[   29.494284] intel_sst_acpi 808622A8:00: free stream returned err -19
[   30.562054] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[   30.562065] intel_sst_acpi 808622A8:00: fw returned err -16
[   31.561892] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[   31.561904] intel_sst_acpi 808622A8:00: fw returned err -16
[  906.106300] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[  906.249375] intel_sst_acpi 808622A8:00: Alloc for str 1 pipe 0x90
[  907.248864] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x2
[  907.248894] intel_sst_acpi 808622A8:00: fw returned err -16
[  908.248393] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[  908.248421] intel_sst_acpi 808622A8:00: fw returned err -16
[  909.248611] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[  909.248641] intel_sst_acpi 808622A8:00: fw returned err -16
[  910.248108] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[  910.248137] intel_sst_acpi 808622A8:00: fw returned err -16
 [ 1053.563879] isofs_fill_super: bread failed, dev=sdb1, iso_blknum=16,
block=32

 [ 1185.717932] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[ 1186.716247] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[ 1186.716277] intel_sst_acpi 808622A8:00: fw returned err -16
[ 1186.716315] intel_sst_acpi 808622A8:00: free stream returned err -19
[ 1187.783992] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[ 1187.784021] intel_sst_acpi 808622A8:00: fw returned err -16
[ 1188.783551] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[ 1188.783584] intel_sst_acpi 808622A8:00: fw returned err -16
[ 1188.821911] rt5670 i2c-10EC5670:00: Sysclk is 0Hz and clock id is 2
[ 1207.389279] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[ 1207.404620] rt5670 i2c-10EC5670:00: Sysclk is 24576000Hz and clock id is
1
[ 1207.404646] rt5670 i2c-10EC5670:00: bclk is 1536000Hz and lrck is 48000Hz
[ 1207.404660] rt5670 i2c-10EC5670:00: bclk_ms is 0 and pre_div is 1 for iis
1
[ 1207.533606] intel_sst_acpi 808622A8:00: Alloc for str 1 pipe 0x90
[ 1208.535662] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x2
[ 1208.535691] intel_sst_acpi 808622A8:00: fw returned err -16
[ 1209.535853] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[ 1209.535883] intel_sst_acpi 808622A8:00: fw returned err -16
[ 1210.535333] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[ 1210.535361] intel_sst_acpi 808622A8:00: fw returned err -16
[ 1211.535576] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[ 1211.535606] intel_sst_acpi 808622A8:00: fw returned err -16
[ 1286.976450] usb 1-4.1: USB disconnect, device number 8
[11996.101738] r8169 0000:01:00.0 eth0: link up
[11996.101780] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[12019.249846] [drm:intel_pipe_update_end [i915_bpo]] *ERROR* Atomic update
failure on pipe A (start=93814 end=93815)
[12157.754218] [drm:intel_pipe_update_end [i915_bpo]] *ERROR* Atomic update
failure on pipe A (start=102079 end=102080)
[12194.085543] [drm:intel_pipe_update_end [i915_bpo]] *ERROR* Atomic update
failure on pipe A (start=104247 end=104248)
[13567.332608] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[13568.332857] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x2 fw_state 0x3
[13568.332886] intel_sst_acpi 808622A8:00: fw returned err -16
[13568.332924] intel_sst_acpi 808622A8:00: free stream returned err -19
[13569.400219] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[13569.400247] intel_sst_acpi 808622A8:00: fw returned err -16
[13570.399826] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3
[13570.399837] intel_sst_acpi 808622A8:00: fw returned err -16
[13570.437188] rt5670 i2c-10EC5670:00: Sysclk is 0Hz and clock id is 2


>From /sys/kernel/debug/asoc/cherrytrailcraudio/, some necessary widgets are
all power on, from media1_in to ssp2 Tx  end with Headphone.
  
I really don't know how to fix the sst fw error, any anyone give a look at
this issue?


................
Thanks
Tu
 

__________ Information from ESET Smart Security, version of virus signature
database 4468 (20090929) __________

The message was checked by ESET Smart Security.

http://www.eset.com
 
