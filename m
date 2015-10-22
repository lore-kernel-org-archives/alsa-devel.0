From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Thu, 22 Oct 2015 09:27:51 +0200
Message-ID: <56288FF7.9030400@canonical.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <561CA911.7070405@canonical.com>
 <96A12704CE18D347B625EE2D4A099D1974C304@SHSMSX103.ccr.corp.intel.com>
 <s5hlhb7ktum.wl-tiwai@suse.de>
 <CAN8cciZJ_YJhHEoU9HovR=P7FsxiKMDQ7johrmFGEWHQK_ZYNg@mail.gmail.com>
 <s5htwpuj6f5.wl-tiwai@suse.de>
 <CAN8cciYqLBH=kXvPjrGTgGPg9p7euU5w9z=UYdvKk4Vnxf-YFw@mail.gmail.com>
 <96A12704CE18D347B625EE2D4A099D1975281F@SHSMSX103.ccr.corp.intel.com>
 <56288783.1080503@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19753A2D@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 350F12606F9
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 09:27:46 +0200 (CEST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D19753A2D@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>, Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "tanuk@iki.fi" <tanuk@iki.fi>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org



On 2015-10-22 08:56, Yang, Libin wrote:
>
>> -----Original Message-----
>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>> Sent: Thursday, October 22, 2015 2:52 PM
>> To: Yang, Libin; Raymond Yau; Takashi Iwai
>> Cc: airlied@linux.ie; tanuk@iki.fi; Lin, Mengdong; Girdwood, Liam R;
>> ALSA Development Mailing List
>> Subject: Re: [alsa-devel] DP1.2 MST audio support discussion
>>
>>
>>
>> On 2015-10-22 03:31, Yang, Libin wrote:
>>> Hi Raymond,
>>>
>>>>
>>>> From: Raymond Yau [mailto:superquad.vortex2@gmail.com]
>>>> Sent: Friday, October 16, 2015 8:33 AM
>>>> To: Takashi Iwai
>>>> Cc: airlied@linux.ie; tanuk@iki.fi; David Henningsson; Yang, Libin;
>> Lin,
>>>> Mengdong; Girdwood, Liam R; ALSA Development Mailing List
>>>> Subject: Re: [alsa-devel] DP1.2 MST audio support discussion
>>>>
>>>>
>>>>>>
>>>>>> Do it mean that only one DP MST port and no HDMI port on the
>>>> same graphic
>>>>>> card ?
>>>>>
>>>>> No.
>>>> If there is only one HDMI and one Display Port, this mean that there
>>>> are two pin complexes
>>>> How about the name of jack detection kctl of three Display Port
>>>> monitors  which are created on the same pin complex but different
>>>> dev_index ?
>>>
>>> For the jack name, what do you think if we change to
>>> "HDMI/DP, pin=n, dev=m" format? Will it impact on pulseaudio?
>>
>> Yes, it will impact PulseAudio. It will require changes to files in
>>
>> http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/
>> alsa/mixer/paths
>
> So does this mean we should not change the name "HDMI/DP,pcm=3 Jack"
> to "HDMI/DP,pin=n, dev=m Jack", otherwise the old PA will not work with
> the new driver?

Yes. And I don't understand why you need to do it, either - if you have 
three display port monitors on one pin, then they will all get different 
PCMs (8, 9 and 10), and they will signal their Jack status through 
"HDMI/DP,pcm=8 Jack", "HDMI/DP,pcm=9 Jack" and "HDMI/DP,pcm=10 Jack".

Given that my proposed mapping algorithm will never change pin to PCM 
mapping (unless you have two displayport outputs and use MST on both), I 
think we can get away with not exposing the actual pin to userspace.
And should this later become necessary, we can add a separate kctl for that.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
