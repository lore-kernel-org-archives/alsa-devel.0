From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/2] ASoC: qcom: change PTR_ERR argument
Date: Thu, 17 Sep 2015 10:46:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1509171045100.2399@hadrien>
References: <1440957911-7687-1-git-send-email-Julia.Lawall@lip6.fr>
 <1440957911-7687-2-git-send-email-Julia.Lawall@lip6.fr>
 <20150914180425.GB12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 727D6265196
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 10:46:18 +0200 (CEST)
In-Reply-To: <20150914180425.GB12027@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org



On Mon, 14 Sep 2015, Mark Brown wrote:

> On Sun, Aug 30, 2015 at 08:05:10PM +0200, Julia Lawall wrote:
> > Apply PTR_ERR to the value that was recently assigned.
> >
> > The semantic match that finds this problem is as follows:
> > (http://coccinelle.lip6.fr/)
>
> I have no idea what's going on with this stuff without spending more
> time than it looks like should need, there's a moderately big thread and
> some patches posted in the middle of it.  Can you repost whatever the
> current state is please?

The discussion was about introducing a temporary variable to simplify the
code.  But that makes a lot of changes, so I think it would be better to
just apply the original bug fixing patch as is, and then the cleanup could
be applied on top of that.  I will submit the original patch again.

julia
