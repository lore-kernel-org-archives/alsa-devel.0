From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v1 05/15] ASoC: fsl_ssi: Clean up helper
 functions of trigger()
Date: Thu, 4 Jan 2018 11:44:06 -0800
Message-ID: <20180104194405.GD27975@Asurada-Nvidia>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-6-git-send-email-nicoleotsuka@gmail.com>
 <59aa58b7-aeda-ef87-e150-9fec9c6229ae@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f46.google.com (mail-pl0-f46.google.com
 [209.85.160.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 95567267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 20:43:53 +0100 (CET)
Received: by mail-pl0-f46.google.com with SMTP id bd8so1619453plb.9
 for <alsa-devel@alsa-project.org>; Thu, 04 Jan 2018 11:43:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <59aa58b7-aeda-ef87-e150-9fec9c6229ae@maciej.szmigiero.name>
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
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 01, 2018 at 10:59:30PM +0100, Maciej S. Szmigiero wrote:

> > +static void fsl_ssi_config_enable(struct fsl_ssi *ssi, bool tx)

> > +		srcr = vals[tx].srcr;
> > +		stcr = vals[tx].stcr;
> > +		sier = vals[tx].sier;
> 
> Implicit assumption here that RX == 0, TX == 1, as in the 03 patch.

Could replace it with "bool dir" as well. Thanks for the review.
