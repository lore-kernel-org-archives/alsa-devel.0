From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: WM8962: Let codec driver
	enable/disable its MCLK
Date: Fri, 24 Mar 2017 00:54:06 -0700
Message-ID: <20170324075405.GA2000@Asurada>
References: <1490270510-17061-1-git-send-email-daniel.baluta@gmail.com>
 <20170324045814.GA15344@Asurada-CZ80>
 <CAEnQRZCPcvkGUTc5bFKuOi-W1v39LmO_gAs31J_cWe6gFVVFEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 63550266954
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 08:54:15 +0100 (CET)
Received: by mail-pg0-f67.google.com with SMTP id w20so1619460pgc.1
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 00:54:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEnQRZCPcvkGUTc5bFKuOi-W1v39LmO_gAs31J_cWe6gFVVFEw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo.Lee@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, shengjiu.wang@nxp.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, mihai.serban@nxp.com, Mark Brown <broonie@kernel.org>, viorel.suman@nxp.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 24, 2017 at 09:37:00AM +0200, Daniel Baluta wrote:
> On Fri, Mar 24, 2017 at 6:58 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > On Thu, Mar 23, 2017 at 02:01:50PM +0200, Daniel Baluta wrote:
> >> From: Nicolin Chen <b42378@freescale.com>
> >>
> >> WM8962 needs its MCLK when powerup in wm8962_resume(). Thus it's better
> >> to control the MCLK in codec driver. Thus remove the clock enable in
> >> machine dirver accordingly.
> >>
> >> While at it, get rid of imx_wm8962_remove function since it is now
> >> empty.
> >>
> >> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> >
> > Hmm...it'd probably be better to let yourself be the author and remove
> > my signed-off here. Just got an email deliver failure since that email
> > address is apparently not available any more.
> 
> Hi Nic,
> 
> I will fix the prefix subject as suggested. Is it OK to use
> your current email address for the signed-off-by tag?

The email address in the "From" would probably still remain that one,
which causes the problem.

I personally prefer that you resend it using your own and I could give
an Ack to it. It isn't really necessary to let me take the credit :)

Thanks
Nicolin
