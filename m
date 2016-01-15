From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Thu, 14 Jan 2016 18:45:35 -0800
Message-ID: <20160115024534.GB29132@Asurada-Nvidia>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia>
 <CAG5mAdwJ+VznMp5mUVTufa_wW-corc6qXGbqskz8LGqeG5Z1kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAG5mAdwJ+VznMp5mUVTufa_wW-corc6qXGbqskz8LGqeG5Z1kw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Crome <caleb@crome.org>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 01:26:24PM -0800, Caleb Crome wrote:

> As for optimal settings, I finally came to a setting of 4 for depth &
> maxburst, which will result in more DMA requests, but it's the only
> way that works at 48kHz for me.  The default settings is 13 (15 - 2)
> for the ones of the 15 item fifo, which is a pretty dramatic
> difference.  I just don't know if other chips will behave badly in
> that case.

What's your final configuration for TFWM0 bits, 4?
