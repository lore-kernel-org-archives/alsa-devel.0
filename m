From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Fri, 23 Oct 2015 17:40:27 +0800
Message-ID: <CAN8cciYnOMpp8eNjCidO2PAMuD1r1_L4ydQatHwNv=v53dJRxw@mail.gmail.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <561CA911.7070405@canonical.com>
 <96A12704CE18D347B625EE2D4A099D1974C304@SHSMSX103.ccr.corp.intel.com>
 <s5hlhb7ktum.wl-tiwai@suse.de>
 <CAN8cciZJ_YJhHEoU9HovR=P7FsxiKMDQ7johrmFGEWHQK_ZYNg@mail.gmail.com>
 <s5htwpuj6f5.wl-tiwai@suse.de>
 <CAN8cciYqLBH=kXvPjrGTgGPg9p7euU5w9z=UYdvKk4Vnxf-YFw@mail.gmail.com>
 <96A12704CE18D347B625EE2D4A099D1975281F@SHSMSX103.ccr.corp.intel.com>
 <56288783.1080503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 64F1A26155D
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 11:40:29 +0200 (CEST)
Received: by obctp1 with SMTP id tp1so62285245obc.2
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 02:40:28 -0700 (PDT)
In-Reply-To: <56288783.1080503@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "Yang, Libin" <libin.yang@intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "airlied@linux.ie" <airlied@linux.ie>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, Takashi Iwai <tiwai@suse.de>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "tanuk@iki.fi" <tanuk@iki.fi>
List-Id: alsa-devel@alsa-project.org

>>>>>
>>>>> Do it mean that only one DP MST port and no HDMI port on the
>>>
>>> same graphic
>>>>>
>>>>> card ?
>>>>
>>>>
>>>> No.
>>>
>>> If there is only one HDMI and one Display Port, this mean that there
>>> are two pin complexes
>>> How about the name of jack detection kctl of three Display Port
>>> monitors  which are created on the same pin complex but different
>>> dev_index ?
>>
>>
>> For the jack name, what do you think if we change to
>> "HDMI/DP, pin=n, dev=m" format? Will it impact on pulseaudio?
>
>
> Yes, it will impact PulseAudio. It will require changes to files in
>
>
http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths

Why do we use "hdmi" when MST is only supported by Display Port ?

https://bugs.freedesktop.org/show_bug.cgi?id=72795#c56

It seem the graphic driver use different name for HDMI and DP

DP1-1 , DP1-2 and DP1-3 , HDMI1
