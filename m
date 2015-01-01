From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: DSD over HDMI: audio data packetization
Date: Thu, 01 Jan 2015 06:37:23 +0200
Message-ID: <54A4CF03.5030709@iki.fi>
References: <1420032720.2102.14.camel@gmail.com> <54A3FCD7.2010902@iki.fi>
 <96A12704CE18D347B625EE2D4A099D195C438E@SHSMSX103.ccr.corp.intel.com>
 <54A4185E.5010900@gmail.com> <54A41A18.3070005@iki.fi>
 <96A12704CE18D347B625EE2D4A099D195C4443@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C405260431
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 05:37:26 +0100 (CET)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D195C4443@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>
Cc: "; Takashi Iwai" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xuebing Wang <xbing6@gmail.com>, "; Wu Fengguang" <wfg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

01.01.2015, 04:07, Yang, Libin kirjoitti:
> Hi,
> 
>> -----Original Message-----
>> From: Anssi Hannula [mailto:anssi.hannula@iki.fi]
>> Sent: Wednesday, December 31, 2014 11:45 PM
>> To: Xuebing Wang
>> Cc: Yang, Libin; alsa-devel@alsa-project.org; Lin, Mengdong; ; Takashi Iwai; ;
>> Wu Fengguang
>> Subject: Re: [alsa-devel] DSD over HDMI: audio data packetization
>>
>> 31.12.2014, 17:38, Xuebing Wang kirjoitti:
>>> Anssi, Libin,
>>>
>>> Thank you very much for your help.
>>>
>>> If L-PCM audio data packetization is done by hardware, is it possible
>>> to implement DSD over HDMI on Intel integrated graphics? Thanks again.
>>
>> I don't think so, unless:
>>
>> (a) It is possible to somehow encapsulate the stream in Audio Sample
>> Packets and be accepted by the receiver (like e.g. AC3, DTS). I'm not aware of
>> such a way.
>>
>> or:
>> (b) There is some undocumented feature in the Intel HDMI codecs allowing
>> the driver to switch to DSD or driver-constructed packets (instead of
>> ASP) in similar way as there is a way to switch to HBR packets.
>>
> 
> Yes, I agree. And I'm not sure whether HDMI spec supports DSD.

It does, via the "One Bit Audio" and "DST" formats (spec 5.3.9, 5.3.10
in 1.3a/1.4a).

>>
>>
>>>
>>> On 12/31/2014 10:28 PM, Yang, Libin wrote:
>>>> Hi Xuebing,
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Anssi Hannula [mailto:anssi.hannula@iki.fi]
>>>>> Sent: Wednesday, December 31, 2014 9:41 PM
>>>>> To: Xuebing Wang
>>>>> Cc: alsa-devel@alsa-project.org; Yang, Libin; Lin, Mengdong; ;
>>>>> Takashi Iwai; ; Wu Fengguang
>>>>> Subject: Re: [alsa-devel] DSD over HDMI: audio data packetization
>>>>>
>>>>> 31.12.2014, 15:32, Xuebing Wang kirjoitti:
>>>>>> Hi Community,
>>>>> Hi,
>>>>>
>>>>>> I am trying to implement DSD (one bit audio) over HDMI, for Intel
>>>>>> integrated graphics. I am referencing HDMI specification 1.3a.
>>>>>>
>>>>>> Regarding audio data packetization, I am referencing spec:
>>>>>> 5.3.4 Audio Sample Packet
>>>>>> 7.6 Audio Data Packetization
>>>>>>
>>>>>> Q1) Would you please point to me where is the source code to handle
>>>>>> L-PCM audio sample packetization (to implement 5.3.4 Audio Sample
>>>>>> Packet)?
>>>>> It is done by the hardware.
>>>>>
>>>>>> Q2) I admit that I did not carefully read HD-Audio specification.
>>>>>> Is this possible that this L-PCM audio data packetization is done
>>>>>> by
>>>>>> *hardware* (e.g HDMI related widgets/pins)?
>>>>> Yes.
>>>>>
>>>>>> Q3) Did we implement "7.2 Audio Sample Clock Capture and
>> Regeneration"?
>>>>> That is done by hardware. With some HDA codecs the video driver
>>>>> calculates the N/CTS values "manually", but AFAIK not on Intel HW.
>>>> As the N/CTS need fs and frequency of TMDS info, the hdmi driver does
>>>> not implement this feature.
>>>>
>>>> We currently are designing an audio link between audio subsystem and
>>>> other components, like video or USB.
>>>>
>>>> Maybe we will add the N/CTS information transmission. So we can
>>>> calculate the N/CTS value in audio or gfx driver.
>>>>
>>>>
>>>>>> Thanks.
>>>>>> Xuebing Wang
>>>>>>
>>>>>>
>>>>>
>>>>> --
>>>>> Anssi Hannula
>>>
>>
>>
>> --
>> Anssi Hannula


-- 
Anssi Hannula
