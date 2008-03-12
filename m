From: Ben Firshman <ben@firshman.co.uk>
Subject: Re: Hda-intel: AC_VERB_SET_PIN_WIDGET_CONTROL
	appears	to do nothing for HDMI device
Date: Wed, 12 Mar 2008 18:40:23 +0000
Message-ID: <CB22E86A-88D1-422E-B1C4-B04F7DD19716@firshman.co.uk>
References: <0617DD65-FC77-47C7-922E-FD9202375816@firshman.co.uk>
	<0E87486E-FCE3-49CB-AB88-343FB6FB468E@firshman.co.uk>
	<s5h63vrajo1.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.firshman.co.uk (unknown [81.2.121.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 303AF103883
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 19:40:26 +0100 (CET)
In-Reply-To: <s5h63vrajo1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12 Mar 2008, at 18:20, Takashi Iwai wrote:

> At Sun, 9 Mar 2008 13:05:39 +0000,
> Ben Firshman wrote:
>>
>> It appears that on boot, nothing gets set, but if I reload the module
>> it works:
>>
>> ben@mythfrontend:~$ cat /proc/asound/card0/codec#1
>> Codec: Generic 1095 SI1390 HDMI
>> Address: 1
>> Vendor Id: 0x10951390
>> Subsystem Id: 0xffffffff
>> Revision Id: 0x100000
>> No Modem Function Group found
>> Default PCM:
>>     rates [0x0]:
>>     bits [0x0]:
>>     formats [0x0]:
>> Default Amp-In caps: N/A
>> Default Amp-Out caps: N/A
>> GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
>> Node 0x02 [Audio Output] wcaps 0x6211: Stereo Digital
>>   Converter: stream=0, channel=0
>>   Digital: Enabled Copyright GenLevel
>>   Digital category: 0x0
>>   PCM:
>>     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>>     bits [0x1e]: 16 20 24 32
>>     formats [0x5]: PCM AC3
>> Node 0x03 [Pin Complex] wcaps 0x40738d: Stereo Digital Amp-Out
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x00 0x00]
>>   Pincap 0x0894: OUT Detect R/L
>>   Pin Default 0x98460010: [Fixed] SPDIF Out at Int HDMI
>>     Conn = Digital, Color = Unknown
>>     DefAssociation = 0x1, Sequence = 0x0
>>   Pin-ctls: 0x40: OUT
>>   Unsolicited: tag=00, enabled=0
>>   Connection: 1
>>      0x02
>> ben@mythfrontend:~$
>>
>> The unmuting looks like it's working too (Amp-Out vals:  [0x00  
>> 0x00]).
>> I'm still not getting any sound though - my amp just says
>> "Detecting...".
>>
>> Is the GPIO line significant? As far as I can tell from the docs,  
>> that
>> just means there are no GPIOs.
>
> I don't think it's GPIO.  Which graphic chip is on AppleTV?
> if it's Nvidia, we have little chance.  But, if it's an Intel
> on-board, it might work.  Some people reported HDMI works in a certain
> level (not perfectly at all though).
>
> Anyway, you can try my latest tree available at git.kernel.org
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound- 
> unstable-2.6.git
> and
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver- 
> build-unstable.git
>
> The former is the kernel tree and the latter is alsa-driver build
> tree.  Run utils/setup-alsa-kernel KERNEL_DIR on alsa-driver tree to
> set up the build with sound-unstable kernel git tree (see INSTALL for
> details).
>
> The ready-to-be-built snapshot tarball is available at
>   http://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/
>

Yeah, it's a Nvidia chip:

http://wiki.awkwardtv.org/wiki/Parts

Why do you have little chance then? Surely the Nvidia chip is  
independent of the HDMI chip, which is in turn independent of the  
sound card? Video out over HDMI works fine with the nv binary drivers  
you see.

Ben
