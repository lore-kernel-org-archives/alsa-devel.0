From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: RE: [PATCH] sound/soc/mxs/mxs-saif.c: use devm_ functions
Date: Thu, 9 Feb 2012 18:37:35 +0000
Message-ID: <7FE21149F4667147B645348EC60578850C187F@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1328721262-20993-1-git-send-email-Julia.Lawall@lip6.fr>
 <7FE21149F4667147B645348EC60578850C1864@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7FE21149F4667147B645348EC60578850C1864@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng-B29396 <B29396@freescale.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Liam Girdwood <lrg@ti.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Dong Aisheng-B29396
> Sent: Thursday, February 09, 2012 10:35 AM
> To: Julia Lawall; Liam Girdwood
> Cc: kernel-janitors@vger.kernel.org; Mark Brown; Jaroslav Kysela; Takashi Iwai;
> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] sound/soc/mxs/mxs-saif.c: use devm_ functions
> 
> > -----Original Message-----
> > From: Julia Lawall [mailto:Julia.Lawall@lip6.fr]
> > Sent: Wednesday, February 08, 2012 9:14 AM
> > To: Liam Girdwood
> > Cc: kernel-janitors@vger.kernel.org; Mark Brown; Jaroslav Kysela;
> > Takashi Iwai; alsa-devel@alsa-project.org;
> > linux-kernel@vger.kernel.org; Dong Aisheng-B29396
> > Subject: [PATCH] sound/soc/mxs/mxs-saif.c: use devm_ functions
> > Importance: High
> >
> > From: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > The various devm_ functions allocate memory that is released when a
> > driver detaches.  This patch uses these functions for data that is
> > allocated in the probe function of a platform device and is only freed in the
> remove function.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > ---
> > patch against
> > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> >
> I still failed to apply against for-3.4 branch.
> Can you switch to for-3.4 branch and then re-generate the patch based on it?
> 
Make sure update to the latest on for-3.4 branch for making the patch.

Regards
Dong Aisheng
