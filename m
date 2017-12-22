From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: rcar: tidyup simple-card example for
	CPU node
Date: Fri, 22 Dec 2017 09:02:19 +0100
Message-ID: <CAMuHMdUsRLfj4tdoJrSRtNGv-B8LQ+AxHca4qizry29xZ9ou=w@mail.gmail.com>
References: <873743nxuj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 184D3266FD2
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 09:02:20 +0100 (CET)
Received: by mail-qk0-f196.google.com with SMTP id q14so21113259qke.7
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 00:02:20 -0800 (PST)
In-Reply-To: <873743nxuj.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Simon <horms@verge.net.au>, Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

CC DT

On Fri, Dec 22, 2017 at 6:29 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> commit a5702e1cb3c ("ASoC: rsnd: Drop unit-addresses without reg
> properties") modifies simple-card multi CPU nodes.
> But, naming of "cpu-x" breaks probing.
> Let's add reg = <x>; instead of renaming node.
>
> Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> index 085bec3..51b7324 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> @@ -197,12 +197,17 @@ Ex)
>         [MEM] -> [SRC2] -> [CTU03] -+
>
>         sound {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
>                 compatible = "simple-scu-audio-card";
>                 ...
> -               simple-audio-card,cpu-0 {
> +               simple-audio-card,cpu@0 {
> +                       reg = <0>;
>                         sound-dai = <&rcar_sound 0>;
>                 };
> -               simple-audio-card,cpu-1 {
> +               simple-audio-card,cpu@1 {
> +                       reg = <1>;
>                         sound-dai = <&rcar_sound 1>;
>                 };
>                 simple-audio-card,codec {
> --
> 1.9.1
