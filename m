From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 16:55:43 -0700
Message-ID: <20170403235542.GA23047@Asurada-Nvidia>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <20170403220811.GA21156@Asurada-Nvidia>
 <CAG5mAdxDiH4_FVqT5fC+PFGZ108GQCZiLLhja8xGRK0RdWo3oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 761E7266972
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 01:56:09 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id 81so33088379pgh.3
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 16:56:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG5mAdxDiH4_FVqT5fC+PFGZ108GQCZiLLhja8xGRK0RdWo3oQ@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 03, 2017 at 04:31:59PM -0700, Caleb Crome wrote:

> > What's your test case for the alignment?
> 
> I'm not sure what you are asking.  The test case I'm testing is:
> connect SSI to AUD4 on wandboard & physically connect TX -> RX.  (as
> per https://github.com/ccrome/linux-caleb-dev/wiki), then use atest to
> verify bit-perfection of TX->RX transmission.

So your test case involve both TX and RX. That's why this change
would impact it. My understanding is: because you can not enable
TX and RX in the same time from user space but only through two
separate back-to-back system calls. So when the 2nd system call
happens (RX for example), the RE bit, supposed to be enabled by
this 2nd system call, has already been set by the 1st TX system
call -- there's some random data in the RX FIFO already.

> >> > -               regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
> >> > +               regmap_update_bits(regs, CCSR_SSI_SCR,
> >> > +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
> >> > +                       CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
> >
> > However, this patch seems to merely set the RE bit. It shouldn't
> > affect that test case since the SSIEN bit is still set prior to
> > the TE bit.
> 
> Heh, well, this patch causes audio to be utterly broken on
> multi-channel audio :-/

If possible, could you try to confirm what's the diff between the
two SCR values of before-regmap and after-regmap in your case?
