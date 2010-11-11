From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 0/3] ASoC: Introduce the new caching API
Date: Thu, 11 Nov 2010 11:39:29 +0000
Message-ID: <1289475569.3273.7.camel@odin>
References: <1289469899-5787-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 202D024350
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 12:39:33 +0100 (CET)
Received: by wyb34 with SMTP id 34so90390wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 03:39:32 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-11 at 10:04 +0000, Dimitris Papastamos wrote:
> This patch series introduces the new caching API.  The idea behind this
> caching interface is that we can provide different means of organizing
> and accessing the register cache.  This is useful for large and sparse
> register maps, where one can use some kind of compression algorithm to
> reduce the memory footprint.  The caching API is designed in such way to
> eliminate the need for modifying any existing drivers.
> 
> TODO:
>  - Memory usage statistics, to make it easier to select the proper caching
>  technique.
>  - Support for bulk reads/writes.
>  - Overridable caching behaviour from the machine driver.
>  - Optimize certain CPU intensive paths.
>  - Ensure proper locking in init()/exit()/sync().
> 
> Dimitris Papastamos (3):
>   ASoC: soc-cache: Add support for flat register caching
>   ASoC: soc-cache: Add support for LZO register caching
>   ASoC: soc-cache: Add support for rbtree based register caching
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
