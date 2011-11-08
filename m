From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add SoundCard driver for OKI SEMICONDUCTOR
	ML7213 IOH
Date: Tue, 8 Nov 2011 14:38:18 +0000
Message-ID: <20111108143818.GA5632@opensource.wolfsonmicro.com>
References: <70D251FDDC55405882A8447CC455D56E@hacdom.okisemi.com>
	<8486F61FC3B94B908BFE654234DD6C97@hacdom.okisemi.com>
	<4E9BAEF7.1080406@dsn.lapis-semi.com>
	<s5h7h3ysa4l.wl%tiwai@suse.de> <4EA5563A.10703@dsn.lapis-semi.com>
	<20111024122015.GA26033@opensource.wolfsonmicro.com>
	<4EB8F079.9080703@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 549D61038E0
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 15:38:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EB8F079.9080703@dsn.lapis-semi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Cc: alsa-devel@alsa-project.org, "Wang, Qi" <qi.wang@intel.com>, Takashi Iwai <tiwai@suse.de>, "Wang,
	Yong Y" <yong.y.wang@intel.com>, linux-kernel@vger.kernel.org, "Ewe, Kok Howg" <kok.howg.ewe@intel.com>, Liam Girdwood <lrg@ti.com>, "Clark, Joel" <joel.clark@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 08, 2011 at 06:03:53PM +0900, Tomoya MORINAGA wrote:

So, I started looking at this but...

> struct snd_ml7213i2s_pcm {
> 	enum snd_soc_control_type control_type;
> 	struct snd_ml7213i2s *ml7213i2s;
> 	spinlock_t lock;
> 	unsigned int irq_pos;
> 	unsigned int buf_pos;
> 	struct snd_pcm_substream *substream;
> 	struct cbdata cbd;              /* i2s callback info */
> 	unsigned int channels;
> 	unsigned int rw;
> 	unsigned int rate;
> 	unsigned int ch;
> 	unsigned int setup_flag;
> 	unsigned int format;
> 	unsigned int bclkfs;
> 	struct mutex i2c_mutex;
> };

...this looks *really* confused, there's things in here which are a mix
of DMA controller and CODEC driver things.  The CODEC and DMA drivers
shouldn't know anything about each other, let alone be referencing the
same data structure.

> /*
>  * wm8731 register cache
>  * We can't read the WM8731 register space when we are
>  * using 2 wire for device control, so we cache them instead.
>  * There is no point in caching the reset register
>  */
> static const u16 wm8731_reg[WM8731_CACHEREGNUM] = {
> 	0x0097, 0x0097, 0x0079, 0x0079,
> 	0x000a, 0x0008, 0x009f, 0x000a,
> 	0x0000, 0x0000
> };

This is is just obviously wrong for this driver.  I stopped reading the
code at this point.
