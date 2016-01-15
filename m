From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Fri, 15 Jan 2016 10:12:49 -0800
Message-ID: <20160115181248.GA31703@Asurada-Nvidia>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia>
 <CAG5mAdwJ+VznMp5mUVTufa_wW-corc6qXGbqskz8LGqeG5Z1kw@mail.gmail.com>
 <20160115024534.GB29132@Asurada-Nvidia>
 <CAG5mAdyH1FOYCxYM14fknnRmaSBERMLx_k_D+RCUMiSjWMRvBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAG5mAdyH1FOYCxYM14fknnRmaSBERMLx_k_D+RCUMiSjWMRvBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Crome <caleb@crome.org>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 08:56:31PM -0800, Caleb Crome wrote:
> On Thu, Jan 14, 2016 at 6:45 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > On Thu, Jan 14, 2016 at 01:26:24PM -0800, Caleb Crome wrote:
> >
> >> As for optimal settings, I finally came to a setting of 4 for depth &
> >> maxburst, which will result in more DMA requests, but it's the only
> >> way that works at 48kHz for me.  The default settings is 13 (15 - 2)
> >> for the ones of the 15 item fifo, which is a pretty dramatic
> >> difference.  I just don't know if other chips will behave badly in
> >> that case.
> >
> > What's your final configuration for TFWM0 bits, 4?
> 
> Yes, a value of 4 for my use case:  i.MX6 @ 768000 words/second (48khz
> * 16 channels).

4 means there are >= 4 empty slots in the FIFO, so there are no more
than 11 remaining data. This makes sense.

IIRC, the Freescale official BSP release for i.MX is used to set 6 to
TFWM0/1 in the old day, not sure about recent ones though. So I think
setting 4 to TFWM0/1 should work for most of cases. We may also let
others test it before merging it.

Actually a setting of 13 is much more risky in my opinion. It means
only two empty slots in the FIFO, so it might be easily to get under/
overflow if a DMA transaction gets delay somehow. The only benefit is
that DMA requests and interrupt (FIQ) can be reduced.
