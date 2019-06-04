From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: core: move DAI pre-links initiation
	to snd_soc_instantiate_card
Date: Tue, 4 Jun 2019 11:37:10 +0800
Message-ID: <CA+Px+wXYMyQvcrLkabsXQYdFroBqBSMpz2Jj-w6MxWR1kHot7Q@mail.gmail.com>
References: <20190530073229.121032-1-tzungbi@google.com>
 <CA+Px+wXJsar1X=1EdDvMDvPv4DzDG+BmOgSopAqU48Y3Qa=acg@mail.gmail.com>
 <CAOReqxiJGEsEBR7g3sK57d_b3SZJZBCmfrARpCSWBiEm6sNk6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42A13F896CE
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2019 05:37:23 +0200 (CEST)
Received: by mail-oi1-x242.google.com with SMTP id b21so10571104oic.8
 for <alsa-devel@alsa-project.org>; Mon, 03 Jun 2019 20:37:23 -0700 (PDT)
In-Reply-To: <CAOReqxiJGEsEBR7g3sK57d_b3SZJZBCmfrARpCSWBiEm6sNk6w@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Curtis Malainey <cujomalainey@google.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 4, 2019 at 1:10 AM Curtis Malainey <cujomalainey@google.com> wrote:
>
> > >  probe_end:
> > > -       if (ret < 0)
> > > +       if (ret < 0 && ret != -EPROBE_DEFER)
> > >                 soc_cleanup_card_resources(card);
> > Should not call soc_cleanup_card_resources() if soc_init_dai_link()
> > returns fail.  Some context has not initialized yet in the case.
> Why not? You need to clean up the platform naming if links fails which
> will causes a use-after-free bug if you don't clean it up.
Some context may have not initialized if soc_init_dai_link() returns
fail.  See v2 https://patchwork.kernel.org/patch/10974149/ if it would
help.
