From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 17:08:23 -0700
Message-ID: <20170404000823.GB23047@Asurada-Nvidia>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <20170403223614.GC21156@Asurada-Nvidia>
 <CAOMZO5AZm5w69033PKd+PTQARZaujO9H_n7YtQ7hnGESefvd4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BF4E266DE5
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 02:08:19 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id 81so33143137pgh.3
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 17:08:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AZm5w69033PKd+PTQARZaujO9H_n7YtQ7hnGESefvd4A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Caleb Crome <caleb@crome.org>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 03, 2017 at 07:54:26PM -0300, Fabio Estevam wrote:
> Hi Nicolin,
> 
> On Mon, Apr 3, 2017 at 7:36 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> 
> > My extra concern for this change is that ENGcm06222 suggests to
> > set TE and SSIEN together. However, we are still not setting the
> > SSIEN and TE together -- SSIEN is set already before this line
> > in the "ssi_private->use_dma && (vals->scr & CCSR_SSI_SCR_TE)".
> >
> > On the other hand, ENGcm06222 doesn't mention anything related
> > to the RE bit. Although ENGcm06474 suggests to set TE and RE
> > together, yet it's for another bug (when TE is set after RE, the
> > TX channels might be swapped.)
> 
> The idea for this patch came from commit f8fdf5375e2005 ("ASoC:
> fsl-ssi: add SSIEN errata work around").

I understand what's this patch doing.

> In this commit SSIEN, TE and RE are written at the same time as a
> workaround to ENGcm06222 and ENGcm06532 from the errata document.

Are you sure? Because there is a line of code set SSIEN separately
right before the line that this patch applies to. So this patch
actually only applies the workaround for ENGcm06532 (the bug when
setting RX prior to TX.)


> Seems to cause other issues though as reported by Caleb and Arnaud, so
> we need to find other way to solve this.
> > Then, the test case: aplay swap_test.wav& sleep 1; killall aplay
> >
> > It doesn't involve RE at all. So I don't get why setting RE and
> > TE together after setting SSIEN (three bits are not set together
> > here.) could solve the channel swapping problem for a test case
> > which has never involved RE at all. Am I missing something?
> 
> Your understanding is correct. In my usecase there is no audio capture
> involved at all, just stereo audio playback.
> 
> The only explanation I can give is the same one from commit
> f8fdf5375e2005 ("ASoC: fsl-ssi: add SSIEN errata work around").

I don't think that's an explanation. For non-AC97 cases, we are not
setting SSIEN and TE together at all, even by applying this change.

> Do you have access to any imx board with SSI?
I do. Will try to test it later.
