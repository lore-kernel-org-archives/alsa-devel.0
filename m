From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v12 2/6] sound/core: add DRM ELD helper
Date: Fri, 8 May 2015 12:32:49 +0100
Message-ID: <20150508113249.GG2067@n2100.arm.linux.org.uk>
References: <cover.1431083916.git.moinejf@free.fr>
 <df470448c18aed3eff448c5d7289e70d6447b691.1431083916.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <df470448c18aed3eff448c5d7289e70d6447b691.1431083916.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 08, 2015 at 10:01:05AM +0200, Jean-Francois Moine wrote:
> From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> 
> Add a helper for the EDID like data structure, which is typically passed
> from a HDMI adapter to its associated audio driver.  This informs the
> audio driver of the capabilities of the attached HDMI sink.
> 
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>

Why are you getting rid of my Sign-off?  This is just totally unacceptable
behaviour.  NAK.

Second reason for a NAK is that this code is not ready yet.  It has
issues with multiple SADs which are not trivial to resolve with ALSAs
(and therefore ASoCs) current architecture for refining the parameters,
and so far no one seems to be very helpful to getting that problem
resolved.  Hence the patch set is stalled on my side until such time
that people are willing to talk about the issue.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
