From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/2] ASoC: codec: wm9860: avoid
	maybe-uninitialized warning
Date: Thu, 27 Apr 2017 12:07:05 +0200
Message-ID: <CAK8P3a1ZGTyjhAzy4h2D10+-dFNi6o_qe0pY9Wx5wYXZK6ObDw@mail.gmail.com>
References: <1493212192-7930-1-git-send-email-daniel.baluta@nxp.com>
 <1493212192-7930-2-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 08807266483
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 12:07:07 +0200 (CEST)
Received: by mail-oi0-f49.google.com with SMTP id j201so31756452oih.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 03:07:07 -0700 (PDT)
In-Reply-To: <1493212192-7930-2-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 26, 2017 at 3:09 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> The new PLL configuration code triggers a harmless warning:
>
> sound/soc/codecs/wm8960.c: In function 'wm8960_configure_clocking':
> sound/soc/codecs/wm8960.c:735:3: error: 'best_freq_out' may be used
> uninitialized in this function [-Werror=maybe-uninitialized]
>    wm8960_set_pll(codec, freq_in, best_freq_out);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/codecs/wm8960.c:699:12: note: 'best_freq_out' was declared
> here
>
> Fix this by reworking the code such that:
>
> 1) When there is no PLL freq available return -EINVAL and make
> sure *bclk_idx, *dac_idx, *sysclk_idx are initialized with
> invalid values.
>
> 2) When there is a PLL freq available initialize *bclk_idx,
> *dac_idx and *sysclk_idx with correct values and immediately
> return the freq available.
>
> Fixes: 84fdc00d519f ("ASoC: codec: wm9860: Refactor PLL out freq search")
> Fixes: 303e8954af8d ("ASoC: codec: wm8960: Stop when a matching PLL freq is found")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Looks good to me. Let me know if you need me to test this more thoroughly
with randconfig builds, otherwise I'll assume it's fine and it will
get tested once
it shows up in linux-next.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for addressing this,

       Arnd
