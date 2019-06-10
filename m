From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: don't call
	soc_cleanup_card_resources() at snd_soc_instantiate_card()
Date: Mon, 10 Jun 2019 10:40:37 +0800
Message-ID: <CA+Px+wWX3eLQuvPFA=nJ7kn=fGa6yaR5CzgGkPjac_zKT4K-dw@mail.gmail.com>
References: <87ef42uzgd.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16B80F8070E
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2019 04:40:51 +0200 (CEST)
Received: by mail-ot1-x344.google.com with SMTP id d17so6948366oth.5
 for <alsa-devel@alsa-project.org>; Sun, 09 Jun 2019 19:40:51 -0700 (PDT)
In-Reply-To: <87ef42uzgd.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

The same change has been made and applied to for-next in commit
0779935938b1 ("ASoC: Remove erroneous soc_cleanup_card_resources()
call").
