From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Add missing control_type
	initialization
Date: Tue, 28 Dec 2010 23:34:04 +0000
Message-ID: <20101228233404.GA3591@opensource.wolfsonmicro.com>
References: <1293566937-7937-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F3021038F0
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2010 00:33:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293566937-7937-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 09:08:57PM +0100, Lars-Peter Clausen wrote:
> Some codec drivers do not initialize the control_type field in their private
> device struct, but still use it when calling snd_soc_codec_set_cache_io.
> This patch fixes the issue by properly initializing it in the drivers probe
> functions.

Applied for 2.6.37.  Some of the drivers could skip this as the hardware
only supports one bus but it doesn't really matter for the fix.
