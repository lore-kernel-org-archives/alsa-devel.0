From: <g4@novadsp.com>
Subject: Beaglebone audio card problem diagnosis?
Date: Sun, 19 Jul 2015 16:40:58 +0100
Message-ID: <002301d0c239$4f63f660$ee2be320$@novadsp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.metamail.co (smtp.metamail.co [217.174.251.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C901260595
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2015 17:41:01 +0200 (CEST)
Content-Language: en-gb
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

Hello all. 

 

I'm running mainline 4.1.0 on a Beaglebone Black (TI AM3359 SOC). The board
has a standard TI TLV320AIC codec connected via the B3 rev B audio cape:
(http://elinux.org/CircuitCo:Audio_Cape_RevB)

 

Loading the nominally correct device tree overlay gets the following kernel
log (1). 

An aplay -l listing (2) shows something recognized is present. 

Lsmod (3) shows what looks like a sane collection of prerequisite modules.

Upon trying to play a test file the kernel gets a number of buffer
underflow/underrun messages (4)

 

There was a patch posted here
(http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/083797.h
tml) which appears to have made it into 4.1.0. 

 

Any thoughts on where to start looking to fix? 

 

More info can be provided if required and can also check hardware pin
activity.

 

Any pointers much appreciated.

 

TAIA

 

Jerry.

 

-----------------------------------snip (1)

root@arm:/home/debian# echo BB-BONE-AUDI-02 >
/sys/devices/platform/bone_capemgr/slots

[  100.654019] bone_capemgr bone_capemgr: part_number 'BB-BONE-AUDI-02',
version 'N/A'

[  100.662117] bone_capemgr bone_capemgr: slot #4: override

[  100.667840] bone_capemgr bone_capemgr: Using override eeprom data at slot
4

[  100.675221] bone_capemgr bone_capemgr: slot #4: 'Override Board
Name,00A0,Override Manuf,BB-BONE-AUDI-02'

[  100.712198] bone_capemgr bone_capemgr: slot #4: dtbo
'BB-BONE-AUDI-02-00A0.dtbo' loaded; overlay id #0

root@arm:/home/debian# [  101.015982] davinci_evm ocp:sound: ASoC: CPU DAI
(null) not registered

[  101.023017] davinci_evm ocp:sound: snd_soc_register_card failed (-517)

[  101.056114] 2-0018 supply IOVDD not found, using dummy regulator

[  101.067907] 2-0018 supply DVDD not found, using dummy regulator

[  101.074535] 2-0018 supply AVDD not found, using dummy regulator

[  101.080746] 2-0018 supply DRVDD not found, using dummy regulator

[  101.089316] davinci_evm ocp:sound: ASoC: CODEC DAI tlv320aic3x-hifi not
registered

[  101.097310] davinci_evm ocp:sound: snd_soc_register_card failed (-517)

[  101.114161] davinci_evm ocp:sound: tlv320aic3x-hifi <-> 48038000.mcasp
mapping ok

 

-----------------------------------snip (2)

root@arm:/home/debian# aplay -l

**** List of PLAYBACK Hardware Devices ****

card 0: EVM [DA830 EVM], device 0: AIC3X tlv320aic3x-hifi-0 []

  Subdevices: 1/1

  Subdevice #0: subdevice #0

 

-----------------------------------snip (3)

root@arm:/home/debian# lsmod

Module                  Size  Used by

snd_soc_davinci_mcasp    14407  2

snd_soc_tlv320aic3x    40077  1

snd_soc_edma            1150  1 snd_soc_davinci_mcasp

snd_soc_evm             4802  0

snd_soc_omap            2573  1 snd_soc_davinci_mcasp

snd_soc_core          156839  5
snd_soc_davinci_mcasp,snd_soc_edma,snd_soc_omap,snd_soc_tlv320aic3x,snd_soc_
evm

snd_compress           11858  1 snd_soc_core

snd_pcm_dmaengine       5065  2 snd_soc_core,snd_soc_omap

snd_pcm                85645  5
snd_soc_davinci_mcasp,snd_soc_core,snd_soc_omap,snd_soc_tlv320aic3x,snd_pcm_
dmaengine

snd_timer              17058  1 snd_pcm

snd                    58469  4 snd_soc_core,snd_timer,snd_pcm,snd_compress

soundcore               6861  1 snd

omap_aes               13065  0

omap_sham              19198  0

tda998x                11695  1

tilcdc                 27899  0

omap_rng                4354  0

drm_kms_helper        106679  3 tda998x,tilcdc

rng_core                7266  1 omap_rng

uio_pdrv_genirq         3317  0

uio                     8350  1 uio_pdrv_genirq

leds_gpio               3110  0

 

-----------------------------------snip (4)

debian@arm:~$ aplay sine2s.wav

Playing WAVE 'sine2s.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo

[  618.068355] davinci-mcasp 48038000.mcasp: Transmit buffer underflow

underrun!!! (at least 0.410 ms long)

[  618.092511] davinci-mcasp 48038000.mcasp: Transmit buffer underflow

underrun!!! (at least 11.824 ms long)

[  618.121692] davinci-mcasp 48038000.mcasp: Transmit buffer underflow

underrun!!! (at least 3.200 ms long)

[  618.134323] davinci-mcasp 48038000.mcasp: Transmit buffer underflow
