From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] ASoC: codec: wm9860: avoid
	maybe-uninitialized warning
Date: Fri, 21 Apr 2017 16:46:04 +0200
Message-ID: <CAK8P3a3GD-S1-szw5tw1R8eSS0AXL_hwJm+d-KF4XuKtYGf-VQ@mail.gmail.com>
References: <1492780055-4892-1-git-send-email-daniel.baluta@nxp.com>
 <1492780055-4892-2-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D7B26266F52
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 16:46:05 +0200 (CEST)
Received: by mail-oi0-f51.google.com with SMTP id y11so65944969oie.0
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 07:46:05 -0700 (PDT)
In-Reply-To: <1492780055-4892-2-git-send-email-daniel.baluta@nxp.com>
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
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 21, 2017 at 3:07 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
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
> Fixes: 84fdc00d519f ("ASoC: codec: wm9860: Refactor PLL out freq search")
> Fixes: 303e8954af8d ("ASoC: codec: wm8960: Stop when a matching PLL freq is found")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Arnd,
>
> I agree that your code was more both humans and gcc anyhow
> for consistency with wm8960_configure_sysclk function I preferred
> to keep the "if(..) break" statements.

How about changing both functions the same way then?

      Arnd
