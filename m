From: Daniel Mack <zonque@gmail.com>
Subject: Support for DSD streams (was: Re: [PATCH 0/3] ALSA:
 snd-usb: Some small fixes to make Playback Design products work)
Date: Sat, 23 Mar 2013 12:50:46 +0100
Message-ID: <514D9716.4000801@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id BBE74265264
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 12:50:40 +0100 (CET)
Received: by mail-bk0-f41.google.com with SMTP id ji1so549092bkc.14
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 04:50:40 -0700 (PDT)
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

Hi Andreas,

On 22.03.2013 17:05, Andreas Koch wrote:
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
> DSD rate. 

And prior to sending either 8 bits or 16 bits, currently the correct USB
alternate interface has to be set, right?

> Since 11.2MHz DSD is already on the horizon we may have to 
> change this to a single 8-bit raw interface and then vary the 
> underlying USB transfer sample rate between 1x, 2x, 4x 352.8kHz - 

Yes, especially given that if there's no common standard across
different devices, either the drivers or the applications have to
implement special handling code for this, and know which interface
supports what.

So for the ALSA layer, we should probably have a generic
SND_PCM_FORMAT_DSD and then rely on the sample rate setting mechanisms
to select the right DSD mode. Other solutions, like having a different
SND_PCM_FORMAT_DSD_{2_8,5_6,11_2}_MHZ would be hairy to implement, as
some devices need to get a sample rate update request, while others
don't etc ...

> that would be more logical and straight forward for the hardware 
> implementation. This is only supported through my own driver for the 
> Windows platform which uses the standard ASIO interface that supports 
> DSD at those rates. Since the Mac OS only supports PCM streams and 
> nothing else I brought together a bunch of DAC manufacturers and 
> playback software developers to standardize a method to "cannibalize" 
> the PCM stream for DSD data. The method is described in the attached 
> and is now supported by most manufacturers.

Very interesting read. For ALSA though, it's no problem to support that
in all layers and make the drivers tell applications about it. We just
have to decide for a sane way :)

> This also has been implemented on a few Linux platforms (Auraliti for 
> instance). Even though the DoP standard works really well so far, it 
> is a "bandaid" and should only be used if there is no other choice. 

Yes, understood. The thing is just that we shouldn't break exising
solutions that already rely on this "bandaid".



Daniel
