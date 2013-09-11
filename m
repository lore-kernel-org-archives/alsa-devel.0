From: Jyri Sarha <oku@iki.fi>
Subject: Re: [PATCH RFC 2/8] ASoC: davinci-evm: Add device tree
	binding
Date: Wed, 11 Sep 2013 13:38:47 +0300
Message-ID: <7fd2aed6239e4bbb791a4f232c74881a@kapsi.fi>
References: <cover.1378738436.git.jsarha@ti.com>
 <2f2fa45507656c464b413a9761c7dd2059f4590e.1378738436.git.jsarha@ti.com>
 <20130909152146.GK29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kapsi.fi (mail.kapsi.fi [217.30.184.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B383260850
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2013 12:38:52 +0200 (CEST)
In-Reply-To: <20130909152146.GK29403@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 2013-09-09 18:21, Mark Brown wrote:
> On Mon, Sep 09, 2013 at 06:12:13PM +0300, oku@iki.fi wrote:
> From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
> 
> Device tree support for Davinci Machine driver
...
> +  Codec pins:
> +
> +  * MIC3L
> +  * MIC3R
> +  * LINE1L
> +  * LINE2L
> +  * LINE1R
> +  * LINE2R
> 
> These should be documented in the binding for the CODEC and referenced
> here - if there isn't a binding for the CODEC you should add it.
> 

After checking the code, are you sure about this? Non of the other
codecs have pins in their devicetree binding document?

Best regards,
Jyri
