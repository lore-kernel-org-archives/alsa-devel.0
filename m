From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] ASoC: kirkwood: add S/PDIF support
Date: Tue, 24 Sep 2013 11:51:27 +0100
Message-ID: <20130924105127.GB12758@n2100.arm.linux.org.uk>
References: <20130924124122.64834b2a@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130924124122.64834b2a@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 24, 2013 at 12:41:22PM +0200, Jean-Francois Moine wrote:
> This patch adds S/PDIF input/output for mvebu DT boards.
> 
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>

Right, so if this goes in, then we're completely fucked for doing this
the way that Mark apparantly wants it to be done, because once these
DT properties go in, they're there to stay.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
