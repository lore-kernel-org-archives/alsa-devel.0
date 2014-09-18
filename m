From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Radeon unconnected HDMI eats samples at 280 kHz
Date: Thu, 18 Sep 2014 06:13:01 +0200
Message-ID: <541A5BCD.2040105@canonical.com>
References: <54198F38.30002@canonical.com> <5419FC9E.9010302@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050909080207070200060106"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 51728265141
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 06:13:04 +0200 (CEST)
In-Reply-To: <5419FC9E.9010302@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Alex Deucher <alexander.deucher@amd.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050909080207070200060106
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 2014-09-17 23:26, Anssi Hannula wrote:
> 17.09.2014, 16:40, David Henningsson kirjoitti:
>> Hi,
>
> Hi,
>
>> While investigating some interesting debug output from PulseAudio, I
>> tried to figure out the cause.
>>
>>   From what I can tell, my Radeon seems to ask for new samples at a very
>> high rate, which I estimate to be around 280 kHz. My radeon card has
>> DVI, HDMI and VGA connectors, and the only thing connected is my screen
>> over DVI.
>>
>> I'm currently running the 3.13 kernel with updated hda directory from
>> Takashi's tree, but I think it's been this way for a long time.
>>
>> Note that if a screen is connected to the HDMI card, the problem
>> disappears and sample rates are normal.
>> In short, do you think this is a driver bug, or just something we have
>> to live with as some sort of hw anomaly?
>> Since nothing is connected, it does not really hurt, except PulseAudio
>> gets confused (in a way that could potentially cause problems for
>> low-latency output, should something be connected later on).
>
> Not sure.
> IIRC, unlike the other gpus, on radeon the video driver needs to
> "manually" set sample rate dividers/etc based on the pixel clock rate,
> so I guess this might mean we can't have a proper audio clock without
> enabled video...
>
> Alex, any thoughts/info?
>
>
> If this is the case, it would probably be best if we prevented opening
> the device when output is not active (unless this causes some other
> issues), but I guess there is currently no easy way for the _audio_
> driver to know that...

Well, if jack detection (get pin sense) works, there is. There are two 
major problems with that though:

1) When I look right here and now, it seems like jack detection returns 
"plugged in" status, and ELD info reports monitor_present=1, 
eld_valid=0. So pin sense isn't really working (or maybe it reports that 
my DVI monitor is plugged in, which isn't helpful here). I'm attaching 
codec proc info in case it's helpful.

2) It requires major work in PulseAudio to make sure we re-probe the 
HDMI device when it is plugged in. We should do that anyway, it's just 
that it is quite some work to do, and noone has done it yet.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------050909080207070200060106
Content-Type: text/plain; charset=UTF-8;
 name="codec.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="codec.txt"

Codec: ATI R6xx HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x70]: 32000 44100 48000
    bits [0x2]: 16
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
  Converter: stream=1, channel=0
  Digital: Enabled GenLevel
  Digital category: 0x2
  IEC Coding Type: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x02

--------------050909080207070200060106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050909080207070200060106--
