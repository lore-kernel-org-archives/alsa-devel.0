From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [RESEND PATCH v2 15/15] arm64: dts: msm8996:
 db820c: Add sound card support
Date: Wed, 3 Jan 2018 12:01:18 -0800
Message-ID: <20180103200118.GB478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-16-srinivas.kandagatla@linaro.org>
 <20180103002229.GV478@tuxbook>
 <e03188a1-1db2-29ab-8112-015161125e0b@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f50.google.com (mail-pg0-f50.google.com [74.125.83.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 353DF2676A9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 21:01:22 +0100 (CET)
Received: by mail-pg0-f50.google.com with SMTP id i196so463134pgd.0
 for <alsa-devel@alsa-project.org>; Wed, 03 Jan 2018 12:01:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e03188a1-1db2-29ab-8112-015161125e0b@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, sboyd@codeaurora.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, David Brown <david.brown@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed 03 Jan 08:27 PST 2018, Srinivas Kandagatla wrote:

> Thanks for the comments,
> 
> On 03/01/18 00:22, Bjorn Andersson wrote:
> > On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla@linaro.org wrote:
> > 
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
[..]
> > > +	        lpass_q6_smmu: arm,smmu-lpass_q6@1600000 {
> > 
> > name this node "iommu"
> will rename it to arm,smmu@1600000
> 

I don't think you're supposed to have , in the node names, and whenever
possible they should be generic names of the function.

So analog to "clock-controller", "dma-controller", "serial", "i2c" etc I
believe this should be "iommu".

Regards,
Bjorn
