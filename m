From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the
 process_option table with function
Date: Wed, 10 Apr 2019 02:51:30 -0700
Message-ID: <20190410095129.GA3468@Asurada>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
 <20190410042638.GB3032@Asurada>
 <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410080052.GA5180@Asurada>
 <VE1PR04MB6479C577E9C2C58E624C5611E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D838F8068A
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 11:51:38 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id k19so1256938pgh.0
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 02:51:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479C577E9C2C58E624C5611E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
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

On Wed, Apr 10, 2019 at 08:26:59AM +0000, S.j. Wang wrote:
> > Is it possible to update the table? It'd be way quicker to use lookup table
> > than real-time calculation all the time. I believe you can simply calculate all
> > the values out for 12KHz and 24KHz since you have the function. If there are
> > certain combinations of these two not being supported, then we could mark
> > it with a special value and add an if-check to error out.
> > 
> 
> Yes,  but I think the function should be more flexible, if someday we need to support
> Other sample rate, only need to update the list.

Given the fact that the owner of the function cannot give more
comments, I feel the function wouldn't be very maintainable as
none of us understands it well. On the other hand, you'll need
to update the supported I/O rate lists anyway, so why not just
update the table as well? The supported sample rates from ALSA
are limited too. Overall, I think that continue using a lookup
table wins.
