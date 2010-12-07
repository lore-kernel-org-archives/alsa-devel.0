From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
	dereference
Date: Tue, 7 Dec 2010 16:22:45 +0000
Message-ID: <20101207162244.GG9689@rakim.wolfsonmicro.main>
References: <1291738866-24470-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE79B103AC4
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 17:22:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291738866-24470-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Tue, Dec 07, 2010 at 04:21:06PM +0000, Dimitris Papastamos wrote:
> In case the codec driver did not provide a read/write function,
> codec->driver->read|write will be NULL.  Ensure that we use the one
> specified in codec->read|write to avoid oopsing when we access
> the debugfs entries.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

These should instead be converted to use snd_soc_read() and
snd_soc_write() so we're doing all the indirection in one place.
