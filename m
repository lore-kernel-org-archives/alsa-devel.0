From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: arizona: Add data structure for voice trigger notifier
Date: Tue, 31 May 2016 13:58:53 +0200
Message-ID: <26834776.a9zKDjMD7P@wuerfel>
References: <1464695057-11723-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1464695057-11723-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-next-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, sfr@canb.auug.org.au
List-Id: alsa-devel@alsa-project.org

On Tuesday, May 31, 2016 12:44:17 PM CEST Charles Keepax wrote:
> 64-bit builds would generate a warning when we passed the core number as
> a pointer through the notifier data:
> 
> sound/soc/codecs/cs47l24.c:1091:13: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]
>              (void *)i);
> 
> Rather than just fix this up with more casting add a data structure that
> holds information for the notifier chain. This will make it easier to
> add additional information in the future as well.
> 
> Fixes: 7baa7e2490e1 ("ASoC: arizona: Add event notification on voice trigger events")
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com> 

Thanks for addressing it so quickly!

Acked-by: Arnd Bergmann <arnd@arndb.de>
