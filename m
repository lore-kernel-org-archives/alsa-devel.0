From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate
 based on slot number
Date: Thu, 7 Sep 2017 22:42:36 -0700
Message-ID: <20170908054235.GA9603@Asurada-CZ80>
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 13A62267400
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 07:42:42 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id a2so951409pfj.4
 for <alsa-devel@alsa-project.org>; Thu, 07 Sep 2017 22:42:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, timur@tabi.org, arnaud.mouiche@invoxia.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, caleb@crome.org, mpa@pengutronix.de, max.krummenacher@toradex.com, lukma@denx.de, fabio.estevam@nxp.com, mail@maciej.szmigiero.name, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 07, 2017 at 10:23:43PM -0700, Nicolin Chen wrote:
> The set_sysclk() now is used to override the output bit clock rate.
> But this is not a common way to implement a set_dai_sysclk(). And
> this creates a problem when a general machine driver (simple-card
> for example) tries to do set_dai_sysclk() by passing an input clock
> rate for the baud clock instead of setting the bit clock rate as
> fsl_ssi driver expected.
> 
> So this patch solves this problem by firstly removing set_sysclk()
> since the hw_params() can calculate the bit clock rate. Secondly,
> in order not to break those TDM use cases which previously might
> have been using set_sysclk() to override the bit clock rate, this
> patch changes the driver to override it based on the slot number.
> 
> The patch also removes an obsolete comment of the dir parameter.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Forgot to mention, I think that it's better to wait for a couple of
Tested-by from those who use the TDM mode of SSI before applying it.

Thanks
Nicolin
