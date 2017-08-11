From: jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: ASoC: rockchip: Add rockchip,codec-names
 property
Date: Fri, 11 Aug 2017 09:30:21 +0800
Message-ID: <598D08AD.8090609@rock-chips.com>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com> <1502340898-28403-4-git-send-email-jeffy.chen@rock-chips.com> <20170810145607.g663oq7cfxjmaxtf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170810145607.g663oq7cfxjmaxtf-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 08/10/2017 10:56 PM, Mark Brown wrote:
> On Thu, Aug 10, 2017 at 12:54:58PM +0800, Jeffy Chen wrote:
>> Add a new rockchip,codec-names property, so that the driver can parse
>> the codecs by name.
>
> Why?  You're already referencing the CODECs by phandle and these names
> are not part of any ABI...
>

currently we are binding the phandles to a fixed codec list in the 
driver. but we want to make it dynamic, since some exist codecs could be 
optional, and some new codecs could be add for new board too.

and the support of this new property in the driver is added in 
https://patchwork.kernel.org/patch/9892737

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
