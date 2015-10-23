From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Fri, 23 Oct 2015 13:08:26 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84B863318@shsmsx102.ccr.corp.intel.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <561CA911.7070405@canonical.com>
 <96A12704CE18D347B625EE2D4A099D1974C304@SHSMSX103.ccr.corp.intel.com>
 <s5hlhb7ktum.wl-tiwai@suse.de>
 <CAN8cciZJ_YJhHEoU9HovR=P7FsxiKMDQ7johrmFGEWHQK_ZYNg@mail.gmail.com>
 <s5htwpuj6f5.wl-tiwai@suse.de>
 <CAN8cciYqLBH=kXvPjrGTgGPg9p7euU5w9z=UYdvKk4Vnxf-YFw@mail.gmail.com>
 <96A12704CE18D347B625EE2D4A099D1975281F@SHSMSX103.ccr.corp.intel.com>
 <56288783.1080503@canonical.com>
 <CAN8cciYnOMpp8eNjCidO2PAMuD1r1_L4ydQatHwNv=v53dJRxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 76275261734
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 15:08:31 +0200 (CEST)
In-Reply-To: <CAN8cciYnOMpp8eNjCidO2PAMuD1r1_L4ydQatHwNv=v53dJRxw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, David Henningsson <david.henningsson@canonical.com>
Cc: "Yang, Libin" <libin.yang@intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "airlied@linux.ie" <airlied@linux.ie>, Takashi Iwai <tiwai@suse.de>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "tanuk@iki.fi" <tanuk@iki.fi>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
>From: Raymond Yau [mailto:superquad.vortex2@gmail.com] 
>Sent: Friday, October 23, 2015 5:40 PM

>>> For the jack name, what do you think if we change to
>>> "HDMI/DP, pin=n, dev=m" format? Will it impact on pulseaudio?
>>
>>
>>Yes, it will impact PulseAudio. It will require changes to files in
>>
>> http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths
>Why do we use "hdmi" when MST is only supported by Display Port ?
>https://bugs.freedesktop.org/show_bug.cgi?id=72795#c56
>It seem the graphic driver use different name for HDMI and DP
>DP1-1 , DP1-2 and DP1-3 , HDMI1

Maybe I cannot give the best answer.

I feel there can be two reasons:
- HDMI came to the market earlier than DP. So the name "hdmi" is used at first.
- For GFX, the difference between HDMI and DP processing sequence is big. 
  But for audio, there is little difference. In audio driver, DP and HDMI pins are handled in the same way, probably the only difference is the audio infoframe format.
  And this reflects the HW: audio codec is only a GPU interface to feed audio data to its display pipelines. And GPU mixes the audio and video and translate the stream to different formats for HDMI and DP. 

Thanks
Mengdong
