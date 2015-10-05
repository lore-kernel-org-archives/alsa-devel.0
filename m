From: Rick Mann <rmann@latencyzero.com>
Subject: davinci_evm ocp:sound: ASoC: CPU DAI (null) not
	registered
Date: Mon, 5 Oct 2015 04:38:12 -0700
Message-ID: <15F75D54-C87D-4688-A7DF-2D061BA46C86@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id C454C260508
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 13:38:13 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 6303D2035A
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 07:38:13 -0400 (EDT)
Received: from [192.168.15.51] (c-50-168-55-93.hsd1.ca.comcast.net
 [50.168.55.93])
 by mail.messagingengine.com (Postfix) with ESMTPA id EA601680123
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 07:38:12 -0400 (EDT)
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

UPDATE: I was able to read the McASP registers (turns out, its clocks are only enabled while speaker-test is running, so that's the only time the registers are mapped). AHCLKXCTL is 0x00008000, which corresponds to having it set as an output, not inverted, and clock divide-by-1. This seems wrong. I'm having trouble determining what the AUXCLK that feeds the McASP is, but it's not 12 MHz, and without division, I don't see how to get there. For reference, here are the actual values of the McASP transmit registers:

GBLCTL		0x00000000	Lots of stuff held in reset (red flag?)
XGBLCTL		0x00000000	Same
XMASK		0x0000FFFF	I think this masks out 16-bits?
XFMT		0x00008074	MSB bit first, slot size 16-bit, rot right 16 bits
AFSXCTL		0x00000100	2-slot TDM (I2S mode)
ACLKXCTL	0x00000000	Sync xmit, ACLKX is from pin
AHCLKXCTL	0x00008000	Internal high-freq clock from clock divider
XTDM		0x00000003	2 TDM slots active
XINTCTL		0x00000000	
XSTAT		0x0000010C	Xmit error occurred, cur TDM slot is even, xmit clock failure
XSLOT		0x0000017F	Current time slot (shouldn't this be 0 or 1?)
XCLKCHK		0x00000000
XEVTCTL		0x00000000

Thanks,
Rick

----

I've been at this for weeks and I'm still unable to get linux to work correctly with my TI codec. This is on a Beaglebone Black running a 4.1.4 kernel (later versions are worse). I've tried multiple versions of the kernel trying to narrow it down. I keep coming back to 4.1.4 as the most recent that at least generates some audio clocks.

The AM335x mcasp0 should be speaking i2s with the tlv320aic3104.

I have my own build from source of the BBB 4.1.4-ti-r9 release (mainline plus TI plus Beaglebone stuff). I've sprinkled some logging around the audio drivers, but so far I don't see much, and I really don't understand how all the pieces fit together.

One thing I found with my logging is the mcasp MCLK (AHCLKXDIV) is never set. I have logging calls in __davinci_mcasp_set_clkdiv() (sound/soc/davinci/davinci-mcasp.c), which is the only code I could find that sets the McASP clock, and it's never called. I tried to use devmem2 to read the registers in the SoC to see if they were set correctly, but I just get a bus error (other reads do work).

Errors in dmesg when I load the device tree overlay for my cape suggest I still don't have something configured correctly (see below).

I'd sure appreciate any insight into these latest issues. Thanks!


Symptoms:

MCLK should be 12 MHz, but is 24.00 MHz.
Buffer underflows when running speaker-test.

Errors to console upon loading cape:

[   38.502299] davinci_evm ocp:sound: ASoC: CPU DAI (null) not registered
[   38.517917] davinci_evm ocp:sound: snd_soc_register_card failed (-517)
[   38.530425] davinci_evm ocp:sound: ASoC: CPU DAI (null) not registered
[   38.536996] davinci_evm ocp:sound: snd_soc_register_card failed (-517)
[   38.564279] davinci_evm ocp:sound: ASoC: DAPM unknown pin MONO_LOUT

dmesg upon loading cape overlay (https://github.com/JetForMe/podtique/blob/v1/bbb/cape/Podtique1/BB-ENABLE-PRU.dts):

[  568.323587] bone_capemgr bone_capemgr: part_number 'BB-ENABLE-PRU', version 'N/A'
[  568.323629] bone_capemgr bone_capemgr: slot #4: override
[  568.323646] bone_capemgr bone_capemgr: Using override eeprom data at slot 4
[  568.323663] bone_capemgr bone_capemgr: slot #4: 'Override Board Name,00A0,Override Manuf,BB-ENABLE-PRU'
[  568.323804] bone_capemgr:capemgr_load_slot:1148: bone_capemgr bone_capemgr: slot #4: Requesting part number/version based 'BB-ENABLE-PRU-00A0.dtbo
[  568.323825] bone_capemgr:capemgr_load_slot:1162: bone_capemgr bone_capemgr: slot #4: Requesting firmware 'BB-ENABLE-PRU-00A0.dtbo' for board-name 'Override Board Name', version '00A0'
[  568.330369] bone_capemgr:capemgr_load_slot:1171: bone_capemgr bone_capemgr: slot #4: dtbo 'BB-ENABLE-PRU-00A0.dtbo' loaded; converting to live tree
[  568.341685] gpio-of-helper ocp:gpio_helper: ready
[  568.344695] bone_capemgr bone_capemgr: slot #4: dtbo 'BB-ENABLE-PRU-00A0.dtbo' loaded; overlay id #0
[  568.387640] **** RLM davinci-evm.c:480: RLM: clock rate: 12000000
[  568.387695] snd_soc_core:soc_bind_dai_link:938: davinci_evm ocp:sound: ASoC: binding TLV320AIC3X at idx 0
[  568.387712] davinci_evm ocp:sound: ASoC: CPU DAI (null) not registered
[  568.394284] davinci_evm ocp:sound: snd_soc_register_card failed (-517)
[  568.410560] snd_soc_core:snd_soc_register_codec:3064: tlv320aic3x-codec 2-0018: codec register 2-0018
[  568.410614] snd_soc_core:snd_soc_register_dais:2590: tlv320aic3x-codec 2-0018: ASoC: dai register 2-0018 #1
[  568.410633] snd_soc_core:snd_soc_register_dais:2634: tlv320aic3x-codec 2-0018: ASoC: Registered DAI 'tlv320aic3x-hifi'
[  568.410653] snd_soc_core:snd_soc_register_codec:3138: tlv320aic3x-codec 2-0018: ASoC: Registered codec 'tlv320aic3x-codec.2-0018'
[  568.421529] **** RLM davinci-evm.c:480: RLM: clock rate: 12000000
[  568.421588] snd_soc_core:soc_bind_dai_link:938: davinci_evm ocp:sound: ASoC: binding TLV320AIC3X at idx 0
[  568.421605] davinci_evm ocp:sound: ASoC: CPU DAI (null) not registered
[  568.431455] **** RLM davinci-mcasp.c:1734: davinci_mcasp_probe
[  568.431507] base:of_property_match_string:1398: comparing tx with tx
[  568.431544] base:of_property_match_string:1398: comparing rx with tx
[  568.431555] base:of_property_match_string:1398: comparing rx with rx
[  568.431608] base:of_property_match_string:1398: comparing common with tx
[  568.431621] base:of_property_match_string:1398: comparing common with rx
[  568.431633] base:of_property_match_string:1398: comparing rx with tx
[  568.431643] base:of_property_match_string:1398: comparing rx with rx
[  568.434643] base:of_property_match_string:1398: comparing tx with tx
[  568.437971] davinci_evm ocp:sound: snd_soc_register_card failed (-517)
[  568.446651] snd_soc_core:snd_soc_register_dais:2590: davinci-mcasp 48038000.mcasp: ASoC: dai register 48038000.mcasp #1
[  568.446682] snd_soc_core:snd_soc_register_dais:2634: davinci-mcasp 48038000.mcasp: ASoC: Registered DAI '48038000.mcasp'
[  568.446840] snd_soc_core:snd_soc_add_platform:2892: davinci-mcasp 48038000.mcasp: ASoC: Registered platform '48038000.mcasp'
[  568.450046] **** RLM davinci-evm.c:480: RLM: clock rate: 12000000
[  568.450100] snd_soc_core:soc_bind_dai_link:938: davinci_evm ocp:sound: ASoC: binding TLV320AIC3X at idx 0
[  568.450425] snd_soc_core:snd_soc_dapm_new_dai_widgets:3494: tlv320aic3x-codec 2-0018: ASoC: adding Playback widget
[  568.450448] snd_soc_core:snd_soc_dapm_new_dai_widgets:3513: tlv320aic3x-codec 2-0018: ASoC: adding Capture widget
[  568.450995] snd_soc_core:soc_probe_link_dais:1334: davinci_evm ocp:sound: ASoC: probe Podtique DaVinci EVM dai link 0 late -2
[  568.451015] snd_soc_core:soc_probe_link_dais:1334: davinci_evm ocp:sound: ASoC: probe Podtique DaVinci EVM dai link 0 late -1
[  568.451030] snd_soc_core:soc_probe_link_dais:1334: davinci_evm ocp:sound: ASoC: probe Podtique DaVinci EVM dai link 0 late 0
[  568.451045] snd_soc_core:soc_probe_link_dais:1334: davinci_evm ocp:sound: ASoC: probe Podtique DaVinci EVM dai link 0 late 1
[  568.451059] snd_soc_core:soc_probe_link_dais:1334: davinci_evm ocp:sound: ASoC: probe Podtique DaVinci EVM dai link 0 late 2
[  568.451099] davinci_evm ocp:sound: ASoC: DAPM unknown pin MONO_LOUT
[  568.465530] snd_soc_core:soc_new_pcm:2510: davinci_evm ocp:sound: ASoC: registered pcm #0 AIC3X tlv320aic3x-hifi-0
[  568.466155] davinci_evm ocp:sound: tlv320aic3x-hifi <-> 48038000.mcasp mapping ok
[  568.466185] snd_soc_core:snd_soc_dapm_link_dai_widgets:3570: tlv320aic3x-codec 2-0018: Right ADC -> Capture
[  568.466206] snd_soc_core:snd_soc_dapm_link_dai_widgets:3570: tlv320aic3x-codec 2-0018: Left ADC -> Capture
[  568.466226] snd_soc_core:snd_soc_dapm_link_dai_widgets:3570: tlv320aic3x-codec 2-0018: Playback -> Right DAC
[  568.466241] snd_soc_core:snd_soc_dapm_link_dai_widgets:3570: tlv320aic3x-codec 2-0018: Playback -> Left DAC

upon starting speaker-test:

[  572.786071] snd_soc_core:soc_pcm_open:535: ASoC: tlv320aic3x-hifi <-> 48038000.mcasp info:
[  572.786103] snd_soc_core:soc_pcm_open:536: ASoC: rate mask 0x7fe
[  572.786114] snd_soc_core:soc_pcm_open:538: ASoC: min ch 2 max ch 2
[  572.786126] snd_soc_core:soc_pcm_open:540: ASoC: min rate 8000 max rate 96000
[  572.841514] davinci-mcasp 48038000.mcasp: Transmit buffer underflow
...repeated
[  574.087162] davinci-mcasp 48038000.mcasp: Transmit buffer underflow
[  579.135283] snd_soc_core:close_delayed_work:602:  TLV320AIC3X: ASoC: pop wq checking: Playback status: inactive waiting: yes


-- 
Rick Mann
rmann@latencyzero.com
