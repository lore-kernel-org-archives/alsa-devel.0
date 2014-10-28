From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 03/11] drivers: char: add AXD Audio Processing IP driver
Date: Tue, 28 Oct 2014 22:50:22 +0800
Message-ID: <20141028145022.GA19843@kroah.com>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
 <1414495589-8579-4-git-send-email-qais.yousef@imgtec.com>
 <20141028141038.GA18384@kroah.com>
 <544FA9F7.1020101@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <544FA9F7.1020101-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Qais Yousef <qais.yousef-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2014 at 02:36:39PM +0000, Qais Yousef wrote:
> On 10/28/2014 02:10 PM, Greg Kroah-Hartman wrote:
> >On Tue, Oct 28, 2014 at 11:26:21AM +0000, Qais Yousef wrote:
> >>AXD is Audio Processing IP by Imagination Technologies that can
> >>perform decoding, encoding, equalisation, resampling, mixing,
> >>synchronisation and audio playback.
> >Isn't that a codec?  Why is this a "char" driver and not one that fits
> >into our existing audio subsystem?
> 
> As far as I understand it doesn't fit into current alsa framework because of
> a number of unsupported features that we need. Specifically the range of
> compressed decoders we support and their configurations and encoding. I
> might have gotten it wrong though so I'll wait to see what alsa people say.

Then add the new features you need and everyone benefits.

Please work with the alsa developers on this, I will not accept anything
until they say there is no way this will work, and they bless a custom
one-off interface like this.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
