From: rct@frus.com (Bob Tracy)
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Sat, 29 Mar 2008 23:24:13 -0500 (CDT)
Message-ID: <20080330042413.BB1A3DBA2@gherkin.frus.com>
References: <47E7EFDF.2070706@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id E050C24561
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Mar 2008 06:24:21 +0200 (CEST)
In-Reply-To: <47E7EFDF.2070706@keyaccess.nl> "from Rene Herman at Mar 24, 2008
	07:15:59 pm"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Bob Tracy <rct@frus.com>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> There's a patch attached that disables mmap on MIATA. You and Bob seem to be 
> experiencing problems of a different nature (or severity at the least) but 
> for both of you it would be good to hear what applying this and then playing 
> using "aplay -D hw foo.wav" (on the miata systems, ofcourse) brings.
> 
> (...)
> 
> The mmap thing is sort of the last hickup to be expected from me -- having 
> no Alpha machines and with trouble not isolated to a specific driver nor 
> Alpha model, this would at that point ideally want someone with some more 
> specific Alpha insights to step in.
> 
> (...)
> 
> diff --git a/include/sound/asound.h b/include/sound/asound.h
> index 3eaf155..e3b9c2d 100644
> --- a/include/sound/asound.h
> +++ b/include/sound/asound.h
> @@ -241,8 +241,14 @@ typedef int __bitwise snd_pcm_subformat_t;
>  #define	SNDRV_PCM_SUBFORMAT_STD		((__force snd_pcm_subformat_t) 0)
>  #define	SNDRV_PCM_SUBFORMAT_LAST	SNDRV_PCM_SUBFORMAT_STD
>  
> +#ifdef CONFIG_ALPHA_MIATA
> +#define SNDRV_PCM_INFO_MMAP		0		/* the useful comment goes here */
> +#define SNDRV_PCM_INFO_MMAP_VALID	0
> +#else
>  #define SNDRV_PCM_INFO_MMAP		0x00000001	/* hardware supports mmap */
>  #define SNDRV_PCM_INFO_MMAP_VALID	0x00000002	/* period data are valid during transfer */
> +#endif
> +
>  #define SNDRV_PCM_INFO_DOUBLE		0x00000004	/* Double buffering needed for PCM start/stop */
>  #define SNDRV_PCM_INFO_BATCH		0x00000010	/* double buffering */
>  #define SNDRV_PCM_INFO_INTERLEAVED	0x00000100	/* channels are interleaved */

Late this evening I starting building a kernel with the above patch
applied.  It should be ready for testing sometime tomorrow.  Sorry for
the delay.

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
