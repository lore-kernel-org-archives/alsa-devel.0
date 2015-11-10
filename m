From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Tue, 10 Nov 2015 08:45:12 +0100
Message-ID: <5641A088.50609@canonical.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D1975281F@SHSMSX103.ccr.corp.intel.com>
 <56288783.1080503@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19753A2D@SHSMSX103.ccr.corp.intel.com>
 <56288FF7.9030400@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19753A91@SHSMSX103.ccr.corp.intel.com>
 <5628A3EB.8050306@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F84B862A5B@shsmsx102.ccr.corp.intel.com>
 <562A1237.2090909@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F84B8632DF@shsmsx102.ccr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D19755BE7@SHSMSX103.ccr.corp.intel.com>
 <s5hvb9or3zj.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D197574CE@SHSMSX103.ccr.corp.intel.com>
 <563716D7.3000502@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19765611@SHSMSX103.ccr.corp.intel.com>
 <563B1C37.4010400@canonical.com>
 <96A12704CE18D347B625EE2D4A099D197786EB@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DA278260522
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 08:45:15 +0100 (CET)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D197786EB@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, "airlied@linux.ie" <airlied@linux.ie>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Lu, Han" <han.lu@intel.com>, Raymond Yau <superquad.vortex2@gmail.com>, "tanuk@iki.fi" <tanuk@iki.fi>
List-Id: alsa-devel@alsa-project.org



On 2015-11-10 07:46, Yang, Libin wrote:
> Hi David,
>
>
>> -----Original Message-----
>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>> Sent: Thursday, November 05, 2015 5:07 PM
>> To: Yang, Libin; Takashi Iwai
>> Cc: Lin, Mengdong; Raymond Yau; airlied@linux.ie; tanuk@iki.fi; ALSA
>> Development Mailing List; Girdwood, Liam R; Lu, Han; Nikula, Jani
>> Subject: Re: [alsa-devel] DP1.2 MST audio support discussion
>>
>>
>>
>> So I'm asking my question again. What would happen (on Intel hardware),
>> if you stream audio to a converter node on the audio codec, and there is
>> no pin node connected to that converter node?
>
> I changed the audio driver and did the test today. The test is:
> 1. Pin 5 connect to converter 2 and playback, there is sound from pin 5.
> 2. Pin 5 connect to converter 2 (no other pin is connected to cvt2), no sound.
> 3. Pin 5 connect back to cvt 2, there is sound, playback is normal.
>
> And in step 2, the playback is still ongoing but no sound is out from any pin.

Sounds good to me, thanks for testing. Is this workaround something we 
could utilize in order to not break userspace? (This is a question for 
both you and Takashi.)

What we'll end up is essentially three types of objects:

  * PCM device (5 devices, 3,7,8,9,10)
   - all five devices are allocated when the driver initializes
   - all kcontrols are always bound to the PCM device (jack kctl, eld 
kctl, iec958 kctls etc)

  * Monitor (pin + MST index)
   - dynamically bound to a PCM at monitor plug-in time, according to a 
scheme that maximises the possibility for a monitor to always end up at 
the same PCM (as specified in earlier emails)

  * Converter node (3 nodes for Intel hardware)
    - dynamically bound to a PCM at playback open time (regardless of 
whether the PCM has a monitor or not)
    - return -EBUSY in case there is no free converter node


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
