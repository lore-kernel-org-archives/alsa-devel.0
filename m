From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] asoc: multi-component: mpc8610: fix typo
 in mpc8610_hpcd_data
Date: Sat, 17 Jul 2010 19:15:27 +0100
Message-ID: <1279390527.3070.8.camel@odin>
References: <1279230900-26193-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FCB110380D
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jul 2010 20:15:29 +0200 (CEST)
Received: by wyf19 with SMTP id 19so3061048wyf.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2010 11:15:29 -0700 (PDT)
In-Reply-To: <1279230900-26193-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-07-15 at 16:55 -0500, Timur Tabi wrote:
> The dma_id[] variable in struct mpc8610_hpcd_data is a zero-length
> array, when it should be of length 2.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> Liam, please squash this into your repository.
> 

Thanks

Applied

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
