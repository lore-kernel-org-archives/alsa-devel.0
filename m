From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Add WM8510 driver
Date: Wed, 4 Jun 2008 20:24:56 +0100
Message-ID: <20080604192455.GA10244@opensource.wolfsonmicro.com>
References: <1212597211-14495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hiqwp401i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 282AF24494
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 21:24:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hiqwp401i.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Brett Saunders <breton.saunders@ntlworld.com>, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 04, 2008 at 06:50:17PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > +static const u16 wm8510_reg[WM8510_CACHEREGNUM] = {
> > +    0x0000, 0x0000, 0x0000, 0x0000,

> Use tabs here.

> > +static const char *wm8510_companding[] = {"Off", "NC", "u-law", "A-law" };
> > +static const char *wm8510_deemp[] = {"None", "32kHz", "44.1kHz", "48kHz" };
> > +static const char *wm8510_alc[] = {"ALC", "Limiter" };

> No space after '{' but a space before '}'?  Oh I'm too picky...

Please fix checkpatch for stuff like this :)

> > +	case SNDRV_PCM_RATE_44100:
> > +		break;

> Just to be sure -- No 48000 case?

> > +#define WM8510_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> > +		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> > +		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
> 
> ... since I find it here.

Yes (well, it's the same as the 41000 case - nothing to set).  I'll add
an empty case for clarity.

> > +#define WM8510_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
> > +	SNDRV_PCM_FMTBIT_S24_LE)

> Don't you need SNDRV_PCM_FMTBIT_S32_LE?  It's handled in
> wm8510_pcm_hw_params().

Should do, yes.

> Also, is the patch author you or Liam?

We've both worked on the driver; Liam did the original driver and I've
done some fairly invasive changes to it since then, particularly to the
input paths.  The Author: is showing as me since that's what git did
when I pulled the driver over into mainline for submission.
