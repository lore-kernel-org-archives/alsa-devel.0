From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: mpc8610:
	replace	of_device with platform_device
Date: Fri, 20 Aug 2010 17:21:17 +0100
Message-ID: <20100820162116.GD21965@sirena.org.uk>
References: <1282249618-27137-1-git-send-email-timur@freescale.com>
	<20100820094113.GB13668@rakim.wolfsonmicro.main>
	<AANLkTi=nAR=qCikxMK25a6u_vT5t_hz0RGo2Us+sba6T@mail.gmail.com>
	<1282320631.3084.636.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DD2902455E
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 18:21:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282320631.3084.636.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 20, 2010 at 05:10:31PM +0100, Liam Girdwood wrote:
> On Fri, 2010-08-20 at 10:49 -0500, Timur Tabi wrote:

> > I believe that this is because you are missing this patch:

> > [v2] asoc/multi-component: fsl: add support for variable SSI FIFO depth

> > Liam, would you please ask Mark to pull from your for-2.6.37 branch,
> > so that he can pick up this patch?

> Mark has pulled and has this patch now. Btw, the confusion here was in
> the patch subject (multi-component) hence this mornings email on the
> matter.

This sorted the application issue, applied now.
