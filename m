From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/3] ASoC: Introduce the new caching API
Date: Thu, 11 Nov 2010 16:20:03 +0000
Message-ID: <20101111162002.GG6052@rakim.wolfsonmicro.main>
References: <1289469899-5787-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A6C231037EE
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 17:20:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289469899-5787-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Thu, Nov 11, 2010 at 10:04:56AM +0000, Dimitris Papastamos wrote:
> This patch series introduces the new caching API.  The idea behind this
> caching interface is that we can provide different means of organizing
> and accessing the register cache.  This is useful for large and sparse
> register maps, where one can use some kind of compression algorithm to
> reduce the memory footprint.  The caching API is designed in such way to
> eliminate the need for modifying any existing drivers.

Applied, thanks.

> TODO:
>  - Memory usage statistics, to make it easier to select the proper caching
>  technique.
>  - Support for bulk reads/writes.
>  - Overridable caching behaviour from the machine driver.

This one in particular would be very good.
