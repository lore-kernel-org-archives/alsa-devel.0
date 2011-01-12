From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] ASoC: Blackfin TDM: fix missed
 snd_soc_dai_get_drvdata update
Date: Tue, 11 Jan 2011 21:06:47 -0800
Message-ID: <20110112050647.GA18268@kroah.com>
References: <1294805299-5265-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B681245B9
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 16:35:53 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, stable@kernel.org, uclinux-dist-devel@blackfin.uclinux.org, stable-review@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 11:08:19PM -0500, Mike Frysinger wrote:
> One spot was missed in this driver when converting from
> snd_soc_dai.private_data to snd_soc_dai_get_drvdata.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Please read Documentation/stable_kernel_rules.txt for how to get patches
into the stable kernel tree (hint, add cc: stable in the signed-off-by
line).  Copying the patches to the stable and stable-review lists
(stable-review is only for the review of the stable releases) will cause
them to get lost as they aren't in Linus's tree yet, so I don't know the
git commit id of it.

Hope this helps,

greg k-h
