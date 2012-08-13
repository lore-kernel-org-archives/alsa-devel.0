From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: ICT Bits for HDMI HBR feature
Date: Mon, 13 Aug 2012 16:08:43 +0800
Message-ID: <CA+v+29gDb5gnpVtf_porTqnt+Eqw85mMux8+n2E48WrNh=+Rkg@mail.gmail.com>
References: <46B810F6945F7C4788E11DCE57EC48900FF4245B@SHSMSX102.ccr.corp.intel.com>
 <s5htxwfgjry.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E70CE265D18
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2012 09:39:18 +0200 (CEST)
Received: by qcse14 with SMTP id e14so1911875qcs.38
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2012 01:09:04 -0700 (PDT)
In-Reply-To: <s5htxwfgjry.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

2012/8/7 Takashi Iwai <tiwai@suse.de>:
> At Tue, 7 Aug 2012 08:09:26 +0000,
> Wang, Xingchao wrote:
>>
>> Hi Takashi,
>>
>> Should we set ICT bits when enable HDMI HBR features? Here's quote from HDA Specification Rev1.0a(page 150).
>> "
>> ICT[3:0] (IEC Coding Type): Programmed according to IEC standards to enable stream types for High Bit Rate Encoding. This is valid only for HDMI and Display port digital Pin Widgets.
>> "
>> Since HDMI HBR already works on some chips, I wonder if they set the bits correctly.
>
> I can't find the specification right now, so I also don't know what
> value should be put there.  But I thought it's expected to be zero.
> Maybe it's my old memory.
>
> So, if you find anything about it, let me know.
>

Besides ICT bits setting, i found CC[Category Code] was not used either.
Here's the  description for "Category code" from IEC Standard spec:

"Channel status including the category code is defined in IEC 60958-3
for consumer
applications; these category codes are used for other variations of
the IEC 60958 series for
consumer use, such as the IEC 61937 series."

Do you have idea about how to use it and is it useful for the HBR issue?

thanks
--xingchao
