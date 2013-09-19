From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 06/11] ASoC: davinci: Add support for
 AM33xx SoC Audio
Date: Thu, 19 Sep 2013 12:31:25 +0300
Message-ID: <523AC46D.3060802@ti.com>
References: <cover.1379409268.git.jsarha@ti.com> <c59efc1524b19f50dc37606bfa246dde9c20d312.1379409268.git.jsarha@ti.com> <20130918144723.GU21013@sirena.org.uk> <20130918180946.GF21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130918180946.GF21013-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 09/18/2013 09:09 PM, Mark Brown wrote:
> On Wed, Sep 18, 2013 at 03:47:23PM +0100, Mark Brown wrote:
>> On Tue, Sep 17, 2013 at 12:26:05PM +0300, jsarha-l0cyMroinI0@public.gmane.org wrote:
>>> From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
>>>
>>> AM33xx uses same McASP IP as the Davinci Platform. This patch updates
>>> Kconfig and makefile to enable build for McASP, PCM & Codec drivers.
>>
>> Applied, thanks.
>
> Dropped since this breaks x86 builds due to dma_alloc_writecombine() not
> being defined (our DMA APIs really aren't wonderful...).
>

I added SOC_AM33XX-dependency to SND_AM33XX_SOC_EVM config and it 
appears to fix at least the "warning: (SND_AM33XX_SOC_EVM) selects 
..."-problem. I'll send an updated patch series (this time with 
maintainers in CC) shortly after/if my

% make ARCH=x86_64 allmodconfig && make -j 4

finishes without errors. Sorry for not testing that myself first time 
around.

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
