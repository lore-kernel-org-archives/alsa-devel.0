From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 5/5] ASoC: fsl-sai: rename big_endian_data to
 is_msb_first.
Date: Sun, 24 Aug 2014 20:22:45 -0700
Message-ID: <20140825032244.GB30314@Alpha>
References: <1408421693-9929-1-git-send-email-Li.Xiubo@freescale.com>
 <1408421693-9929-6-git-send-email-Li.Xiubo@freescale.com>
 <53FAAB0D.2000403@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53FAAB0D.2000403-N01EOCouUvQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 24, 2014 at 10:18:37PM -0500, Timur Tabi wrote:
> Xiubo Li wrote:
> >-	sai->big_endian_data = of_property_read_bool(np, "big-endian-data");
> >+	sai->is_msb_first = of_property_read_bool(np, "msb-first");
> 
> This will break backwards compatibility with older device trees.

Yes.

Xiubo, you can try to fetch "big-endian-data" first. Then fetch
the new binding if the "big-endian-data" is absent. Just make
it compatible with both older device trees and the new one.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
