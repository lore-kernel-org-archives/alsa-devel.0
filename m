From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: sound: Convert Allwinner SPDIF
 binding to YAML
Date: Thu, 16 May 2019 08:24:57 -0500
Message-ID: <CAL_Jsq+4+LD+x-bd9iCwA4bGtRUjdqo7=g4HgGzcYTsZG17KLw@mail.gmail.com>
References: <706cb97ae45cc9edc49c8709b2189ed786d2c7db.1557993523.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <706cb97ae45cc9edc49c8709b2189ed786d2c7db.1557993523.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 16, 2019 at 2:59 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The Allwinner SoCs feature an SPDIF controller across multiple SoC
> generations.
>
> However, earlier generations were a bit simpler than the subsequent ones,
> and for example would always have RX and TX capabilities, and no reset
> lines.
>
> In order to express this, let's create two YAML schemas instead of the free
> form text we had before.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v2:
>   - Add comments
>
> Changes from v1:
>   - Merged the two schemas together and used the draft-7 conditionals
> ---
>  Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt          |  42 +------------------------------
>  2 files changed, 101 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt

Reviewed-by: Rob Herring <robh@kernel.org>
