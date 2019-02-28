From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: adau1977: Fix reset-gpios typo
Date: Thu, 28 Feb 2019 12:36:13 -0600
Message-ID: <20190228183613.GA5519@bogus>
References: <20190215102633.12700-1-bogdan.togorean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D33DF896C7
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 19:36:16 +0100 (CET)
Received: by mail-ot1-f66.google.com with SMTP id g1so18551389otj.11
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 10:36:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190215102633.12700-1-bogdan.togorean@analog.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, robh+dt@kernel.org, broonie@kernel.org, Bogdan Togorean <bogdan.togorean@analog.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 15 Feb 2019 12:26:33 +0200, Bogdan Togorean wrote:
> This change fixes a typo in the dt-binding examples (reset_gpio ->
> reset-gpios).
> Even though 'reset-gpio' is a valid construct for gpiolib the naming
> 'reset-gpios' is more suited for dt-bindings documentation.
> 
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> ---
>  Documentation/devicetree/bindings/sound/adi,adau1977.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
