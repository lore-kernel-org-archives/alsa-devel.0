From: Jyri Sarha <jsarha@ti.com>
Subject: Re: BeagleBone with TLV320AIC3100
Date: Mon, 31 Oct 2016 11:29:33 +0200
Message-ID: <41a75384-611c-206d-9e2d-62b7952cc68a@ti.com>
References: <1786779841.1841022.1477904865509.ref@mail.yahoo.com>
 <1786779841.1841022.1477904865509@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 484462668D1
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2016 10:29:37 +0100 (CET)
In-Reply-To: <1786779841.1841022.1477904865509@mail.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai Riedel <kairiedel@yahoo.de>, alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, kai.riedel@turck.com
List-Id: alsa-devel@alsa-project.org

On 10/31/16 11:07, Kai Riedel wrote:
> Hi,
> 
> perhaps you could help me, I try to use a TLV320AIC3100 with the BeagleBoneBlack, kernel 4.4.28-bone14 and the dts file in the attachement. The dts file based on the instructions from Robert Nelson on https://github.com/beagleboard/bb.org-overlays. I have to uncomment the line clocks = <&clk_mcasp0>; in the dts file, because I get error otherwise. Enable the device with slots delivers:
> 
> [  386.783276] bone_capemgr bone_capemgr: part_number 'BB-BONE-AUDI-04', version 'N/A'
> [  386.791191] bone_capemgr bone_capemgr: slot #4: override
> [  386.796670] bone_capemgr bone_capemgr: Using override eeprom data at slot 4
> [  386.803724] bone_capemgr bone_capemgr: slot #4: 'Override Board Name,00A0,Override Manuf,BB-BONE-AUDI-04'
> [  386.847899] bone_capemgr bone_capemgr: slot #4: dtbo 'BB-BONE-AUDI-04-00A0.dtbo' loaded; overlay id #0
> [  386.876502] 2-0018 supply HPVDD not found, using dummy regulator
> [  386.891280] 2-0018 supply SPRVDD not found, using dummy regulator
> [  386.903157] 2-0018 supply SPLVDD not found, using dummy regulator
> [  386.910660] 2-0018 supply AVDD not found, using dummy regulator
> [  386.917471] 2-0018 supply IOVDD not found, using dummy regulator
> [  386.923560] 2-0018 supply DVDD not found, using dummy regulator
> [  386.932676] asoc-simple-card sound: tlv320aic31xx-hifi <-> 48038000.mcasp mapping ok
> 
> So I think this should be OK. In the alsamixer I can change the volume and on the I2C I see telegrams
> by changing the volume. But if I try to play sound with speaker-test I get errors again:
> 
>>
>>> speaker-test 1.0.28
>>>
>>> Playback device is default
>>> Stream parameters are 48000Hz, S16_LE, 1 channels
>>> Using 16 octaves of pink noise
>>> Rate set to 48000Hz (requested 48000Hz)
>>> Buffer size range from 16 to 32768
>>> Period size range from 8 to 16384
>>> Using max buffer size 32768
>>> Periods = 4
>>> Unable to set hw params for playback: Invalid argument
>>> Setting of hwparams failed: Invalid argument
>>
>> dmesg delivers:
>>> [  106.776874] Division by zero in kernel.
>>> [  106.780963] CPU: 0 PID: 606 Comm: speaker-test Tainted: G           O    4.4.28-bone14 #1
>>> [  106.789321] Hardware name: Generic AM33XX (Flattened Device Tree)
>>> [  106.795654] [<c0013e85>] (unwind_backtrace) from [<c0011f39>] (show_stack+0x11/0x14)
>>> [  106.803580] [<c0011f39>] (show_stack) from [<c037070f>] (Ldiv0+0x9/0x12)
>>> [  106.810510] [<c037070f>] (Ldiv0) from [<bf9952df>] (aic31xx_hw_params+0x96/0x370 [snd_soc_tlv320aic31xx])
>>> [  106.820849] [<bf9952df>] (aic31xx_hw_params [snd_soc_tlv320aic31xx]) from [<bf88d3bf>] (soc_dai_hw_params+0x16/0x34 [snd_soc_core])
> 
> Quite fatal error even because of division by zero in aic3 1xx_hw_params(). I guess it either doesn't validate its parameters or gets values that should not happen.
> 
> By the way with an original Audio_Cape_Rev B and Kernel 3.8.13 everything works fine. The TLV320AIC3100 is connected to the BeagleBone in the same way, but in the Kernel 3.8.13 is no support for this device so I have to use a Kernel >4.1.
> 

The tlv320aic31xx driver needs to know the frequency of clock singnal
used for mclk. Your current device tree does not offer any such clock or
clock frequency. The uninitialized 0-frequency causes the division by
zero error.

You need connect an mclk to aic3100 for it to work and you need to refer
to that clock or clock frequency in simple-card codec node.

The current aic3100 driver also has a severe limitations to what mclk
frequencies are supported. For the moment they are only multiples of
12.5 Mhz and 12 MHz, but once you tell me what frequency you have, I can
help you with adding the support.

BR,
Jyri



> Greetings,
> 
> Kai
> 
