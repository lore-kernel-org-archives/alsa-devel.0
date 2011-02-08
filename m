From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [patch] ALSA: soc-cache: dereferencing before
 checking
Date: Tue, 08 Feb 2011 10:45:24 +0000
Message-ID: <1297161924.14540.0.camel@dplaptop.localdomain>
References: <20110207190141.GJ4384@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E8A824458
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 11:48:16 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-02-07 at 22:01 +0300, Dan Carpenter wrote:
> The patch c358e640a66 "ASoC: soc-cache: Add trace event for
> snd_soc_cache_sync()" introduced a dereference of "codec->cache_ops"
> before we had checked it for NULL.
> 
> I pulled the check forward, and then pulled everything in an indent
> level.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Dah, thanks for catching this.

Dimitris
