From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH v3 1/4] ASoC: fsl_sai: Add driver suspend
 and resume to support MEGA Fast
Date: Tue, 11 Aug 2015 17:28:36 +0800
Message-ID: <20150811092835.GB28723@shlinux2>
References: <6fa4e6ebf1f34f5d637324c9f62e68b03037568c.1438928296.git.zidan.wang@freescale.com>
 <20150811091220.GA3008@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BF6A2604C6
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 12:39:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150811091220.GA3008@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 02:12:21AM -0700, Nicolin Chen wrote:
> On Fri, Aug 07, 2015 at 02:21:05PM +0800, Zidan Wang wrote:
> > For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
> > modules during system suspend and resume procedure. Thus, SAI needs to save
> > all the values of registers before the system suspend and restore them after
> > the system resume.
> > 
> > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> 
> Have you tested this series based on the for-next branch?
> 
> I'm having trouble with suspend/resume test on my imx6sx-sdb.
> Both broonie/for-next and linux-next/master hanged after suspend
> even without this PATCH -- There should be some other patches
> that broke the suspend/resume. Do you know which one?
> 
I just rebase to the newest linux-next/master, and don't meet system hang after suspend on imx6sx-sdb board.
