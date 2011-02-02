From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Remove display_register()
	callback
Date: Wed, 2 Feb 2011 10:23:36 +0000
Message-ID: <20110202102335.GM12743@opensource.wolfsonmicro.com>
References: <1296642054-10485-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE2C3103819
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 11:23:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296642054-10485-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Wed, Feb 02, 2011 at 10:20:54AM +0000, Dimitris Papastamos wrote:
> Remove the display_register() callback as there are no users of it
> in the upstream kernel and makes it difficult to unify the format
> of the codec_reg file.

> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

This was rather strongly requested for some devices with extremely large
registers (128 bits at least IIRC) which may eventually make it to
mainline.  It seems better to just have some sort of fallback for those
devices, if it causes output problems people can always fix those.
