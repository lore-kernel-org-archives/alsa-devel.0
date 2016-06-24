From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/7] Documentation: of: add type property
Date: Fri, 24 Jun 2016 12:41:39 -0500
Message-ID: <CAL_JsqKxYUXJoAmYQOiSVdodKmrEPqVgm84ZVhhEw=FuJQhZTw@mail.gmail.com>
References: <87fus3xr2q.wl%kuninori.morimoto.gx@renesas.com> <87eg7nxr00.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87eg7nxr00.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Guennadi <g.liakhovetski@gmx.de>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 23, 2016 at 9:32 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> OF graph is used mainly from V4L2, but ALSA needs to use it too.
> Then, ALSA needs to know each port/endpoint type, otherwise it
> can't detect ALSA port/endpoint correctly.

Bindings should be defined in terms of hardware, not Linux subsystems.

> This patch enables to use type property on OF graph.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  Documentation/devicetree/bindings/graph.txt | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/graph.txt b/Documentation/devicetree/bindings/graph.txt
> index fcb1c6a..b5b9040 100644
> --- a/Documentation/devicetree/bindings/graph.txt
> +++ b/Documentation/devicetree/bindings/graph.txt
> @@ -110,6 +110,32 @@ device-2 {
>          };
>  };
>
> +port / endpoint type
> +--------------------
> +
> +Each ports / port / endpoint can have its type if needed.

I think type should only apply to a port. ports is only a grouping for
multiple ports. endpoints are just the connection. A port is a single
data flow, so 2 endpoints on a port reflect 2 possible connections for
that data flow.

> +child node can take over parent node type. below example indicates
> +device0 type is "typeA" && "typeB",
> +device1 type is "typeA" && "typeB" && "typeC".

This does not make sense to me. A concrete example perhaps using HDMI
audio would be helpful.

> +
> +device {
> +       ports {
> +               type = "typeA";
> +
> +               port@0 {
> +                       type = "typeB";
> +
> +                       device0: endpoint@0 {
> +                       };
> +
> +                       device1: endpoint@1 {
> +                               type = "typeC";
> +                       };
> +               };
> +               ...
> +       };
> +};
> +
>
>  Required properties
>  -------------------
> --
> 1.9.1
>
