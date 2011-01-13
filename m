From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Blackfin TDM: fix missed
 snd_soc_dai_get_drvdata update
Date: Thu, 13 Jan 2011 13:57:32 +0000
Message-ID: <1294927052.3453.11.camel@odin>
References: <1294805299-5265-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D5C510385E
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:57:36 +0100 (CET)
Received: by wyi11 with SMTP id 11so1713811wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 05:57:35 -0800 (PST)
In-Reply-To: <1294805299-5265-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, stable-review@kernel.org, uclinux-dist-devel@blackfin.uclinux.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-11 at 23:08 -0500, Mike Frysinger wrote:
> One spot was missed in this driver when converting from
> snd_soc_dai.private_data to snd_soc_dai_get_drvdata.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
