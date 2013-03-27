From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Wed, 27 Mar 2013 19:22:30 +0100
Message-ID: <515338E6.7080909@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
 <514E0A2A.1000201@sonarnerd.net>
 <7.0.0.16.2.20130323183543.0605ddb0@akdesigninc.com>
 <5151FDCD.2080103@gmail.com>
 <7.0.0.16.2.20130326224120.13b063e0@akdesigninc.com>
 <5152C089.5030707@gmail.com>
 <7.0.0.16.2.20130327080219.13b06900@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id CC31C2651D5
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 19:22:24 +0100 (CET)
Received: by mail-bk0-f46.google.com with SMTP id je9so1949698bkc.19
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 11:22:24 -0700 (PDT)
In-Reply-To: <7.0.0.16.2.20130327080219.13b06900@akdesigninc.com>
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

On 27.03.2013 16:08, Andreas Koch wrote:
> At 02:48 AM 3/27/2013, Daniel Mack wrote:
>> On 27.03.2013 06:50, Andreas Koch wrote:
>>> Hi Daniel
>>>
>>>> Ok. So we could define 3 DSD formats, for 8-bit, 16-bit and 32-bit. On
>>>> that three formats, arbitrary samples can be transported, and the
>>>> mapping between the configured sample rate and the resulting DSD rates
>>>> would be as follows (please tell me if I'm correct):
>>>>
>>>>         352.8kHz       705.6KHz    1411.2KHz
>>>>
>>>> 8-bit     2.8MHz         5.6MHz      11.2MHz
>>>> 16-bit    5.6MHz        11.2MHz
>>>> 32-bit   11.2MHz
>>>>
>>>> So driver would mark a stream as DSD capable (8, 16, 32bit, depending on
>>>> the USB descriptors), and then leave it up to the application to do the
>>>> sample frequency determination according to the above table, and also as
>>>> stated in the DoP document. Other drivers for more sound cards
>>>> (presumable on other bus types) might follow.
>>>>
>>>> I think it's ok to handle it like this, because after all, what an
>>>> application sets as sample rate for the stream is the number of actual
>>>> words that are transported, where as the DSD rate is referring to bits/s.
>>>>
>>>> Jussi, for your application, that means that you'd have to add these 3
>>>> new formats, and teach your application that they can be used for DSD
>>>> right away.
>>>>
>>>> The question is whether all DSD-capable USB DACs behave correctly in
>>>> order to make this logic work. Andreas?
>>>
>>> If I understand this correctly then your driver would send the DSD
>>> data in whatever format the DAC requests via its descriptors. The DSD
>>> rate would either control the word length (8,16,32) or the underlying
>>> sample rate (1x, 2x, 4x 352.8kHz). That would be the most flexible
>>> implementation and I don't see why any hardware implementation would
>>> have a problem with that.
>>
>> The question is whether all DACs would assume the same DSD rate as in
>> the table above (ie, 8-bit, 352.8kHz == 2.8MHz DSD).
> 
> I don't see how they could assume any different rate, so yes, that 
> seems a good assumption.

Ok, good.

>> And do we actually need a 32-bit format at all or is 8 and 16 enough?
> 
> Clearly, main stream is 2.8MHz DSD. But there are new A/D and D/A 
> chips becoming available that support up to  11.2MHz. So far I 
> haven't really seen any performance gain with that, but one  never 
> knows what improvements will be made in the future. If that is a 
> problem on your side I wouldn't spend so much time on it, but if it 
> is a matter of just adding a few lines then why not.

It a bit in a 64bit field, so its a limited resource. If there's no need
for it, I'll leave it out for now.

I'll send out some trivial patches for DSD stream marking soon.



Thanks,
Daniel
