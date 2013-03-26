From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Tue, 26 Mar 2013 20:58:05 +0100
Message-ID: <5151FDCD.2080103@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
 <514E0A2A.1000201@sonarnerd.net>
 <7.0.0.16.2.20130323183543.0605ddb0@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 55CEB2602C6
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 20:58:01 +0100 (CET)
Received: by mail-bk0-f41.google.com with SMTP id i18so33004bkv.0
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 12:57:59 -0700 (PDT)
In-Reply-To: <7.0.0.16.2.20130323183543.0605ddb0@akdesigninc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Koch <andreas@akdesigninc.com>
Cc: Jussi Laako <jussi@sonarnerd.net>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, alsa-devel@alsa-project.org, demian@auraliti.com, ray@auraliti.com
List-Id: alsa-devel@alsa-project.org

Hi Andreas,

On 24.03.2013 02:50, Andreas Koch wrote:
> At 01:01 PM 3/23/2013, Jussi Laako wrote:
>> On 03/22/2013 06:05 PM, Andreas Koch wrote:
>>> The 8-bit raw format is for 2.8MHz DSD and the 16-bit format is for
>>> 5.6MHz DSD. In both cases the driver sets the sample rate to 352.8kHz on
>>> the DAC,
>>
>> I see, this is different from how I've been dealing with it. Since I 
>> always use uint8 format, but instead vary the rate to 352.8/705.6/etc...
>>
>> Just because it's much more straightforward form the application's 
>> perspective -> output rate is always bit rate divided by eight 
>> (=packet rate). And switch between uint8 / uint32 sample format 
>> equals to switch between DSD <-> PCM.
> 
> Since the sample rate is defined on the interface level, not on the 
> alternate interface level, it becomes a problem to vary the sample 
> rate. For instance, for 5.6MHz DSD a sample rate of 705.6kHz would be 
> necessary with 8-bit data. But most likely the DAC will not support 
> that rate for PCM. If you plug that DAC into a Mac, the Mac will 
> automatically select 705.6kHz for PCM and then nothing will work 
> because the DAC doesn't support that in PCM. So then, the DAC would 
> have to define 2 complete interfaces: one for PCM and one for DSD. 
> That increases the size of the descriptor file (which can be a 
> problem with some hardware implementations) and increases the 
> overhead a bit during enumeration and sample rate queries. For the 
> hardware it is easier to bundle all into one single interface and 
> then define alternate interfaces for PCM and DSD.
> Just my 2 cents from the hardware perspective.

Ok. So we could define 3 DSD formats, for 8-bit, 16-bit and 32-bit. On
that three formats, arbitrary samples can be transported, and the
mapping between the configured sample rate and the resulting DSD rates
would be as follows (please tell me if I'm correct):

        352.8kHz       705.6KHz    1411.2KHz

8-bit     2.8MHz         5.6MHz      11.2MHz
16-bit    5.6MHz        11.2MHz
32-bit   11.2MHz

So driver would mark a stream as DSD capable (8, 16, 32bit, depending on
the USB descriptors), and then leave it up to the application to do the
sample frequency determination according to the above table, and also as
stated in the DoP document. Other drivers for more sound cards
(presumable on other bus types) might follow.

I think it's ok to handle it like this, because after all, what an
application sets as sample rate for the stream is the number of actual
words that are transported, where as the DSD rate is referring to bits/s.

Jussi, for your application, that means that you'd have to add these 3
new formats, and teach your application that they can be used for DSD
right away.

The question is whether all DSD-capable USB DACs behave correctly in
order to make this logic work. Andreas?


Thanks,
Daniel
