From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 05/11] ASoC: davinci-mcasp: Remove interrupt
 property from DT bindings doc
Date: Wed, 18 Sep 2013 09:48:34 -0500
Message-ID: <5239BD42.2060903@ti.com>
References: <cover.1379409268.git.jsarha@ti.com> <1b47734e397bfac8846dcfc194fd1ab63f320d1a.1379409268.git.jsarha@ti.com> <20130918144635.GT21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130918144635.GT21013-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: jsarha-l0cyMroinI0@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 09/18/2013 09:46 AM, Mark Brown wrote:
> On Tue, Sep 17, 2013 at 12:26:04PM +0300, jsarha-l0cyMroinI0@public.gmane.org wrote:
>> From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
>>
>> Davinci McASP driver does use interrupts for anything ATM.
> 
> How about moving these to optional instead of removing them completely
> (or just leaving them alone)?  That way if the driver does want to start
> using them people will have hooked them up already so no updates will be
> required.
> 
the definitions as they stand now make no sense as the ordering of the
interrupts are undefined - example is the first index RX or TX? the
alternative will be PIO McASP driver, which might be nice, but having
a vague binding with 0 code behind is of no use for anyone right?

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
