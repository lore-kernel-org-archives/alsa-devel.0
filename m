From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Wed, 21 Jan 2015 21:14:07 +0100
Message-ID: <54C0088F.9070609@metafoo.de>
References: <cover.1421868426.git.moinejf@free.fr>
 <d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-067.synserver.de (smtp-out-067.synserver.de
 [212.40.185.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 93B23260494
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 21:14:07 +0100 (CET)
In-Reply-To: <d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

[...]
> +	card->dai_link->dai_fmt =
> +		snd_soc_of_parse_daifmt(of_cpu, "dt-audio-card,",
> +					NULL, NULL) &
> +			~SND_SOC_DAIFMT_MASTER_MASK;


This one does not seem to be in the bindings documentation.
