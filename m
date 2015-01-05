From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: DSD over HDMI: audio data packetization
Date: Mon, 05 Jan 2015 05:46:28 +0200
Message-ID: <54AA0914.4000109@iki.fi>
References: <1420032720.2102.14.camel@gmail.com> <54A3FCD7.2010902@iki.fi>	
 <96A12704CE18D347B625EE2D4A099D195C438E@SHSMSX103.ccr.corp.intel.com>	
 <54A4185E.5010900@gmail.com> <54A41A18.3070005@iki.fi>	
 <96A12704CE18D347B625EE2D4A099D195C4443@SHSMSX103.ccr.corp.intel.com>	
 <54A4CF03.5030709@iki.fi> <1420341058.1981.6.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E16B2606A5
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 04:46:30 +0100 (CET)
In-Reply-To: <1420341058.1981.6.camel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xuebing Wang <xbing6@gmail.com>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ";
 Takashi Iwai" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, ";
 Wu Fengguang" <wfg@linux.intel.com>, Andrej Falout <andrej@falout.org>
List-Id: alsa-devel@alsa-project.org

04.01.2015, 05:10, Xuebing Wang kirjoitti:
> Anssi, Libin,
> 
> Thanks for your help.
> 
> After a little bit of research, I do think it is possible to stream DSD
> over HDMI (the mechanism is as Anssi mentioned, similar way as HBR).
> 
> Please see HDA spec:
> 3.7.1 Stream Format Structure
> (If the TYPE is set to Non-PCM, the controller just pushes data over the
> link and is not concerned
> with formatting. The base rate, data type, and number of Words (MULT) to
> send each valid frame
> are specified to control the rate at which the non-PCM data is sent.)
> 
> 7.3.3.8 Converter Format
> 
> What do you think? In order to implement this similiar mechanism
> (similar to HBR), I still have some detailed questions that I will write
> in another email. Thanks.

That setting will still not allow you to send One-bit audio or DST
packets. The stream will still be encapsulated in either ASP or HBR
packets, depending on the value of the EPT field (Encoded Packet Type,
7.3.3.13).


> 
> On Thu, 2015-01-01 at 06:37 +0200, Anssi Hannula wrote:
>> 01.01.2015, 04:07, Yang, Libin kirjoitti:
>>> Hi,
>>>
>>>> -----Original Message-----
>>>> From: Anssi Hannula [mailto:anssi.hannula@iki.fi]
>>>> Sent: Wednesday, December 31, 2014 11:45 PM
>>>> To: Xuebing Wang
>>>> Cc: Yang, Libin; alsa-devel@alsa-project.org; Lin, Mengdong; ; Takashi Iwai; ;
>>>> Wu Fengguang
>>>> Subject: Re: [alsa-devel] DSD over HDMI: audio data packetization
>>>>
>>>> 31.12.2014, 17:38, Xuebing Wang kirjoitti:
>>>>> Anssi, Libin,
>>>>>
>>>>> Thank you very much for your help.
>>>>>
>>>>> If L-PCM audio data packetization is done by hardware, is it possible
>>>>> to implement DSD over HDMI on Intel integrated graphics? Thanks again.
>>>>
>>>> I don't think so, unless:
>>>>
>>>> (a) It is possible to somehow encapsulate the stream in Audio Sample
>>>> Packets and be accepted by the receiver (like e.g. AC3, DTS). I'm not aware of
>>>> such a way.
>>>>
>>>> or:
>>>> (b) There is some undocumented feature in the Intel HDMI codecs allowing
>>>> the driver to switch to DSD or driver-constructed packets (instead of
>>>> ASP) in similar way as there is a way to switch to HBR packets.
>>>>
>>>
>>> Yes, I agree. And I'm not sure whether HDMI spec supports DSD.
>>
>> It does, via the "One Bit Audio" and "DST" formats (spec 5.3.9, 5.3.10
>> in 1.3a/1.4a).
> 
> 


-- 
Anssi Hannula
