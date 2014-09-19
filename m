From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Radeon unconnected HDMI eats samples at 280 kHz
Date: Fri, 19 Sep 2014 15:38:54 +0200
Message-ID: <541C31EE.4020101@canonical.com>
References: <54198F38.30002@canonical.com>	<5419FC9E.9010302@iki.fi>	<541A5BCD.2040105@canonical.com>
 <s5hlhph8jt5.wl-tiwai@suse.de> <541A8FA2.7090406@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D059929D9D@satlexdag05.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040304060506080103020403"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 39DDB264F8F
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 15:38:56 +0200 (CEST)
In-Reply-To: <A3397C8B8B789E45844E7EC5DEAD89D059929D9D@satlexdag05.amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Takashi Iwai <tiwai@suse.de>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040304060506080103020403
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2014-09-19 00:29, Deucher, Alexander wrote:
>>>> Well, if jack detection (get pin sense) works, there is.
>>>
>>> Does it react if we turn off the HDMI output via xrandr, too?
>>> I'm not sure whether we need reprogram things in that case, though...
>>
>> xrandr correctly reports that "HDMI-0" is disconnected.
>>
>> I'm not sure how to turn the HDMI output via xrandr, but I tried "xrandr
>> --output HDMI-0 --off" and it made no difference in either xrandr
>> output, nor in codec/eld output.
>>
>> What I'm thinking is that it could be that the monitor_present is
>> indicating the presence of my DVI monitor, as some cards are capable of
>> outputting HDMI audio on their DVI outputs (through a passive DVI->HDMI
>> adapter). This is just a guess though.
>
> I'm not that familiar with the audio side, but on there are registers on the gpu side that will change what is reported to the audio side as far as I can tell.  You might try the new hdmi patches I sent out today:
> http://lists.freedesktop.org/archives/dri-devel/2014-September/068544.html
> patch 5/5 is probably the most relevant for this discussion.  It explicitly clears the audio enable bit when the display is disabled which should cascade down to the audio side if I understand correctly.  If not, I think playing with the AZ_HOT_PLUG_CONTROL registers in that patch set can probably sort it out.

Thanks for the attention and the patches!

I compiled a 3.17-rc4 kernel plus the five patches. (I usually run the 
Ubuntu 3.13 kernel).

With this I saw that the jack reported "unplugged" when booting without 
an HDMI monitor, and that when the HDMI monitor was connected and got 
video output, the jack was now reported to be plugged in.
However, when I unplugged the monitor, the jack was still reported to be 
plugged in.

I also tried running a get_pin_sense verb manually and it still reported 
to be plugged in.

Also, I think it was the third time I plugged the monitor in, I got some 
type of GPU hang (see attached log). It never recovered by itself so I 
had to use SysRq to reboot the computer.

> I'm just not familiar enough with the azalia hw to know exactly how it's supposed to interact with the audio side.

Well, feel free to ask questions if you think we can answer them :-)

The bits that say PIN*_JACK_DETECTION_ENABLE and 
PIN*_UNSOLICITED_RESPONSE_ENABLE sounds like things that should be 
turned on all the time so we can properly get unsol jack detection 
events when the monitor is plugged or unplugged. Unless the 
PIN*_JACK_DETECTION_ENABLE actually represents the current state rather 
than the detection capability. But that's just guesses, as I assume the 
specs are not released?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------040304060506080103020403
Content-Type: text/plain; charset=UTF-8;
 name="gpu-hang.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gpu-hang.txt"

Sep 19 14:56:23 david-desktop colord: Automatic metadata add icc-0bd271b6f2ece9bf0a1fe82805c29d74 to xrandr-CVTE TV
Sep 19 14:56:23 david-desktop colord: Device added: xrandr-CVTE TV
Sep 19 14:57:11 david-desktop kernel: [  162.034771] [drm:drm_edid_block_valid] *ERROR* EDID checksum is invalid, remainder is 130
Sep 19 14:57:11 david-desktop kernel: [  162.034780] Raw EDID:
Sep 19 14:57:11 david-desktop kernel: [  162.034786]  	00 ff ff ff ff ff ff 00 ff ff ff ff ff ff ff ff
Sep 19 14:57:11 david-desktop kernel: [  162.034790]  	ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Sep 19 14:57:11 david-desktop kernel: [  162.034794]  	ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Sep 19 14:57:11 david-desktop kernel: [  162.034798]  	ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Sep 19 14:57:11 david-desktop kernel: [  162.034801]  	ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Sep 19 14:57:11 david-desktop kernel: [  162.034804]  	ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Sep 19 14:57:11 david-desktop kernel: [  162.034808]  	ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Sep 19 14:57:11 david-desktop kernel: [  162.034811]  	ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Sep 19 14:57:11 david-desktop kernel: [  162.035933] [drm:radeon_dvi_detect] *ERROR* HDMI-A-1: probed a monitor but no|invalid EDID
Sep 19 14:58:14 david-desktop kernel: [  224.787757] [drm:drm_edid_block_valid] *ERROR* EDID checksum is invalid, remainder is 136
Sep 19 14:58:22 david-desktop colord: device removed: xrandr-CVTE TV
Sep 19 15:14:14 david-desktop colord: Automatic metadata add icc-0bd271b6f2ece9bf0a1fe82805c29d74 to xrandr-CVTE TV
Sep 19 15:14:14 david-desktop colord: Device added: xrandr-CVTE TV
Sep 19 15:14:24 david-desktop kernel: [ 1194.816168] radeon 0000:01:00.0: ring 0 stalled for more than 10052msec
Sep 19 15:14:24 david-desktop kernel: [ 1194.816184] radeon 0000:01:00.0: GPU lockup (waiting for 0x0000000000006f5b last fence id 0x0000000000006f51 on ring 0)
Sep 19 15:14:24 david-desktop kernel: [ 1194.816191] radeon 0000:01:00.0: ring 0 stalled for more than 10052msec
Sep 19 15:14:24 david-desktop kernel: [ 1194.816200] radeon 0000:01:00.0: GPU lockup (waiting for 0x0000000000006f5b last fence id 0x0000000000006f51 on ring 0)
Sep 19 15:14:24 david-desktop kernel: [ 1194.839669] radeon 0000:01:00.0: Saved 1145 dwords of commands on ring 0.
Sep 19 15:14:24 david-desktop kernel: [ 1194.839688] radeon 0000:01:00.0: GPU softreset: 0x00000008
Sep 19 15:14:24 david-desktop kernel: [ 1194.839696] radeon 0000:01:00.0:   R_008010_GRBM_STATUS      = 0xA0003028
Sep 19 15:14:24 david-desktop kernel: [ 1194.839702] radeon 0000:01:00.0:   R_008014_GRBM_STATUS2     = 0x00000002
Sep 19 15:14:24 david-desktop kernel: [ 1194.839708] radeon 0000:01:00.0:   R_000E50_SRBM_STATUS      = 0x200000C0
Sep 19 15:14:24 david-desktop kernel: [ 1194.839713] radeon 0000:01:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
Sep 19 15:14:24 david-desktop kernel: [ 1194.839718] radeon 0000:01:00.0:   R_008678_CP_STALLED_STAT2 = 0x00010002
Sep 19 15:14:24 david-desktop kernel: [ 1194.839723] radeon 0000:01:00.0:   R_00867C_CP_BUSY_STAT     = 0x00020182
Sep 19 15:14:24 david-desktop kernel: [ 1194.839729] radeon 0000:01:00.0:   R_008680_CP_STAT          = 0x80038647
Sep 19 15:14:24 david-desktop kernel: [ 1194.839734] radeon 0000:01:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
Sep 19 15:14:25 david-desktop kernel: [ 1194.916762] radeon 0000:01:00.0: R_008020_GRBM_SOFT_RESET=0x00004001
Sep 19 15:14:25 david-desktop kernel: [ 1194.916819] radeon 0000:01:00.0: SRBM_SOFT_RESET=0x00000100
Sep 19 15:14:25 david-desktop kernel: [ 1194.918911] radeon 0000:01:00.0:   R_008010_GRBM_STATUS      = 0x00003028
Sep 19 15:14:25 david-desktop kernel: [ 1194.918917] radeon 0000:01:00.0:   R_008014_GRBM_STATUS2     = 0x00000002
Sep 19 15:14:25 david-desktop kernel: [ 1194.918922] radeon 0000:01:00.0:   R_000E50_SRBM_STATUS      = 0x200000C0
Sep 19 15:14:25 david-desktop kernel: [ 1194.918927] radeon 0000:01:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
Sep 19 15:14:25 david-desktop kernel: [ 1194.918932] radeon 0000:01:00.0:   R_008678_CP_STALLED_STAT2 = 0x00000000
Sep 19 15:14:25 david-desktop kernel: [ 1194.918938] radeon 0000:01:00.0:   R_00867C_CP_BUSY_STAT     = 0x00000000
Sep 19 15:14:25 david-desktop kernel: [ 1194.918943] radeon 0000:01:00.0:   R_008680_CP_STAT          = 0x00000000
Sep 19 15:14:25 david-desktop kernel: [ 1194.918948] radeon 0000:01:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
Sep 19 15:14:25 david-desktop kernel: [ 1194.918960] radeon 0000:01:00.0: GPU reset succeeded, trying to resume
Sep 19 15:14:25 david-desktop kernel: [ 1194.935955] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
Sep 19 15:14:25 david-desktop kernel: [ 1194.937152] [drm] PCIE GART of 1024M enabled (table at 0x000000000025D000).
Sep 19 15:14:25 david-desktop kernel: [ 1194.937170] radeon 0000:01:00.0: WB enabled
Sep 19 15:14:25 david-desktop kernel: [ 1194.937175] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000020000c00 and cpu addr 0xffff880035a88c00
Sep 19 15:14:25 david-desktop kernel: [ 1194.937179] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000020000c0c and cpu addr 0xffff880035a88c0c
Sep 19 15:14:25 david-desktop kernel: [ 1194.937606] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x000000000005c598 and cpu addr 0xffffc90010c9c598
Sep 19 15:14:25 david-desktop kernel: [ 1194.983369] [drm] ring test on 0 succeeded in 1 usecs
Sep 19 15:14:25 david-desktop kernel: [ 1194.983434] [drm] ring test on 3 succeeded in 1 usecs
Sep 19 15:14:25 david-desktop kernel: [ 1195.168039] [drm] ring test on 5 succeeded in 1 usecs
Sep 19 15:14:25 david-desktop kernel: [ 1195.168064] [drm] UVD initialized successfully.
Sep 19 15:14:35 david-desktop kernel: [ 1205.166422] radeon 0000:01:00.0: ring 0 stalled for more than 10000msec
Sep 19 15:14:35 david-desktop kernel: [ 1205.166435] radeon 0000:01:00.0: GPU lockup (waiting for 0x0000000000006f75 last fence id 0x0000000000006f51 on ring 0)
Sep 19 15:14:35 david-desktop kernel: [ 1205.166451] [drm:r600_ib_test] *ERROR* radeon: fence wait failed (-35).
Sep 19 15:14:35 david-desktop kernel: [ 1205.166460] [drm:radeon_ib_ring_tests] *ERROR* radeon: failed testing IB on GFX ring (-35).
Sep 19 15:14:35 david-desktop kernel: [ 1205.166466] radeon 0000:01:00.0: ib ring test failed (-35).
Sep 19 15:14:35 david-desktop kernel: [ 1205.188427] radeon 0000:01:00.0: GPU softreset: 0x00000008
Sep 19 15:14:35 david-desktop kernel: [ 1205.188438] radeon 0000:01:00.0:   R_008010_GRBM_STATUS      = 0xA0003028
Sep 19 15:14:35 david-desktop kernel: [ 1205.188444] radeon 0000:01:00.0:   R_008014_GRBM_STATUS2     = 0x00000002
Sep 19 15:14:35 david-desktop kernel: [ 1205.188450] radeon 0000:01:00.0:   R_000E50_SRBM_STATUS      = 0x200000C0
Sep 19 15:14:35 david-desktop kernel: [ 1205.188455] radeon 0000:01:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
Sep 19 15:14:35 david-desktop kernel: [ 1205.188460] radeon 0000:01:00.0:   R_008678_CP_STALLED_STAT2 = 0x00010002
Sep 19 15:14:35 david-desktop kernel: [ 1205.188465] radeon 0000:01:00.0:   R_00867C_CP_BUSY_STAT     = 0x00000002
Sep 19 15:14:35 david-desktop kernel: [ 1205.188471] radeon 0000:01:00.0:   R_008680_CP_STAT          = 0x80018647
Sep 19 15:14:35 david-desktop kernel: [ 1205.188476] radeon 0000:01:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
Sep 19 15:14:35 david-desktop kernel: [ 1205.238203] radeon 0000:01:00.0: R_008020_GRBM_SOFT_RESET=0x00004001
Sep 19 15:14:35 david-desktop kernel: [ 1205.238260] radeon 0000:01:00.0: SRBM_SOFT_RESET=0x00000100
Sep 19 15:14:35 david-desktop kernel: [ 1205.240351] radeon 0000:01:00.0:   R_008010_GRBM_STATUS      = 0x00003028
Sep 19 15:14:35 david-desktop kernel: [ 1205.240357] radeon 0000:01:00.0:   R_008014_GRBM_STATUS2     = 0x00000002
Sep 19 15:14:35 david-desktop kernel: [ 1205.240362] radeon 0000:01:00.0:   R_000E50_SRBM_STATUS      = 0x200000C0
Sep 19 15:14:35 david-desktop kernel: [ 1205.240367] radeon 0000:01:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
Sep 19 15:14:35 david-desktop kernel: [ 1205.240372] radeon 0000:01:00.0:   R_008678_CP_STALLED_STAT2 = 0x00000000
Sep 19 15:14:35 david-desktop kernel: [ 1205.240377] radeon 0000:01:00.0:   R_00867C_CP_BUSY_STAT     = 0x00000000
Sep 19 15:14:35 david-desktop kernel: [ 1205.240382] radeon 0000:01:00.0:   R_008680_CP_STAT          = 0x00000000
Sep 19 15:14:35 david-desktop kernel: [ 1205.240388] radeon 0000:01:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
Sep 19 15:14:35 david-desktop kernel: [ 1205.240398] radeon 0000:01:00.0: GPU reset succeeded, trying to resume
Sep 19 15:14:35 david-desktop kernel: [ 1205.243106] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
Sep 19 15:14:35 david-desktop kernel: [ 1205.244289] [drm] PCIE GART of 1024M enabled (table at 0x000000000025D000).
Sep 19 15:14:35 david-desktop kernel: [ 1205.244314] radeon 0000:01:00.0: WB enabled
Sep 19 15:14:35 david-desktop kernel: [ 1205.244324] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000020000c00 and cpu addr 0xffff880035a88c00
Sep 19 15:14:35 david-desktop kernel: [ 1205.244332] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000020000c0c and cpu addr 0xffff880035a88c0c
Sep 19 15:14:35 david-desktop kernel: [ 1205.245036] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x000000000005c598 and cpu addr 0xffffc90010c9c598
Sep 19 15:14:35 david-desktop kernel: [ 1205.290816] [drm] ring test on 0 succeeded in 1 usecs
Sep 19 15:14:35 david-desktop kernel: [ 1205.290881] [drm] ring test on 3 succeeded in 1 usecs
Sep 19 15:14:35 david-desktop kernel: [ 1205.465562] [drm] ring test on 5 succeeded in 1 usecs
Sep 19 15:14:35 david-desktop kernel: [ 1205.465573] [drm] UVD initialized successfully.
Sep 19 15:14:35 david-desktop kernel: [ 1205.465626] [drm] ib test on ring 0 succeeded in 0 usecs
Sep 19 15:14:35 david-desktop kernel: [ 1205.465684] [drm] ib test on ring 3 succeeded in 1 usecs
Sep 19 15:14:45 david-desktop kernel: [ 1215.620652] radeon 0000:01:00.0: ring 5 stalled for more than 10000msec
Sep 19 15:14:45 david-desktop kernel: [ 1215.620664] radeon 0000:01:00.0: GPU lockup (waiting for 0x0000000000000004 last fence id 0x0000000000000002 on ring 5)
Sep 19 15:14:45 david-desktop kernel: [ 1215.620671] [drm:uvd_v1_0_ib_test] *ERROR* radeon: fence wait failed (-35).
Sep 19 15:14:45 david-desktop kernel: [ 1215.620678] [drm:radeon_ib_ring_tests] *ERROR* radeon: failed testing IB on ring 5 (-35).


--------------040304060506080103020403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040304060506080103020403--
