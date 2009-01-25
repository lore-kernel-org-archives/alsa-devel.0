From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: gusclassic alsa configuration
Date: Sun, 25 Jan 2009 11:50:58 +0200
Message-ID: <20090125095058.GG4996@sci.fi>
References: <20090121223507.778f954d.krzysztof.h1@poczta.fm>
	<20090121215037.GC4996@sci.fi> <s5h8wp37glk.wl%tiwai@suse.de>
	<20090122173332.a5b8f459.krzysztof.h1@poczta.fm>
	<s5h8wp35mg9.wl%tiwai@suse.de>
	<20090122231105.3ff437c2.krzysztof.h1@poczta.fm>
	<s5h1vuujze5.wl%tiwai@suse.de>
	<20090123130922.83218e8e.krzysztof.h1@poczta.fm>
	<s5h7i4m87fu.wl%tiwai@suse.de>
	<20090125091923.432dfbd5.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.welho.com (smtp5.welho.com [213.243.153.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AB4C1037ED
	for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2009 10:51:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090125091923.432dfbd5.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 25, 2009 at 09:19:23AM +0100, Krzysztof Helt wrote:
> @@ -58,9 +60,14 @@ GUS.pcm.front.0 {
>  			name defaults.pcm.subdevice
>  		}
>  	}		=

> -	type hw
> -	card $CARD
> -	device $DEV
> -	subdevice $SUBDEV
> -	mmap_emulation on
> +	type plug
> +	slave.pcm {
> +		type mmap_emul
> +		slave.pcm {
> +			type hw
> +			card $CARD
> +			device $DEV
> +			subdevice $SUBDEV
> +		}
> +	}
>  }

BTW are these settings also applied to the cs4231/es1688 pcm device on
gus max, gus exterme and interwave cards?

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
