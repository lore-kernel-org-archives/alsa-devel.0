From: "Richard Zhao" <linuxzsc@gmail.com>
Subject: Re: ASOC: For SND_SOC_DAIFMT_IB_IF what is invert
	baseed on?
Date: Mon, 27 Oct 2008 11:00:24 +0800
Message-ID: <4e090d470810262000t3d93538i3a71f5e5d042dd2f@mail.gmail.com>
References: <4e090d470810250931k5e44a4cck3ad0186a2c47ec03@mail.gmail.com>
	<1225037126.28382.85.camel@dell-desktop.example.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C8EC12458F
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 04:00:42 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id l35so992538waf.16
	for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2008 20:00:24 -0700 (PDT)
In-Reply-To: <1225037126.28382.85.camel@dell-desktop.example.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/10/27 Liam Girdwood <lrg@slimlogic.co.uk>:
> On Sun, 2008-10-26 at 00:31 +0800, Richard Zhao wrote:
>> Hi,
>>
>> include/sound/soc.h
>> /*
>>  * DAI hardware signal inversions
>>  */
>> #define SND_SOC_DAIFMT_NB_NF            (0 << 8)        /* normal bclk + frm */
>> #define SND_SOC_DAIFMT_NB_IF            (1 << 8)        /* normal bclk
>> + inv frm */
>> #define SND_SOC_DAIFMT_IB_NF            (2 << 8)        /* invert bclk
>> + nor frm */
>> #define SND_SOC_DAIFMT_IB_IF            (3 << 8)        /* invert bclk + frm */
>>
>> What are frame cock and bit clock invert based on? I2S, PCM or some
>> else bus protocols? Or just high level voltage or low level voltage?
>>
>
> Generic logic levels (high/low voltage) that can apply to I2S and PCM
> DAI's.
>
> Liam
>
>
It's not bus protocol depended.
For frame start, LRCLK normal  is 1, invert is 0.
For data valid,  BCLK normal is 1, invert is 0
Is that what you meant?

But when wm8350 in i2s mode, it take SND_SOC_DAIFMT_NB_NF as LRCLK is
0 for frame start.

Thanks
Richard
