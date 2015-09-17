From: Huan Wang <alison.wang@freescale.com>
Subject: Re: [PATCH v2] audio: sai: Add Power Management support
Date: Thu, 17 Sep 2015 09:53:57 +0000
Message-ID: <BN3PR0301MB0867DCDF1F7F6391A94121B2FE5A0@BN3PR0301MB0867.namprd03.prod.outlook.com>
References: <1442221404-35240-1-git-send-email-b18965@freescale.com>
 <20150917065732.GB54360@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0112.outbound.protection.outlook.com [65.55.169.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 841D3265317
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 11:53:59 +0200 (CEST)
In-Reply-To: <20150917065732.GB54360@Asurada-CZ80>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


> On Mon, Sep 14, 2015 at 05:03:24PM +0800, Alison Wang wrote:
> > This patch adds Power Management support for SAI.
> > Activate regmap cache with REGCACHE_FLAT, and use regmap cache code
> to
> > save and restore registers in suspend and resume. The Transmit
> Control
> > Register
> > (TCSR) and Receive Control Register(RCSR) should be volatile
> > registers.
> >
> > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> 
> Just to remind that there was a similar patch in review that I just
> acked. Please send your improvements as an incremental patch after that
> one gets applied.
[Alison Wang] Ok, I missed that patch.
> 
> Please also pay attention to the patch subject which should follow the
> pattern of previous patches of the driver: ASoC: fsl_sai: xxxx
[Alison Wang] Ok, thanks.


Best Regards,
Alison Wang
