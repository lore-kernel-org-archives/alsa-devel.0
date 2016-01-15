From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark
 and maxburst settings device tree options
Date: Thu, 14 Jan 2016 21:25:39 -0600
Message-ID: <20160115032539.GA26909@rob-hp-laptop>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia> <56984BE7.2050303@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id F1AB626052B
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 04:25:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56984BE7.2050303@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 07:31:19PM -0600, Timur Tabi wrote:
> Nicolin Chen wrote:
> >I think DT maintainers may not give a consent towards these two
> >properties as they are not to describe the hardware but to hack
> >software configurations. (And it seems you haven't CCed them.)
> 
> I admit it's a grey area, but the hardware doesn't work if you use the wrong
> value, and it is a fixed value per device.  A p1022ds would use a different
> value than in in i.MX6, and once you pick a value, it's the same no matter
> which sample rate, buffer size, etc you choose.

We've allowed similar properties for other things like SPI controllers.

It really depends on the frequency you expect to change it. The more 
often it changes, the higher up the s/w stack it should be controlled 
(firmware/DT, kernel, or userspace). A function of the SOC or codec 
rate, then yes DT is fine. Every user needs to tune it on the same 
platform, then no, don't put it in DT. My recollection from i.MX is this 
would be the former case.

Rob
