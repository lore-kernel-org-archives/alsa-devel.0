From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Distorted jackd output on Macbooks
Date: Sat, 12 May 2012 00:27:34 +0200
Message-ID: <20120511222734.GV6396@ltw.loris.tv>
References: <4F9AEFEC.4070509@drcomp.erfurt.thur.de>
	<s5hk40nndgz.wl%tiwai@suse.de> <20120508144530.GZ6396@ltw.loris.tv>
	<s5h4nrq1zq0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
	by alsa0.perex.cz (Postfix) with ESMTP id 320311047BC
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2012 00:27:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4nrq1zq0.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 08, 2012 at 05:04:07PM +0200, Takashi Iwai wrote:

> > I've installed Linux on my spare MacBookPro and can report that JACKD is
> > not to blame. aplay and jackd behave the same:
> > 
> >    FLOAT_LE is distorted
> >    S32LE is fine
> > 
> > 
> > So only FLOAT_LE is broken, S32LE and S24_3LE are fine.
> 
> OK, that's good to know.  I didn't know that the codec supports the
> float.
> 
> I guess we can disable the support code for now like the patch below.
> 
> Could you check whether it works for you?
> 
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index 882bb3a..48c50dd 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -3781,11 +3781,13 @@ int snd_hda_query_supported_pcm(struct hda_codec *codec, hda_nid_t nid,
>  					bps = 20;
>  			}
>  		}
> +#if 0 /* FIXME: CS4206 doesn't work, which is the only codec supporting float */
>  		if (streams & AC_SUPFMT_FLOAT32) {
>  			formats |= SNDRV_PCM_FMTBIT_FLOAT_LE;
>  			if (!bps)
>  				bps = 32;
>  		}
> +#endif
>  		if (streams == AC_SUPFMT_AC3) {
>  			/* should be exclusive */
>  			/* temporary hack: we have still no proper support


Yep, this does the trick. Works.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
