From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: sound: sun4i-spdif: Document that the
 RX channel can be missing
Date: Thu, 16 May 2019 08:23:58 -0500
Message-ID: <CAL_JsqKKE1XT12SdqG=nUnW0-F9Nb8VNxHq0jwm_AYowRKjJOA@mail.gmail.com>
References: <706cb97ae45cc9edc49c8709b2189ed786d2c7db.1557993523.git-series.maxime.ripard@bootlin.com>
 <a0558cf83011d21c4f44fecc078dff1e67cdbe9d.1557993523.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a0558cf83011d21c4f44fecc078dff1e67cdbe9d.1557993523.git-series.maxime.ripard@bootlin.com>
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
> The H3 and compatibles controllers don't have any reception capabilities,
> even though it was never documented as such in the binding before.
>
> Therefore, on those controllers, we don't have the option to set an RX DMA
> channel.
>
> This was already done in the DTSI, but the binding itself was never
> updated. Let's add a special case in the schemas.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v2:
>   - Removed the expanded items description and rely on yaml-bindings tools
>     to fill them
>   - Fix typo in dmas property description
>
> Changes from v1:
>   - switch to a draft7 conditional
> ---
>  Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
