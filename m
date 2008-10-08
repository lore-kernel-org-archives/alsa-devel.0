From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] [ALSA] Allow setting codec register
	with	debugfs filesystem
Date: Wed, 8 Oct 2008 20:44:04 +0100
Message-ID: <20081008194404.GA3472@sirena.org.uk>
References: <1223490973-9310-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C4CF824519
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 21:44:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1223490973-9310-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 08, 2008 at 11:36:13AM -0700, Troy Kisky wrote:

> Mark, I didn't base it on dapm's pop_time directory
> because that hasn't made it to my testing kernel yet.
> I cannot test directly from the alsa git tree.

You should be able to cherry pick the relevant commits over without too
much hassle?  Should be commits:

f8f1179d34d5adb3b0fe45327050470aae9b3d7e
28dcfbeb157c58ae24d5ba173984bfc316ca95ee
ed5457f91695784d692190b1b8ff024ae462801c

in that order.  ASoC generally backports fairly easily since it doesn't
have too many ties into fast-changing parts of the system - you can
often get a long way by simply copying soc-core.c, soc-dapm.c, soc.h and
soc-dapm.h into your current version.

Could you give that a spin and let me know if you can get something
sorted out?

I did also notice:

> +#ifdef CONFIG_DEBUG_FS
> +static int code_reg_open_file(struct inode *inode, struct file *file)

Not sure why I didn't notice this before but codec_reg rather than code_reg?

BTW, please CC me on ASoC patch submissions - it makes it harder for me
to miss things on the list.
