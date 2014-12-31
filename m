From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: DSD over HDMI: audio data packetization
Date: Wed, 31 Dec 2014 23:38:06 +0800
Message-ID: <54A4185E.5010900@gmail.com>
References: <1420032720.2102.14.camel@gmail.com> <54A3FCD7.2010902@iki.fi>
 <96A12704CE18D347B625EE2D4A099D195C438E@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 062E226040D
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 16:38:14 +0100 (CET)
Received: by mail-pd0-f181.google.com with SMTP id v10so20760783pde.26
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 07:38:12 -0800 (PST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D195C438E@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>, Anssi Hannula <anssi.hannula@iki.fi>
Cc: "; Takashi Iwai" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ";
 Wu Fengguang" <wfg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Anssi, Libin,

Thank you very much for your help.

If L-PCM audio data packetization is done by hardware, is it possible to 
implement DSD over HDMI on Intel integrated graphics? Thanks again.


On 12/31/2014 10:28 PM, Yang, Libin wrote:
> Hi Xuebing,
>
>
>> -----Original Message-----
>> From: Anssi Hannula [mailto:anssi.hannula@iki.fi]
>> Sent: Wednesday, December 31, 2014 9:41 PM
>> To: Xuebing Wang
>> Cc: alsa-devel@alsa-project.org; Yang, Libin; Lin, Mengdong; ; Takashi Iwai; ;
>> Wu Fengguang
>> Subject: Re: [alsa-devel] DSD over HDMI: audio data packetization
>>
>> 31.12.2014, 15:32, Xuebing Wang kirjoitti:
>>> Hi Community,
>> Hi,
>>
>>> I am trying to implement DSD (one bit audio) over HDMI, for Intel
>>> integrated graphics. I am referencing HDMI specification 1.3a.
>>>
>>> Regarding audio data packetization, I am referencing spec:
>>> 5.3.4 Audio Sample Packet
>>> 7.6 Audio Data Packetization
>>>
>>> Q1) Would you please point to me where is the source code to handle
>>> L-PCM audio sample packetization (to implement 5.3.4 Audio Sample
>>> Packet)?
>> It is done by the hardware.
>>
>>> Q2) I admit that I did not carefully read HD-Audio specification. Is
>>> this possible that this L-PCM audio data packetization is done by
>>> *hardware* (e.g HDMI related widgets/pins)?
>> Yes.
>>
>>> Q3) Did we implement "7.2 Audio Sample Clock Capture and Regeneration"?
>> That is done by hardware. With some HDA codecs the video driver calculates
>> the N/CTS values "manually", but AFAIK not on Intel HW.
> As the N/CTS need fs and frequency of TMDS info, the hdmi driver does not
> implement this feature.
>
> We currently are designing an audio link between audio subsystem and other
> components, like video or USB.
>
> Maybe we will add the N/CTS information transmission. So we can calculate
> the N/CTS value in audio or gfx driver.
>
>
>>> Thanks.
>>> Xuebing Wang
>>>
>>>
>>
>> --
>> Anssi Hannula

-- 
Thanks,
Xuebing Wang
