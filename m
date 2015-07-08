From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2 3/4] ASoC: fsl_ssi: Add driver suspend
	and resume to support MEGA Fast
Date: Wed, 8 Jul 2015 10:06:29 -0400
Message-ID: <AF7CC648-4426-47F7-BD31-A7C7C5F858F3@tabi.org>
References: <ee6572bca11f44288db1d38e1934c0a7e7fb9ed2.1436339869.git.zidan.wang@freescale.com>
 <32243d772f82eb67e4a561b842be9661d730f0b1.1436339869.git.zidan.wang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id C01C4261545
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 16:06:31 +0200 (CEST)
In-Reply-To: <32243d772f82eb67e4a561b842be9661d730f0b1.1436339869.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Jul 8, 2015, at 3:22 AM, Zidan Wang wrote:

> For i.MX6 SoloX, there is a mode of the SoC to shutdown all power
> source of modules during system suspend and resume procedure. Thus,
> SSI needs to save all the values of registers before the system
> suspend and restore them after the system resume.
> 
> The register SFCSR is volatile, but some bits in it need to be
> recovered after suspend/resume.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

This seems okay, but I'm on vacation this week, so I won't have a chance to verify it until next week.
