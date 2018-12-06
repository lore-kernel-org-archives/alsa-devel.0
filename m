From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: Use of_node_name_eq for node name comparisons
Date: Thu, 6 Dec 2018 07:34:18 -0600
Message-ID: <CAL_JsqJiQnQ0PgQz-G=Cj0-cEffMDx0H8vR7wjB25qwRWo-xRw@mail.gmail.com>
References: <20181205195050.4759-33-robh@kernel.org> <CAGoOwPReuEgzgYng0YeffgejVKPcoQinnNeFu_f2QBgs5daGdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGoOwPReuEgzgYng0YeffgejVKPcoQinnNeFu_f2QBgs5daGdg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 5, 2018 at 7:53 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi Rob,
>
> On Thu, Dec 6, 2018 at 3:51 AM Rob Herring <robh@kernel.org> wrote:
> >
> > Convert string compares of DT node names to use of_node_name_eq helper
> > instead. This removes direct access to the node name pointer.
> >
> > For the FSL ASoC card, the full node names appear to be "ssi", "esai",
> > and "sai", so there's not any reason to use strstr and of_node_name_eq
>
> I am not quite sure about the replacement of strstr.
> IIRC, a node name in fsl dts might appear to be "ssi@xxxx".

That will work fine. Unit-addresses are not part of the node name for
the comparison.

> I am currently out of town so cannot verify the patch.
>
> Fabio, would it be possible for you to run a boot test?
>
> Thanks
> Nicolin
