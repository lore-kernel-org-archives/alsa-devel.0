From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ASoC: generic: add simple card with
	devicetree support
Date: Sat, 20 Jul 2013 22:23:36 +0200
Message-ID: <51EAF1C8.2070009@gmail.com>
References: <20130720192554.79b7061b@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f53.google.com (mail-ee0-f53.google.com [74.125.83.53])
 by alsa0.perex.cz (Postfix) with ESMTP id A405F2608CA
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 22:23:20 +0200 (CEST)
Received: by mail-ee0-f53.google.com with SMTP id c41so3051730eek.40
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 13:23:20 -0700 (PDT)
In-Reply-To: <20130720192554.79b7061b@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On 20.07.2013 19:25, Jean-Francois Moine wrote:
> This generic simple card driver uses DT values to instanciate an audio
> system in which the real work is done by the subdrivers (audio
> controller, audio codec and pcm/dma controller).
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---

> diff --git a/sound/soc/generic/simple-dt-card.c b/sound/soc/generic/simple-dt-card.c
> new file mode 100644

There is a simple-card driver in the tree already, and there were
several attempts to add DT bindings for it in the past - have you seen
that? Search for "ASoC: add simple-card DT support" in the archives ...


Daniel
