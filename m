From: "yitian" <yitian.bu@tangramtek.com>
Subject: Re: [RESEND PATCH 1/1] ASoC: dwc: correct irq clear
	method
Date: Thu, 1 Oct 2015 10:39:09 +0800
Message-ID: <00fe01d0fbf2$5a73cba0$0f5b62e0$@tangramtek.com>
References: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
 <20150930181751.GT15635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by alsa0.perex.cz (Postfix) with ESMTP id CFA8C266571
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 04:39:21 +0200 (CEST)
In-Reply-To: <20150930181751.GT15635@sirena.org.uk>
Content-Language: zh-cn
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, wsa@the-dreams.de, linux-kernel@vger.kernel.org, Andrew.Jackson@arm.com, lgirdwood@gmail.com, tiwai@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Mark
> Brown
> Sent: Thursday, October 1, 2015 2:18 AM
> To: yitian <yitian.bu@tangramtek.com>
> Cc: alsa-devel@alsa-project.org; wsa@the-dreams.de;
> linux-kernel@vger.kernel.org; Andrew.Jackson@arm.com; tiwai@suse.com;
> lgirdwood@gmail.com; perex@perex.cz;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [RESEND PATCH 1/1] ASoC: dwc: correct irq clear method
> 
> On Tue, Sep 29, 2015 at 10:39:00PM +0800, yitian wrote:
> > from Designware I2S datasheet, irq is cleared by reading from
> > TOR/ROR registers, rather than by writing into them.
> 
> This doesn't apply against current code, please check and resend.
Hi Mark:

Thanks for your comments.
Maybe I misunderstand your meaning. Please correct me.

I synced up to latest kernel branch, the code is the same as what this patch
was
generated.

I checked designware I2S spec "version 1.08a June 2014", it specified that
the TOR
and ROR registers are read only and reading the last bit will clear tx/rx
overrun irq.

Also I have checked this register by writing its last bit, the overrun irq
is not cleared.
But if I read the last bit, the overrun irq is cleared. That means the spec
is correct.

Can you please let me know what else I should double check? Thanks.
