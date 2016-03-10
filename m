From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH V3] ASoC: pcm179x: Add support for pcm1795 and pcm1796
Date: Thu, 10 Mar 2016 10:59:42 +0100
Message-ID: <CAOf5uwnJ6PpeFunDuEUPhQ-5ArOB6y3Xw8E3gxUA0GiLREkY+g@mail.gmail.com>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
	<1452382685-18009-4-git-send-email-michael@amarulasolutions.com>
	<20160110120045.GW6588@sirena.org.uk>
	<20160110173812.GA16304@panicking>
	<20160205172451.GA30542@panicking>
	<20160222031944.GT18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160222031944.GT18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Jacob Siverskog <jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark

On Mon, Feb 22, 2016 at 4:19 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Feb 05, 2016 at 06:24:57PM +0100, Michael Trimarchi wrote:
>
>> +#define PCM1795      1
>> +     unsigned int codec_model;
>
> It looks like you're trying to define an enum here.
>
>> +static const unsigned int codec_model = PCM1795;
>

Ok

> That's a weird name to use here.  Call it pcm1795 or something, though
> normally we just cast the integer to and from a pointer.
>
>> +     { .compatible = "ti,pcm1795",
>> +       .data = &codec_model,
>> +     },
>
> This is strange indentation, just keep it on one line and it's easier to
> follow.

Ok

Michael

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
