From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: ASoC: About graph node issue without 'reg' property
Date: Thu, 13 Dec 2018 19:39:45 +0900
Message-ID: <20181213193944.CCC9.4A936039@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hello Morimoto-san, Mark,

I found that your commit b6f3fc005a2c ("ASoC: simple-card-utils:
fixup asoc_simple_card_get_dai_id() counting") replaced with
of_graph_parse_endpoint(), that needs 'reg' property in each port
that has an endpoint.

Currently devicetrees for UniPhier SoCs have also audio graph nodes [1],
and these graph nodes include an endpoint for each port.
Although the port doesn't have 'reg' property, it has worked fine before.
And after applying the commit, it doesn't work.

It is written in Documentation/devicetree/bindings/graph.txt
that common scheme is to include the 'reg' property.

Maybe I think that we'd better add 'reg' properties to each port,
however, there might be same matter in other SoCs, so I'm not sure
whether your patch breaks the backword compatibility or
our devicetrees are wrong.

I'd be glad if I could hear something about this issue from you.

Thank you,

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi#n348

---
Best Regards,
Kunihiko Hayashi
