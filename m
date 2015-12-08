From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/19] ASoC: da7218: avoid 64-bit compile
	warning
Date: Tue, 08 Dec 2015 16:14:27 +0100
Message-ID: <6859274.7lKHWvMkkW@wuerfel>
References: <3548574.qiC2AlzHH4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by alsa0.perex.cz (Postfix) with ESMTP id DD436260438
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 16:14:33 +0100 (CET)
In-Reply-To: <3548574.qiC2AlzHH4@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 08 December 2015 16:12:54 Arnd Bergmann wrote:
> When building the da7218 driver on a 64-bit architecture, we get
> a harmless warning:
> 
> sound/soc/codecs/da7218.c: In function 'da7218_of_get_id':
> sound/soc/codecs/da7218.c:2261:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> This changes the code to use uintptr_t to ensure we have an integer
> type of the same size as a pointer and won't get a warning on any
> architecture.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4d50934abd22 ("ASoC: da7218: Add da7218 codec driver")

Please ignore the "[01/19]", I didn't mean to send this as a series, so just
apply it directly. I happen to send 19 patches to different maintainers
and misused git-format-patch.

	Arnd
