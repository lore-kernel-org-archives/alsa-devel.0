From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Radeon unconnected HDMI eats samples at 280 kHz
Date: Mon, 22 Sep 2014 16:39:17 +0200
Message-ID: <54203495.60903@canonical.com>
References: <54198F38.30002@canonical.com>	<5419FC9E.9010302@iki.fi>	<541A5BCD.2040105@canonical.com>
 <s5hlhph8jt5.wl-tiwai@suse.de> <541A8FA2.7090406@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D059929D9D@satlexdag05.amd.com>
 <541C31EE.4020101@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992A81C@satlexdag05.amd.com>
 <541C6C23.1040403@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992AB48@satlexdag05.amd.com>
 <541CC506.601@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992B6A6@satlexdag05.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 87DA42602AD
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 16:39:20 +0200 (CEST)
In-Reply-To: <A3397C8B8B789E45844E7EC5DEAD89D05992B6A6@satlexdag05.amd.com>
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



On 2014-09-22 14:46, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>> Sent: Friday, September 19, 2014 8:07 PM
>> To: Deucher, Alexander; Takashi Iwai
>> Cc: Anssi Hannula; alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] Radeon unconnected HDMI eats samples at 280 kHz
>>
>> Btw, is there a register dump utility I could use to get the current
>> register value, e g by reading sysfs or procfs? It could be interesting
>> to see if anything we do on the audio side would affect this register.
>
> You can use the radeonreg tool to dump registers:
> http://cgit.freedesktop.org/~airlied/radeontool

Thanks, I have now tried this, together with the kernel from 
drm-next-3.18-wip.

 From your patches it looks like I should look at the dumped register 
0x7300, is that correct?

At boot up, this register is 001000f0. (Out of curiousity, I tried 
disabling unsol events from the audio side, but this did not change the 
register.)
After HDMI plug in, the register changed to 0x8f1000f0, the jack 
reported being plugged in, and audio worked.

After HDMI unplugged again, the register remained at 0x8f1000f0, and 
"xrandr --output HDMI-0 --off" did not help.

However, when looking at your code, I also spotted something in the 
patch called "disable audio when we disable hdmi":

if (!enable && dig->afmt->pin) {
     r600_audio_enable(rdev, dig->afmt->pin, 0xf);
                                             ^^^
If enable is false, should we not set the last parameter to 0 instead of 
0xf?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
