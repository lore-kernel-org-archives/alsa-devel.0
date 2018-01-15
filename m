From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 14/17] ASoC: fsl_ssi: Clean up
	_fsl_ssi_set_dai_fmt()
Date: Mon, 15 Jan 2018 13:40:21 -0800
Message-ID: <20180115214021.GB10868@Asurada>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
 <1515990087-11598-15-git-send-email-nicoleotsuka@gmail.com>
 <88551d87-1b76-9a30-6781-1d0b6479b317@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f45.google.com (mail-pg0-f45.google.com [74.125.83.45])
 by alsa0.perex.cz (Postfix) with ESMTP id C2D27267612
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 22:40:27 +0100 (CET)
Received: by mail-pg0-f45.google.com with SMTP id k68so875392pga.3
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 13:40:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <88551d87-1b76-9a30-6781-1d0b6479b317@maciej.szmigiero.name>
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
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 15, 2018 at 10:16:28PM +0100, Maciej S. Szmigiero wrote:

> > * Removing TXBIT0 configurations since this bit is set to 1 as its
> >   reset value and there is no use case so far to unset it. And it
> >   is safe to remove since regmap_update_bits() won't touch it.
> 
> I didn't get any response to a comment I've written about the point

I neglected the comments in the middle. Sorry. Will add it back then.
