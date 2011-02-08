From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] ALSA: soc-cache: dereferencing before
	checking
Date: Tue, 8 Feb 2011 11:32:57 +0000
Message-ID: <20110208113256.GC29850@opensource.wolfsonmicro.com>
References: <20110207190141.GJ4384@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C4D872447B
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 12:32:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110207190141.GJ4384@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 07, 2011 at 10:01:41PM +0300, Dan Carpenter wrote:
> The patch c358e640a66 "ASoC: soc-cache: Add trace event for
> snd_soc_cache_sync()" introduced a dereference of "codec->cache_ops"
> before we had checked it for NULL.

Applied, thanks.  Please try to use subject lines for your patches which
are consistent with the subsystem you're submitting to.
