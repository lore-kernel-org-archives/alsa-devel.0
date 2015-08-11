From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH v3 1/4] ASoC: fsl_sai: Add driver suspend
 and resume to support MEGA Fast
Date: Tue, 11 Aug 2015 17:34:49 +0800
Message-ID: <20150811093448.GC28723@shlinux2>
References: <6fa4e6ebf1f34f5d637324c9f62e68b03037568c.1438928296.git.zidan.wang@freescale.com>
 <20150811091220.GA3008@Asurada-CZ80>
 <CAOMZO5Bs223E-gypxNM_GA6qrOc8yXO=yMH7UTCCU5VV_EbVOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0138.outbound.protection.outlook.com [157.56.110.138])
 by alsa0.perex.cz (Postfix) with ESMTP id F231E2604DD
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 12:45:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5Bs223E-gypxNM_GA6qrOc8yXO=yMH7UTCCU5VV_EbVOQ@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.com, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 07:41:52AM -0300, Fabio Estevam wrote:
> On Tue, Aug 11, 2015 at 6:12 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > On Fri, Aug 07, 2015 at 02:21:05PM +0800, Zidan Wang wrote:
> >> For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
> >> modules during system suspend and resume procedure. Thus, SAI needs to save
> >> all the values of registers before the system suspend and restore them after
> >> the system resume.
> >>
> >> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> >
> > Have you tested this series based on the for-next branch?
> 
> I am also interested in testing sai, but if I recall correctly we
> still miss the SDMA remap feature, right?
> 
I have sent the SDMA remap patch to community, but have no response now. I can share the patch for you.

Best Regards,
Zidan Wang
> Regards,
> 
> Fabio Estevam
