From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: add sunxi SPDIF
 transceiver bindings
Date: Mon, 5 Oct 2015 10:41:33 +0200
Message-ID: <20151005084133.GE2696@lukather>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
 <1443635458-8873-2-git-send-email-codekipper@gmail.com>
 <20151001201215.GN7104@lukather>
 <CAEKpxB=kdmrbeiq8M=dXmpccxOhd7UZTaMkLZGo9TdRB1kMz3g@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBSHPZCYAKGQEFTL6E4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEKpxB=kdmrbeiq8M=dXmpccxOhd7UZTaMkLZGo9TdRB1kMz3g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Oct 02, 2015 at 07:24:20AM +0200, Code Kipper wrote:
> >> +
> >> +  - compatible               : should be one of the following:
> >> +    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
> >> +    - "allwinner,sun7i-a20-spdif": for the Allwinner A20 SoC
> >> +    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
> >
> > Are all these compatibles really work? Is there any significant
> > difference between the controller on all these SoCs?
>
> Let us assume that there isn't any difference. Remember SPDIF details
> for all of these devices is sketchy. In the A10 User Manual, it's not
> even mentioned although devices such as the Mele A2000 which I use
> come with the physical connector. It's only when the A20 Manual was
> released that we see the pin details and related components. We didn't
> see a SPDIF block spec until the H3 User Manual was released.
> 
> Looking at the SDK code I've only seen fifo level settings to be
> different for the sun6i family. It was this release that also showed
> Rx rotines. The fact of the matter is we won't know until these SoCs
> have been tested and with that in mind I'm happy to remove all
> capabilities for now until then.

The point was more that you document compatibles that you are not
actually supporting.

You've only tested it on one SoC (and it actually works only on one
SoC, or at least with one compatible), so only document that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--wULyF7TL5taEdwHz--
