From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix inconsistent meaning of default
 case while checking alc5623->id
Date: Fri, 3 Dec 2010 12:25:54 +0000
Message-ID: <20101203122554.GT859@rakim.wolfsonmicro.main>
References: <1291368357.20452.6.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 52175103B3C
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 13:25:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291368357.20452.6.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 03, 2010 at 05:25:57PM +0800, Axel Lin wrote:
> In alc5623_i2c_probe(),
> the default case for checking alc5623->id behaves the same as case 0x23.
> However, In alc5623_probe() the default case for checking alc5623->id
> becomes to be the same as case 0x21.
> This makes the meaning of default case inconsistent.

Applied, thanks.
