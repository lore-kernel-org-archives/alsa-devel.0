From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: CX20442: fix NULL pointer dereference
Date: Tue, 01 Feb 2011 12:07:50 +0000
Message-ID: <1296562070.4120.3.camel@dplaptop.localdomain>
References: <201102011301.17699.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9E39D24499
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 13:09:44 +0100 (CET)
In-Reply-To: <201102011301.17699.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-01 at 13:01 +0100, Janusz Krzysztofik wrote:
> The CX20442 codec driver never provided the snd_soc_codec_driver's 
> .reg_cache_default member. With the latest ASoC framework changes, it 
> seems to be referred unconditionally, resulting in a NULL pointer 
> dereference if missing. Provide it.

This shouldn't happen with the latest ASoC as there is support for NULL
default caches.  In particular the following code should be taking care
of the NULL pointer dereference

if (codec_drv->reg_cache_default) {
	codec->reg_def_copy = kmemdup(...);
	if (!codec->reg_def_copy) {
		ret = -ENOMEM;
		goto fail;
	}
}

If this is not what soc-core looks like for you please pull broonie's
latest development tree.

Thanks,
Dimitris
