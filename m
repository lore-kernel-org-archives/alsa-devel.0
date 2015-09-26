From: Rick Mann <rmann@latencyzero.com>
Subject: Kernel Device Tree entries for simple-audio-card
Date: Fri, 25 Sep 2015 22:57:40 -0700
Message-ID: <4D7C68FE-B884-489C-91DD-395FE7CE181D@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 182702604DF
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2015 07:57:43 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 4D61220312
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2015 01:57:42 -0400 (EDT)
Received: from [192.168.15.51] (c-50-168-55-93.hsd1.ca.comcast.net
 [50.168.55.93])
 by mail.messagingengine.com (Postfix) with ESMTPA id D34FEC00014
 for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2015 01:57:41 -0400 (EDT)
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

Hi. I've built a Beaglebone Black Cape that has, among other things, a TI Audio CODEC on it (TLV320AIC3104). This is the same CODEC as the BBB Audio Cape (http://elinux.org/CircuitCo:Audio_Cape_RevB), and it's connected in almost the exact same way.

The last few days I've been figuring out the Device Tree overlay needed to get Linux (4.1.4) to recognize it. It's finding the device and instantiating the low-level driver (tlv320aic3x-codec), although I'm not sure at this point if it's actually talking to it (I have verified that low-level i2c commands do work).

But when it comes to the sound card setup, I'm having trouble getting the Device Tree right. I'm hoping someone on this list can offer some insight. The DT is here:

	https://github.com/JetForMe/podtique/blob/master/bbb/cape/Podtique1/BB-ENABLE-PRU.dts

And this is dmesg when I try to load that (note the name of my overlay is BB-ENABLE-PRU, which is an artifact of the experimentation I've been doing; it'll change to something more appropriate):

[   65.859275] bone_capemgr bone_capemgr: part_number 'BB-ENABLE-PRU', version 'N/A'
[   65.859318] bone_capemgr bone_capemgr: slot #4: override
[   65.859336] bone_capemgr bone_capemgr: Using override eeprom data at slot 4
[   65.859355] bone_capemgr bone_capemgr: slot #4: 'Override Board Name,00A0,Override Manuf,BB-ENABLE-PRU'
[   65.859488] bone_capemgr: bone_capemgr bone_capemgr: slot #4: Requesting part number/version based 'BB-ENABLE-PRU-00A0.dtbo
[   65.859506] bone_capemgr: bone_capemgr bone_capemgr: slot #4: Requesting firmware 'BB-ENABLE-PRU-00A0.dtbo' for board-name 'Override Board Name', version '00A0'
[   65.861105] bone_capemgr: bone_capemgr bone_capemgr: slot #4: dtbo 'BB-ENABLE-PRU-00A0.dtbo' loaded; converting to live tree
[   65.875618] gpio-of-helper ocp:gpio_helper: ready
[   65.876327] gpiolib_of: of_get_named_gpiod_flags: parsed 'gpio' property of node '//fixedregulator@1[0]' - status (0)
[   65.876619] core: lz-codec-reg: no parameters
[   65.876713] fixed: reg-fixed-voltage fixedregulator@1: lz-codec-reg supplying 0uV
[   65.883284] pruss_uio 4a300000.pruss: pins are not configured from the driver
[   65.900080] bone_capemgr bone_capemgr: slot #4: dtbo 'BB-ENABLE-PRU-00A0.dtbo' loaded; overlay id #0
[   65.946254] gpiolib_of: of_get_named_gpiod_flags: parsed 'gpio-reset' property of node '/ocp/i2c@4819c000/tlv320aic3104@0[0]' - status (0)
[   65.946317] core: tlv320aic3x-codec 2-0018: Looking up IOVDD-supply from device tree
[   65.946405] core: tlv320aic3x-codec 2-0018: Looking up DVDD-supply from device tree
[   65.946468] core: tlv320aic3x-codec 2-0018: Looking up AVDD-supply from device tree
[   65.946544] core: tlv320aic3x-codec 2-0018: Looking up DRVDD-supply from device tree
[   65.946606] snd_soc_core: tlv320aic3x-codec 2-0018: codec register 2-0018
[   65.946640] snd_soc_core: tlv320aic3x-codec 2-0018: ASoC: dai register 2-0018 #1
[   65.946655] snd_soc_core: tlv320aic3x-codec 2-0018: ASoC: Registered DAI 'tlv320aic3x-hifi'
[   65.946671] snd_soc_core: tlv320aic3x-codec 2-0018: ASoC: Registered codec 'tlv320aic3x-codec.2-0018'
[   65.956491] //sound/simple-audio-card,cpu: could not get #sound-dai-cells for /ocp/mcasp@48038000
[   65.978759] snd_soc_core: davinci-mcasp 48038000.mcasp: ASoC: dai register 48038000.mcasp #1
[   65.978795] snd_soc_core: davinci-mcasp 48038000.mcasp: ASoC: Registered DAI '48038000.mcasp'
[   65.978954] snd_soc_core: davinci-mcasp 48038000.mcasp: ASoC: Registered platform '48038000.mcasp'
[   66.012427] asoc-simple-card sound: parse error -22
[   66.042609] asoc-simple-card: probe of sound failed with error -22

Note the bit about "#sound-dai-cells". I'm not sure what's wrong here, and it seems like it might be something in the distro-provided DTB, not my own.

aplay lists nothing (I think in part because I have yet to put in a proper asound.conf file):

# aplay -l
aplay: device_list:268: no soundcards found...

Can someone suggest some diagnostics I can do to see what the state of things is? I'm just not sure what to look for. Thanks!

-- 
Rick Mann
rmann@latencyzero.com
