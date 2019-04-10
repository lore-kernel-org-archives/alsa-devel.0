From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the
 process_option table with function
Date: Wed, 10 Apr 2019 01:00:53 -0700
Message-ID: <20190410080052.GA5180@Asurada>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
 <20190410042638.GB3032@Asurada>
 <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52170F89623
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 10:01:02 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id 10so971633pfo.5
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 01:01:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 10, 2019 at 07:22:31AM +0000, S.j. Wang wrote:
> > The table was copied directly from the Reference Manual. We also have
> > listed all supported input and output sample rates just right behind that table.
> > If there're missing rates, we probably should update those two lists also?
> > Otherwise, how could we have a driver limiting both I/O sample rates while
> > we still see something not in the table?
> > 
> 
> Yes,  I plan to send another patch to update the in/out rate list.  Do I need
> To merge that to this commit?  Actually we want to support 12k and 24KHz

Please send separate patches but in one series. And a question:

Is it possible to update the table? It'd be way quicker to use
lookup table than real-time calculation all the time. I believe
you can simply calculate all the values out for 12KHz and 24KHz
since you have the function. If there are certain combinations
of these two not being supported, then we could mark it with a
special value and add an if-check to error out.

> > > +static int proc_autosel(int Fsin, int Fsout, int *pre_proc, int
> > > +*post_proc)
> > 
> > Please add some comments to this function to explain what it does, and how
> > it works. And better to rename it to something like "fsl_asrc_sel_proc".
> > 
> Yes, some comments should be added, but not so detail, because this function

As much comments as possible.

> Is get from the design team, but the owner has left.

OK...that's sad...

> > Another thing confuses me: so we could have supported sample rates in the
> > list but the hardware might not support some of them because we couldn't
> > calculate their processing options?
> 
> No, just want to support 12k, 24KHz, or others as customer like.

I was confused because the I/O rate lists not getting updated.
It makes sense now if you are abort to update them.
