From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-cache: Fix memory overflow in
 LZO initialization
Date: Tue, 30 Nov 2010 12:54:59 +0000
Message-ID: <20101130125458.GG7403@rakim.wolfsonmicro.main>
References: <1291031013-16686-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59E1E10396A
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 13:55:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291031013-16686-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Mon, Nov 29, 2010 at 11:43:33AM +0000, Dimitris Papastamos wrote:
> The bitmap_zero() nbits argument was improperly set to reg_size
> but the underlying buffer was bmp_size long.  This caused the memset
> to zero past the end of the allocated buffer and into the kernel heap
> causing strange kernel crashes sometimes by overwriting critical
> kernel structures.

Applied, thanks.
