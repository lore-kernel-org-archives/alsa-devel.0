From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: clk: at91: add an I2S
	mux clock
Date: Wed, 20 Jun 2018 09:47:59 -0600
Message-ID: <20180620154759.GA4755@rob-hp-laptop>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-2-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D3E6266D4C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 17:48:02 +0200 (CEST)
Received: by mail-yw0-f193.google.com with SMTP id t184-v6so4894ywg.9
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 08:48:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180618141239.10892-2-codrin.ciubotariu@microchip.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, alexandre.belloni@bootlin.com, sboyd@kernel.org, nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com, broonie@kernel.org, Cristian.Birsan@microchip.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 18, 2018 at 05:12:35PM +0300, Codrin Ciubotariu wrote:
> The I2S mux clock can be used to select the I2S input clock. The
> available parents are the peripheral and the generated clocks.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v5:
> 	- specified clock's parent;
> 	- added a newline before adding the clock's compatible string;
> 
>  .../devicetree/bindings/clock/at91-clock.txt  | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)

Well, since Alexandre promises all this is going to get re-worked soon:

Acked-by: Rob Herring <robh@kernel.org>
