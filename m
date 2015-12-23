From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 4/4] ASoC: Intel: add NULL test
Date: Wed, 23 Dec 2015 07:58:11 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1512230757420.2081@localhost6.localdomain6>
References: <1450610153-7746-1-git-send-email-Julia.Lawall@lip6.fr>
 <1450610153-7746-5-git-send-email-Julia.Lawall@lip6.fr>
 <20151223000245.GF16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id E8AEF265711
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 07:58:12 +0100 (CET)
In-Reply-To: <20151223000245.GF16023@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On Wed, 23 Dec 2015, Mark Brown wrote:

> On Sun, Dec 20, 2015 at 12:15:53PM +0100, Julia Lawall wrote:
> > Add NULL test on call to devm_kzalloc.
> > 
> > The semantic match that finds this problem is as follows:
> > (http://coccinelle.lip6.fr/)
> 
> If there was a patch 3 in this series I seem to be missing it.

It's not for you (drivers/s390/char/con3215.c).  Sorry for the confusion.

julia
