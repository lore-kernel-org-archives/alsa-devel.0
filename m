From: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH] ASoC: mt6797: switch to SPDX license tag
Date: Fri, 27 Apr 2018 09:56:24 +0800
Message-ID: <1524794184.28828.10.camel@mtkswgap22>
References: <20180426025605.31874-1-kaichieh.chuang@mediatek.com>
 <7071d4e1-daf1-4847-1dbd-e5c77c709724@gmail.com>
 <20180426114244.GD21755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BC5D267862
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 03:56:36 +0200 (CEST)
In-Reply-To: <20180426114244.GD21755@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, KaiChieh Chuang <kaichieh.chuang@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-04-26 at 12:42 +0100, Mark Brown wrote:
> On Thu, Apr 26, 2018 at 12:46:54PM +0200, Matthias Brugger wrote:
> > On 04/26/2018 04:56 AM, KaiChieh Chuang wrote:
> > > diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> > > index d42a9d9fbf3e..c3f58bac0960 100644
> > > --- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> > > +++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> > > @@ -1,17 +1,9 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > >  /*
> > >   * mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
> > >   *
> 
> Please convert the entire header block to a C++ comment so it looks more
> intentional that it's this way.
> 
> > > - * Author: Ryder Lee <ryder.lee@mediatek.com>
> > > + * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
> 
> > I think you don't want to delete the first author but add you as a second one.
> > I've seen this in other parts of the patch as well. Please check.
> 
> Yeah, looks like an over eager removal of the license text boiler
> plate.

Fine with me. I think this is a copy+paste mistake as I didn't get
involved in MT6797 before.
