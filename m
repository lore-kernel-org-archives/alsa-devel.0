From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: stm32: fix sync property description in SAI
 bindings
Date: Sun, 26 Nov 2017 13:05:39 -0600
Message-ID: <20171126190539.ordmumh3vekfsqls@rob-hp-laptop>
References: <1511362947-14747-1-git-send-email-olivier.moysan@st.com>
 <1511362947-14747-2-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1511362947-14747-2-git-send-email-olivier.moysan-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olivier Moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 22, 2017 at 04:02:25PM +0100, Olivier Moysan wrote:
> SAI sync property must be described in SAI subnodes
> section, as it is a property of child node.
> This patch fixes commit 14f0e5f8d97e632695d92f41f2e91d10d8005d47
> "ASoC: stm32: Add synchronization to SAI bindings".
> 
> Signed-off-by: Olivier Moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
