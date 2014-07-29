From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and
 platform drivers
Date: Tue, 29 Jul 2014 10:46:13 +0100
Message-ID: <20140729094613.GK2576@leverpostej>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "timur-N01EOCouUvQ@public.gmane.org" <timur-N01EOCouUvQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, tklauser
List-Id: alsa-devel@alsa-project.org

> +   - big-endian : If this property is absent, the native endian mode will
> +                 be in use as default, or the big endian mode will be in use
> +                 for all the device registers.

Native endian is meaningless. If a CPU supports both BE and LE, there is
no native endianness. The endianness of the kernel is dynamic while the
endianness of registers in HW is fixed. 

Just choose an endianness to assume by default (presumably little). That
way this describes the HW and always works with a kernel of arbitrary
endianness.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
