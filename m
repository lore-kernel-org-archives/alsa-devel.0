From: Andreas Mohr <andi@lisas.de>
Subject: Re: [RFC PATCH] ES938 support for ES18xx driver
Date: Sun, 15 Sep 2013 23:23:58 +0200
Message-ID: <20130915212358.GB32375@rhlx01.hs-esslingen.de>
References: <20130915184902.GA23480@rhlx01.hs-esslingen.de>
 <201309152225.46581.linux@rainbow-software.org>
 <20130915203520.GA10589@rhlx01.hs-esslingen.de>
 <201309152304.27585.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 658AA261AFE
 for <alsa-devel@alsa-project.org>; Sun, 15 Sep 2013 23:23:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201309152304.27585.linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org, krzysztof.h1@wp.pl, Andreas Mohr <andi@lisas.de>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 15, 2013 at 11:04:26PM +0200, Ondrej Zary wrote:
> On Sunday 15 September 2013 22:35:20 Andreas Mohr wrote:
> > What!?!? I didn't quite expect any kernel dev to have that one, too ;)
> 
> Don't remember where I got it from but it looked nice so I bought it :)

Yup, e.g. the builtin amp is quite nice.

> > Thanks for hinting at the TLV control dB values thingy! Didn't know that
> > such thing existed, thus azt3328 does not have it (yet?).
> 
> It's a nice thing, especially for cards that can go above 0 dB. You then know 
> that the sound can be distorted when you set e.g. PCM volume too high.

Hmm, any hint how to precisely do dB values normalization scaling,
for a card where this is not documented? Or perhaps that's actually easy -
haven't thought about it...

> > Is there any chip ID/version register to be identified?
> 
> No, there are only 8 registers, all(? - haven't tested) R/W.

OK, but possibly they happen to be creating another virtual register mapping range?
(i.e. index/data register combo?)

Andreas Mohr
