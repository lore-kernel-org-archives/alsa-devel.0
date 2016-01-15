From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Fri, 15 Jan 2016 13:49:27 -0600
Message-ID: <CAOZdJXVu7DCm5n=S46=84+3wi-n48rL1dEkPug3PuAggDWOoNw@mail.gmail.com>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
	<20160114201858.GA17567@Asurada-Nvidia>
	<56984BE7.2050303@tabi.org>
	<20160115131325.GW6588@sirena.org.uk>
	<5698F846.5080604@tabi.org>
	<CAG5mAdy553q4Te5755575WaiLxGRp43h=WVH6QzF7idsaCnhbg@mail.gmail.com>
	<20160115183824.GB31703@Asurada-Nvidia>
	<CAG5mAdyXPtnnZvGcWrhhbv7wuamz_xbRsn76VXdbE1yZRgx_Mg@mail.gmail.com>
	<20160115185736.GC31703@Asurada-Nvidia>
	<CAG5mAdyUfSuCqA4_342MS2AyshvuyeiYsjQyRqifmqVhn4T2xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG5mAdyUfSuCqA4_342MS2AyshvuyeiYsjQyRqifmqVhn4T2xA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Crome <caleb@crome.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2016 at 1:10 PM, Caleb Crome <caleb@crome.org> wrote:
>
> I see the 4 compatibles are:  fsl,mpc8610-ssi, fsl,imx51-ssi,
> fsl,imx35-ssi, and fsl,imx21-ssi.
>
> Shall I submit a patch that sets the value to 4 for for any/all of the
> above?  Should it be different based on whether fiq is enabled.  Maybe
> set it to 4 for whenever DMA is used, and to 13 whenever FIQ is used?


I don't like the idea that we'll need a new device tree to make a new
kernel work.  The driver should continue to work with old device trees
as-is.
