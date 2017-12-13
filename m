From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 03/11] ASoC: fsl_ssi: Refine all comments
Date: Wed, 13 Dec 2017 14:36:24 -0800
Message-ID: <20171213223623.GB13576@Asurada-Nvidia>
References: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
 <1513146874-25476-4-git-send-email-nicoleotsuka@gmail.com>
 <e264f260-c8df-a51a-4756-cf2ebf979c66@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f181.google.com (mail-pf0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 30183266D45
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 23:36:26 +0100 (CET)
Received: by mail-pf0-f181.google.com with SMTP id v26so2186358pfl.7
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 14:36:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e264f260-c8df-a51a-4756-cf2ebf979c66@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 11:28:51PM +0100, Maciej S. Szmigiero wrote:

> > -	/*
> > -	 * If we're in synchronous mode, and the SSI is already enabled,
> > -	 * then STCCR is already set properly.
> > -	 */
> > +	/* To support simultaneous TX and RX, bypass it if SSI is enabled */
> >  	if (enabled && ssi->cpu_dai_drv.symmetric_rates)
> >  		return 0;
> >  
> 
> I would say that the old comment described better what is happening -
> since in synchronous (& non-AC'97) mode STCCR controls both TX and RX
> the first direction that is started (either playback or capture) is the
> only direction that needs to configure SSI in hw_params().

There is also an SCR register configuration in this hw_params(),
so the old comment has to be updated. But I would take it into
consideration and revise a bit.

Thanks.
