From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Sun, 17 Jan 2016 15:34:59 -0800
Message-ID: <CAG5mAdzN0j0fEsDcZMPUTPQtf9vSyyHYUE4HVisu_MxVBVAxOg@mail.gmail.com>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia> <56984BE7.2050303@tabi.org>
 <20160115131325.GW6588@sirena.org.uk> <5698F846.5080604@tabi.org>
 <CAG5mAdy553q4Te5755575WaiLxGRp43h=WVH6QzF7idsaCnhbg@mail.gmail.com>
 <20160115183824.GB31703@Asurada-Nvidia> <CAG5mAdyXPtnnZvGcWrhhbv7wuamz_xbRsn76VXdbE1yZRgx_Mg@mail.gmail.com>
 <20160115185736.GC31703@Asurada-Nvidia> <CAG5mAdyUfSuCqA4_342MS2AyshvuyeiYsjQyRqifmqVhn4T2xA@mail.gmail.com>
 <569A5085.10806@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <569A5085.10806@tabi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Okay, I'll submit a patch that does the following:

fsl,mpc8610:  using DMA=fifo_depth-2 (unchanged from current), using
FIQ=fifo_depth  (unchanged from current).

all others that are marked with 'imx':  watermark&maxburst = 4 for DMA
(new setting).  watermark = fifo_depth for FIQ (unchanged from
previous).

-Caleb



On Sat, Jan 16, 2016 at 6:15 AM, Timur Tabi <timur@tabi.org> wrote:
> Caleb Crome wrote:
>>
>> I see the 4 compatibles are:  fsl,mpc8610-ssi, fsl,imx51-ssi,
>> fsl,imx35-ssi, and fsl,imx21-ssi.
>>
>> Shall I submit a patch that sets the value to 4 for for any/all of the
>> above?  Should it be different based on whether fiq is enabled.  Maybe
>> set it to 4 for whenever DMA is used, and to 13 whenever FIQ is used?
>
>
> Do NOT change the watermark value for fsl,mpc8610-ssi from whatever it is
> today.  You would need to retest your code on an mpc8610 and p1022ds, and I
> don't think you have either of those boards.
