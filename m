From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Wed, 27 Mar 2013 20:02:52 +0100
Message-ID: <5153425C.1090203@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F01C265283
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 20:02:46 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id y8so1753808bkt.38
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 12:02:46 -0700 (PDT)
In-Reply-To: <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
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

On 22.03.2013 17:05, Andreas Koch wrote:
> Hi all,
> 
> At 01:11 AM 3/22/2013, Daniel Mack wrote:
>> Hi Jussi,
>> Hi Andreas,
>>
>> On 21.03.2013 22:21, Jussi Laako wrote:
>>> On 03/18/2013 03:49 PM, Daniel Mack wrote:
>>>> Yes. If at all, we should add a SND_PCM_FORMAT_DSD, and a quirk for that
>>>> device. But given that there is no application for DSD in userspace
>>>> either, we probably don't need to care.
>>>
>>> Yes there is? At least my application. And I'd be happy to support any
>>> custom format created for the purpose... :)
>>
>> Ah, interesting. So what *are* you using right now for your transport in
>> userspace? Is your application abusing standard PCM interfaces that are
>> 'known' to be in fact DSD? How do other DACs expose their interfaces in
>> the Linux world, and which ones did you test your application with?
>>
>> If there's actual need for a new SND_PCM_FORMAT, it would be easy to
>> patch it through all the layers down to userspace.
>>
>>> I would propose to create custom 8-bit sample formats for DSD purposes,
>>> similar to the ASIO formats. Practically two main ones, byte with oldest
>>> bit in MSB and byte with oldest bit in LSB. And maybe the "DSD-wide" one
>>> which is 8-bit DSD sample.
>>
>> Andreas, which modes does the MPD-3 accept exactly on its two 'raw data'
>> interfaces? The only hint I have is that one of it is 8-bit and the
>> other is 16-bit, but given the lack of a proper test setup for this
>> format, I can't currently test anything.
> 
> The 8-bit raw format is for 2.8MHz DSD and the 16-bit format is for 
> 5.6MHz DSD. In both cases the driver sets the sample rate to 352.8kHz 
> on the DAC, but then sends either 8 bits or 16 bits depending on the 
> DSD rate. Since 11.2MHz DSD is already on the horizon we may have to 
> change this to a single 8-bit raw interface and then vary the 
> underlying USB transfer sample rate between 1x, 2x, 4x 352.8kHz - 
> that would be more logical and straight forward for the hardware 
> implementation. This is only supported through my own driver for the 
> Windows platform which uses the standard ASIO interface that supports 
> DSD at those rates. Since the Mac OS only supports PCM streams and 
> nothing else I brought together a bunch of DAC manufacturers and 
> playback software developers to standardize a method to "cannibalize" 
> the PCM stream for DSD data. The method is described in the attached 
> and is now supported by most manufacturers.
> This also has been implemented on a few Linux platforms (Auraliti for 
> instance). Even though the DoP standard works really well so far, it 
> is a "bandaid" and should only be used if there is no other choice. 
> If you guys are discussing implementing a dedicated data stream in 
> your driver for DSD, then I think this would be better and safer in the future.

Is there any official stable download location for this document which
we could link to from our documentation?


Thanks,
Daniel
