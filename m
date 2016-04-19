From: Rick Mann <rmann@latencyzero.com>
Subject: Re: mcasp: stream has more channels (2) than are
	enabled in mcasp (0)
Date: Mon, 18 Apr 2016 17:48:45 -0700
Message-ID: <DD2BBA0B-9461-47EF-AF60-79E361CD2C1F@latencyzero.com>
References: <14D46C39-5FDF-40DD-A16B-2DA7BDE930CB@latencyzero.com>
 <5714FEE5.5070002@ti.com>
 <5D6815AB-B3DF-4F4F-BC0D-33612A202975@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id A856B265173
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 02:48:47 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id F04EF2096C
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 20:48:46 -0400 (EDT)
In-Reply-To: <5D6815AB-B3DF-4F4F-BC0D-33612A202975@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roderick Mann <rmann@latencyzero.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I forgot to add: I also added the dev_err() call to output "davinci_mcasp_probe: enter". This happens twice, you can find it in the full log at the pastebin (http://pastebin.com/HGhu9CPk).

[    8.220175] davinci-mcasp 48038000.mcasp: davinci_mcasp_probe: enter
[    8.268496] davinci-mcasp 48038000.mcasp: invalid tdm slots: 0
[    8.323405] davinci-mcasp 4803c000.mcasp: davinci_mcasp_probe: enter
[    8.339936] davinci-mcasp 4803c000.mcasp: invalid tdm slots: 0

> On Apr 18, 2016, at 08:36 , Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> Something goes wrong when the McASP is loaded for sure, some parameters did
> not got updated via DT perhaps, or most likely the DT fragment is loaded after
> the McASP is loaded.

The DT fragment that sets up clk_mcasp0 happens early during boot (http://pastebin.com/5vVEdAKt). The fragment that sets up the tlv320aic3104, and the serializer, and the sound card happens when I load the overlay (https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-BONE-AUDI-02-00A0.dts) after logging in. That's at around 33 seconds:

[   33.432680] bone_capemgr bone_capemgr: part_number 'BB-BONE-AUDI-02', version 'N/A'
[   33.432719] bone_capemgr bone_capemgr: slot #4: override
[   33.432736] bone_capemgr bone_capemgr: Using override eeprom data at slot 4
[   33.432752] bone_capemgr bone_capemgr: slot #4: 'Override Board Name,00A0,Override Manuf,BB-BONE-AUDI-02'
[   33.451729] bone_capemgr bone_capemgr: slot #4: dtbo 'BB-BONE-AUDI-02-00A0.dtbo' loaded; overlay id #0
[   33.462646] 2-0018 supply IOVDD not found, using dummy regulator
[   33.462722] 2-0018 supply DVDD not found, using dummy regulator
[   33.462779] 2-0018 supply AVDD not found, using dummy regulator
[   33.462822] 2-0018 supply DRVDD not found, using dummy regulator
[   33.484174] asoc-simple-card sound: tlv320aic3x-hifi <-> 48038000.mcasp mapping ok

> If McASP is built in, try to build it as module and load the audio modules
> after the DT fragments are handled.

I'm not sure how to do this. I do believe it's a module (when I modified the code and rebuilt, it rebuilt snd-soc-davinci-mcasp.ko, and I copied that over. It seems to load by default; not sure how to prevent that. If I move the clk_mcasp0 DT fragment out of the base DTB, things don't work correctly (I'm not sure why, but this is something I was told by Robert Nelson). I don't know if it's that initial fragment that causes the snd-soc-davinci-mcasp  module to load, or something else.

Thanks. Original reply follows:

----------------------------------

> On Apr 18, 2016, at 17:25 , Rick Mann <rmann@latencyzero.com> wrote:
> 
> 
>> On Apr 18, 2016, at 08:36 , Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> 
>> On 04/04/2016 11:59 AM, Rick Mann wrote:
>>> I've got a Beaglebone Green with a custom cape (CODEC and amp and some
>>> other stuff).
>>> 
>>> Kernel 4.4.6-bone-rt-r6. When I load the overlay that should set up my
>>> CODEC in the device tree, I get the following in the log.
>>> 
>>> [  367.172337] davinci-mcasp 48038000.mcasp: stream has more channels (2)
>>> than are enabled in mcasp (0) [  367.172374] davinci-mcasp 48038000.mcasp:
>>> ASoC: can't set 48038000.mcasp hw params: -22
>>> 
>>> You can see a little more log context, along with the DTS, here:
>>> 
>>> http://pastebin.com/UPB1xjPF
>>> 
>>> Can anyone tell me what this means? Thanks!
>> 
>> The fragment mostly looks OK, but am335x have 4 serializers, not 16 and the
>> num-serializer is deprecated at least in upstream kernel.
>> 
>> Something goes wrong when the McASP is loaded for sure, some parameters did
>> not got updated via DT perhaps, or most likely the DT fragment is loaded after
>> the McASP is loaded.
>> Can you print out:
>> slots, max_active_serializers, active_serializers and channels in
>> mcasp_common_hw_param() function?
>> Also just in case, can you put a dev_err() print in davinci_mcasp_probe() to
>> see when the driver is loaded compared to the time when the fragment is loaded?
>> 
>> If McASP is built in, try to build it as module and load the audio modules
>> after the DT fragments are handled.
> 
> Thanks for the suggestions, Peter, I really appreciate the help. Here's what I get:
> 
> [  256.743991] davinci-mcasp 48038000.mcasp: Slots: 2, max_active_serializers: 1, active_serializers: 0, channels: 2
> 
> I rebuilt the 4.4.7-bone-rt-r9 kernel using Robert C Nelson's bb-kernel repo scripts. I modified sound/soc/davinci/davinci-mcasp.c to print some diagnostics. Rebooted, then executed the following. Note that BB-BONE-AUDI-02.dts is <https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-BONE-AUDI-02-00A0.dts>, and the base DTB is <http://pastebin.com/5vVEdAKt>:
> 
> $ sudo su
> # echo BB-BONE-AUDI-02 > $SLOTS
> # aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: B [AudioCape Rev B], device 0: davinci-mcasp.0-tlv320aic3x-hifi tlv320aic3x-hifi-0 []
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
> # speaker-test 
> 
> speaker-test 1.0.28
> 
> Playback device is default
> Stream parameters are 48000Hz, S16_LE, 1 channels
> Using 16 octaves of pink noise
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 16 to 32768
> Period size range from 8 to 16384
> Using max buffer size 32768
> Periods = 4
> Unable to set hw params for playback: Invalid argument
> Setting of hwparams failed: Invalid argument
> 
> speaker-test caused the following to be logged:
> 
> [  256.743991] davinci-mcasp 48038000.mcasp: Slots: 2, max_active_serializers: 1, active_serializers: 0, channels: 2
> [  256.754343] davinci-mcasp 48038000.mcasp: ASoC: can't set 48038000.mcasp hw params: -22
> 
> 
> Full logs:
> 
> 	http://pastebin.com/HGhu9CPk
> 
> 
> 
> 
> -- 
> Rick Mann
> rmann@latencyzero.com
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Rick Mann
rmann@latencyzero.com
