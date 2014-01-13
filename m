From: Florian Meier <florian.meier@koalo.de>
Subject: Re: [PATCH] ASoC: wm8804: Allow control of master clock divider in
 PLL generation
Date: Mon, 13 Jan 2014 10:21:47 +0100
Message-ID: <52D3B02B.8070408@koalo.de>
References: <alpine.DEB.2.02.1401122206520.7929@parallels-Parallels-Virtual-Platform>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1401122206520.7929@parallels-Parallels-Virtual-Platform>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Matuschek <daniel@matuschek.net>, alsa-devel@alsa-project.org
Cc: Dimitris.Papastamos@wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, info@crazy-audio.com
List-Id: alsa-devel@alsa-project.org

On 01/12/2014 10:11 PM, Daniel Matuschek wrote:
> Signed-off-by: Daniel Matuschek <daniel@matuschek.net>
> 
> After some discussions of the patch last week, here is a new version.
> Simply reducing the post_table did not work, as for some frequencies
> both settings (MCLKDIV=0 and MCLKDIV=1) are needed (e.g. 96 and 192kHz)
> 
> 
>  WM8804 can run with PLL frequencies of 256xfs and 128xfs for
>  most sample rates. At 192kHz only 128xfs is supported. The
>  existing driver selects 128xfs automatically for some lower
>  samples rates. By using an additional mclk_div divider, is
>  is now possible to control the behaviour. This allows using
>  256xfs PLL frequency on all sample rates up to 96kHz. It
>  should allow lower jitter and better signal quality. The
>  behavior has to be controlled by the sound card driver,
>  because some sample frequency share the same setting. e.g.
>  192kHz and 96kHz use 24.576MHz master clock. The only
>  difference is the MCLK divider.
> 
> ---
>  sound/soc/codecs/wm8804.c |   17 ++++++++++++++---
>  sound/soc/codecs/wm8804.h |    4 ++++
>  2 files changed, 18 insertions(+), 3 deletions(-)

You have disarranged the parts, again. It should be

WM8804 can run with PLL frequencies of 256xfs and 128xfs for
most sample rates. At 192kHz only 128xfs is supported. The
existing driver selects 128xfs automatically for some lower
samples rates. By using an additional mclk_div divider, is
is now possible to control the behaviour. This allows using
256xfs PLL frequency on all sample rates up to 96kHz. It
should allow lower jitter and better signal quality. The
behavior has to be controlled by the sound card driver,
because some sample frequency share the same setting. e.g.
192kHz and 96kHz use 24.576MHz master clock. The only
difference is the MCLK divider.

Signed-off-by: Daniel Matuschek <daniel@matuschek.net>

---

After some discussions of the patch last week, here is a new version.
Simply reducing the post_table did not work, as for some frequencies
both settings (MCLKDIV=0 and MCLKDIV=1) are needed (e.g. 96 and 192kHz)

 sound/soc/codecs/wm8804.c |   17 ++++++++++++++---
 sound/soc/codecs/wm8804.h |    4 ++++
 2 files changed, 18 insertions(+), 3 deletions(-)
