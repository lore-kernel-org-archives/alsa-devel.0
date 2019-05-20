From: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: Mediatek: MT8183: enable IIR filter
Date: Mon, 20 May 2019 15:50:15 +0800
Message-ID: <1558338615.21415.0.camel@mhfsdcap03>
References: <20190516101515.4127-1-shunli.wang@mediatek.com>
 <20190516101652.GD5598@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by alsa1.perex.cz (Postfix) with ESMTP id A6111F8962F
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2019 09:50:38 +0200 (CEST)
In-Reply-To: <20190516101652.GD5598@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, tzungbi@google.com, linux-mediatek@lists.infradead.org, Shunli Wang <shunli.wang@mediatek.com>, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2019-05-16 at 11:16 +0100, Mark Brown wrote:
> On Thu, May 16, 2019 at 06:15:15PM +0800, Shunli Wang wrote:
> > This patch is to enable IIR filter when DMIC of PMIC
> > is enabled.
> 
> Should this not have a user control in case the user wants to avoid the
> filter for some reason?

The last commit message is incorrect,IIR filter is always required to
open for DMIC and AMIC of PMIC.So we will send V2 which correct the
commit message again.
