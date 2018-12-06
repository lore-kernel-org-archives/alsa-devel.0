From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: Use of_node_name_eq for node name comparisons
Date: Thu, 6 Dec 2018 09:53:12 +0800
Message-ID: <CAGoOwPReuEgzgYng0YeffgejVKPcoQinnNeFu_f2QBgs5daGdg@mail.gmail.com>
References: <20181205195050.4759-33-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205195050.4759-33-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Rob,

On Thu, Dec 6, 2018 at 3:51 AM Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For the FSL ASoC card, the full node names appear to be "ssi", "esai",
> and "sai", so there's not any reason to use strstr and of_node_name_eq

I am not quite sure about the replacement of strstr.
IIRC, a node name in fsl dts might appear to be "ssi@xxxx".

I am currently out of town so cannot verify the patch.

Fabio, would it be possible for you to run a boot test?

Thanks
Nicolin
