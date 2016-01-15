From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Fri, 15 Jan 2016 10:49:04 -0800
Message-ID: <CAG5mAdyXPtnnZvGcWrhhbv7wuamz_xbRsn76VXdbE1yZRgx_Mg@mail.gmail.com>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia> <56984BE7.2050303@tabi.org>
 <20160115131325.GW6588@sirena.org.uk> <5698F846.5080604@tabi.org>
 <CAG5mAdy553q4Te5755575WaiLxGRp43h=WVH6QzF7idsaCnhbg@mail.gmail.com> <20160115183824.GB31703@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160115183824.GB31703@Asurada-Nvidia>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2016 at 10:38 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Fri, Jan 15, 2016 at 09:03:28AM -0800, Caleb Crome wrote:
>
>> If nobody objects, we can just set the value to 4 and be done with it.
>
> I agree. And we may apply it only to i.MX platforms with DMA if
> other platform owners feel comfortable with the previous settings.
>
>> Another question:  is the watermark ever going to be different than
>> maxburst?  Is there any reason to have them different?
>
> The watermark is merely a threshold to trigger a DMA request. The
> only relationship with the burst size is that each burst transfer
> should not carry more data than the number of empty slots; FIFO
> under/overflow occurs otherwise. So it's just more efficient and
> safer to set an identical value to both of them. I don't think
> it will cause functional problems to set TFWM to 4 and burst size
> to 1 -- It just lets DMA operate in a single data transfer mode.

If there is no penalty for setting maxburst to 1 (or 2 in the case of
dual fifo I think), then should we just set both the watermark and
maxburst to 1?

I guess the real difference would be when you're in FIQ mode.  In FIQ
mode, the penalty of an interrupt per word would be pretty bad, but in
DMA mode, if we just set both to 1, we should be fine, right?
