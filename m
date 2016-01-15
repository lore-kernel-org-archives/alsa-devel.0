From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark
 and maxburst settings device tree options
Date: Fri, 15 Jan 2016 11:23:21 -0800
Message-ID: <20160115192320.GA12418@Asurada-Nvidia>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia> <56984BE7.2050303@tabi.org>
 <20160115131325.GW6588@sirena.org.uk> <5698F846.5080604@tabi.org>
 <CAG5mAdy553q4Te5755575WaiLxGRp43h=WVH6QzF7idsaCnhbg@mail.gmail.com>
 <20160115183824.GB31703@Asurada-Nvidia>
 <CAG5mAdyXPtnnZvGcWrhhbv7wuamz_xbRsn76VXdbE1yZRgx_Mg@mail.gmail.com>
 <20160115185736.GC31703@Asurada-Nvidia>
 <CAG5mAdyUfSuCqA4_342MS2AyshvuyeiYsjQyRqifmqVhn4T2xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
 [209.85.220.68])
 by alsa0.perex.cz (Postfix) with ESMTP id D0E8E260439
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 20:23:24 +0100 (CET)
Received: by mail-pa0-f68.google.com with SMTP id pv5so30810701pac.0
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 11:23:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAG5mAdyUfSuCqA4_342MS2AyshvuyeiYsjQyRqifmqVhn4T2xA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: devicetree@vger.kernel.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2016 at 11:10:29AM -0800, Caleb Crome wrote:
 
> Shall I submit a patch that sets the value to 4 for for any/all of the
> above?  Should it be different based on whether fiq is enabled.  Maybe
> set it to 4 for whenever DMA is used, and to 13 whenever FIQ is used?

A possible solution:
Use the original settings (depth - 2) as a common configuration
in the main probe() and overwrite it in the fsl_ssi_imx_probe()
if detecting a use_dma flag.
