From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: soc.h: Add new caching API
 prototypes and hooks
Date: Fri, 22 Oct 2010 08:44:39 -0700
Message-ID: <20101022154438.GD16521@opensource.wolfsonmicro.com>
References: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1287757702-9573-2-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FEF410385C
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 17:44:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1287757702-9573-2-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 22, 2010 at 03:28:19PM +0100, Dimitris Papastamos wrote:
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Where possible you should try to split your series up such that each
is useful individually - splitting things up by file is mostly done for
the addition of large new blocks of code.  This means that the patches
can be applied one at a time without leaving the tree in an
"interesting" state.

> +int snd_soc_cache_sync(struct snd_soc_codec *codec);
> +int snd_soc_cache_init(struct snd_soc_codec *codec);
> +int snd_soc_cache_deinit(struct snd_soc_codec *codec);
> +int snd_soc_cache_write(struct snd_soc_codec *codec,
> +			unsigned int reg, unsigned int value);
> +int snd_soc_cache_read(struct snd_soc_codec *codec,
> +		       unsigned int reg, unsigned int *value);

For example, a patch adding the cache operations but supporting only the
current flat cache would introduce the cache API and factor out some
code usefully by itself.
