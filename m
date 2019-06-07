From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: Fix freeing of incompletely
	initialized snd_soc_dapm_context
Date: Fri, 7 Jun 2019 23:02:37 +0800
Message-ID: <CA+Px+wUOjG9YvDrPud7TH1xdBVDX50Y9f3mA8hgyFQBVTgM==A@mail.gmail.com>
References: <CGME20190607141821epcas2p120786c8cc5a1f1b71dbd1828b0a9d837@epcas2p1.samsung.com>
 <20190607141745.759-1-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B46A6F896CE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 17:02:50 +0200 (CEST)
Received: by mail-oi1-x241.google.com with SMTP id s184so1640096oie.9
 for <alsa-devel@alsa-project.org>; Fri, 07 Jun 2019 08:02:50 -0700 (PDT)
In-Reply-To: <20190607141745.759-1-s.nawrocki@samsung.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Jimmy Cheng-Yi Chiang <cychiang@google.com>, kuninori.morimoto.gx@renesas.com, b.zolnierkie@samsung.com, Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>, Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@google.com>, m.szyprowski@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 7, 2019 at 10:18 PM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> When soc_init_dai_link() call at the beginning of snd_soc_instantiate_card
> function fails soc_cleanup_card_resources() and then snd_soc_dapm_free()
> gets called with an incompletely initialized card->dapm. In particular
> card->dapm.card is NULL and it gets dereferenced in dapm_free_widgets().
> Also dapm->list is invalid and there is an invalid pointer dereference
> from list_del().
>
You don't need to do this.  In my original patch
(https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=70fc53734e71ce51f46dfcfd1a1c319e1cfe080c),
soc_cleanup_card_resources() should not be called if
soc_init_dai_link() returns fail.

I found there is a merge conflict.  Kuninori Morimoto removed some
legacy code (i.e. soc_cleanup_platform() -> soc_cleanup_legacy()) at
the same time (https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=adb76b5b9c4740a11f6ad6c68764515961ae8ade).

But, the conflict was not fixed correctly
(https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=a8e992342ce4cd173d437d0aa4eecc9e30489f72),
the soc_cleanup_platform() turns to soc_cleanup_card_resources().

Based on current for-next branch, we could simply remove the
soc_cleanup_card_resources() call.
