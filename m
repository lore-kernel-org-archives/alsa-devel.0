From: "yitian" <yitian.bu@tangramtek.com>
Subject: Re: [RESEND PATCH 1/1] ASoC: dwc: correct irq
	clear	method
Date: Fri, 2 Oct 2015 15:22:33 +0800
Message-ID: <001001d0fce3$215bbb60$64133220$@tangramtek.com>
References: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
 <20150930181751.GT15635@sirena.org.uk>
 <00fe01d0fbf2$5a73cba0$0f5b62e0$@tangramtek.com>
 <20151001100330.GA12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by alsa0.perex.cz (Postfix) with ESMTP id 553DC26680F
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 09:22:54 +0200 (CEST)
In-Reply-To: <20151001100330.GA12635@sirena.org.uk>
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

Hi Mark:
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Mark Brown
> Sent: Thursday, October 1, 2015 6:04 PM
> To: yitian <yitian.bu@tangramtek.com>
> Cc: alsa-devel@alsa-project.org; wsa@the-dreams.de;
> linux-kernel@vger.kernel.org; Andrew.Jackson@arm.com;
> lgirdwood@gmail.com; tiwai@suse.com;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [alsa-devel] [RESEND PATCH 1/1] ASoC: dwc: correct irq clear
> method
> 
> On Thu, Oct 01, 2015 at 10:39:09AM +0800, yitian wrote:
> 
> > > This doesn't apply against current code, please check and resend.
> 
> > I synced up to latest kernel branch, the code is the same as what this
> patch
> > was
> > generated.
> 
> The "latest kernel branch" was neither v4.3-rc1 nor my for-next
> branch, at least as far as git am was concerned, so I couldn't apply the
> patch.

I am sorry.
I used Linux v4.3-rc3 to generate the patch, and I assumed that was the same
as v4.3-rc1.
I generated new patch based on next-20151001, please review it again,
thanks.
