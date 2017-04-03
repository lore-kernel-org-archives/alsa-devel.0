From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 15:08:12 -0700
Message-ID: <20170403220811.GA21156@Asurada-Nvidia>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0864F266972
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 00:08:10 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id 81so32606518pgh.3
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 15:08:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, max.krummenacher@toradex.com, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 03, 2017 at 01:32:42PM -0700, Caleb Crome wrote:

> This patch definitely breaks the i.mx6 channel alignment.  In fact it
> breaks it so that the channels are never aligned properly.
> 
> My test setup is as follows:
> * Get vanilla kernel, tag v4.11-rc5
> * apply a couple patches to allow AUD4 on the wandboard external
> connectors (and disable internal audio)
> * Test results:  v4.11-rc5 works flawlessly using Arnaud's atest
> program.  No channel slips, no issues at all.
> * Apply this patch, recompile, build.
> * Channel alignment fails.  The channels never get aligned properly.

What's your test case for the alignment? IIRC, you only needed
the FIFO to be pre-filled with data input so that SSI will not
encounter any FIFO underrun after enabling TE bit. That's why
there is a for-loop before this regmap_update_bits().

> Am I right that the *only* change is this one-liner, and ignore the
> previous non V2 version of this patch?
> > -               regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
> > +               regmap_update_bits(regs, CCSR_SSI_SCR,
> > +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
> > +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);

However, this patch seems to merely set the RE bit. It shouldn't
affect that test case since the SSIEN bit is still set prior to
the TE bit.
