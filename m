From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: pcm: Fix DPCM for aux_devs
Date: Tue, 08 May 2012 12:00:32 +0100
Message-ID: <1336474832.4895.0.camel@odin>
References: <1336469650-12524-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 55426104250
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 13:00:38 +0200 (CEST)
Received: by werp11 with SMTP id p11so4663167wer.8
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 04:00:35 -0700 (PDT)
In-Reply-To: <1336469650-12524-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-05-08 at 10:34 +0100, Mark Brown wrote:
> When we instantiate an aux_dev we use a fake rtd as part of the process
> which doesn't have a dai_link associated with it. Fix the dpcm startup
> code to cope with this.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
