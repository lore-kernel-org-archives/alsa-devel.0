From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate
 based on slot number
Date: Sat, 25 Nov 2017 16:36:23 -0800
Message-ID: <20171126003622.GA7276@Asurada>
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
 <2020d72a-4517-55d0-59a1-171c71f91c7b@invoxia.com>
 <20170912213233.GA11419@Asurada-Nvidia>
 <fdb71350-0b89-8c5a-9ed0-c744bb6f2118@invoxia.com>
 <20170913230147.GA21287@Asurada-Nvidia>
 <20171125232921.01994d72@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D8EB266E3C
 for <alsa-devel@alsa-project.org>; Sun, 26 Nov 2017 01:36:32 +0100 (CET)
Received: by mail-pg0-f67.google.com with SMTP id c123so17131087pga.11
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 16:36:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171125232921.01994d72@jawa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukasz Majewski <lukma@denx.de>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, max.krummenacher@toradex.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, caleb@crome.org, tiwai@suse.com, mpa@pengutronix.de, broonie@kernel.org, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, fabio.estevam@nxp.com, mail@maciej.szmigiero.name, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 25, 2017 at 11:29:48PM +0100, Lukasz Majewski wrote:

> Nicolin, do you know what happened with this patch? I couldn't find it
> in current linux/master.
> 
> Has it been applied to any asoc tree for being upstreamed?

A similar patch with an updated subject got applied:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20171124&id=b0a7043d5c2ccdd306959f295bf1a62be025cbf5
