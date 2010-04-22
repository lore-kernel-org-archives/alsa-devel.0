From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] pxa: add namespace on ssp
Date: Thu, 22 Apr 2010 09:08:18 +0900
Message-ID: <20100422000817.GB22879@opensource.wolfsonmicro.com>
References: <n2t771cded01004162234sb67befcfp60ba67bfe1a8117f@mail.gmail.com>
	<q2yf17812d71004211517kf54116acxe788927a53048e26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D06E2439E
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 02:08:14 +0200 (CEST)
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
> On Sat, Apr 17, 2010 at 1:34 PM, Haojian Zhuang

> > In order to prevent code ambiguous, add namespace on functions in ssp driver.

> Sorry I'm still not convinced that this is a necessary change, could
> you point me to some place where there are naming conflicts?

Oh, sorry - misread the patch that was being replied to.  The issue is
more around consistency and the fact that ssp_ is pretty short as it is
about specific conflicts that exist.  If the rest of the driver had been
using ssp_ already I wouldn't have said anything but since currently
exported symbols all use pxa2xx_ it seemed better to make newly exported
ones match.
