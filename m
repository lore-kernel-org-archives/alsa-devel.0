From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] sound/soc/soc-core.c: drop kfree of
 devm_kzalloc's data
Date: Sat, 4 Aug 2012 15:32:04 +0100
Message-ID: <20120804143200.GD15691@opensource.wolfsonmicro.com>
References: <1344081632-4729-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0379265B66
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 11:53:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1344081632-4729-3-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, matthias@kaehlcke.net, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 04, 2012 at 02:00:32PM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Using kfree to free data allocated with devm_kzalloc causes double frees.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)

Might it make more sense to devm_kfree() them?  If we don't expect to
immediately abort driver instantiation it'll save having them lying
around for the entire lifetime of the device even if they're not
strictly leaked.
