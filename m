From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] pxa: add namespace on ssp
Date: Thu, 22 Apr 2010 08:37:56 +0900
Message-ID: <20100421233755.GA22879@opensource.wolfsonmicro.com>
References: <n2t771cded01004162234sb67befcfp60ba67bfe1a8117f@mail.gmail.com>
	<q2yf17812d71004211517kf54116acxe788927a53048e26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AFAA124382
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 01:37:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <q2yf17812d71004211517kf54116acxe788927a53048e26@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 22, 2010 at 06:17:29AM +0800, Eric Miao wrote:

> Sorry I'm still not convinced that this is a necessary change, could
> you point me to some place where there are naming conflicts?

Look at Liam's recent posting about the updated ASoC device model - that
introduces a number of incompatible API changes.
