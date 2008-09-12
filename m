From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH] Fix oopses in snd-hda-intel from alsa
	v1.0.18rc3
Date: Fri, 12 Sep 2008 03:04:39 -0300
Message-ID: <200809120304.39660.herton@mandriva.com.br>
References: <200809120243.02486.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 4478224435
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Sep 2008 08:04:41 +0200 (CEST)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 3428E3EA8
	for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2008 02:04:59 -0400 (EDT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id kA8IE9IjA5ht for <alsa-devel@alsa-project.org>;
	Fri, 12 Sep 2008 02:04:58 -0400 (EDT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id AF4C83EA7
	for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2008 02:04:58 -0400 (EDT)
Received: from [172.21.225.6] (unknown [172.21.225.6])
	by fox.conectiva (Postfix) with ESMTP id 372B72F2BD
	for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2008 03:04:40 -0300 (BRT)
In-Reply-To: <200809120243.02486.herton@mandriva.com.br>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 12 September 2008 02:43:02 Herton Ronaldo Krzesinski wrote:
> Fixes the following oopses and other likewise possible ones:
> 

Ouch, just pasted the oopses for reference and forgot a real changelog, it can
be like this:

---

ALSA: hda: fix oopses in snd-hda-intel after digital slave support additions

Many places fail to check if codec has slave_dig_outs entries (the most common
case is not having any entry), leading to various possible oopses in hda_codec
code.

> 
> Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> 
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index 696d77e..531364d 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -1462,14 +1462,15 @@ static int snd_hda_spdif_default_put(struct snd_kcontrol *kcontrol,
>  					  AC_VERB_SET_DIGI_CONVERT_2,
>  					  val >> 8);
>  
> -		for (d = codec->slave_dig_outs; *d; d++) {
> -			snd_hda_codec_write_cache(codec, *d, 0,
> +		if (codec->slave_dig_outs)
> +			for (d = codec->slave_dig_outs; *d; d++) {
> +				snd_hda_codec_write_cache(codec, *d, 0,
>  					  AC_VERB_SET_DIGI_CONVERT_1,
>  					  val & 0xff);
> -			snd_hda_codec_write_cache(codec, *d, 0,
> +				snd_hda_codec_write_cache(codec, *d, 0,
>  					  AC_VERB_SET_DIGI_CONVERT_2,
>  					  val >> 8);
> -		}
> +			}
>  	}
>  
>  	mutex_unlock(&codec->spdif_mutex);
> @@ -1507,8 +1508,9 @@ static int snd_hda_spdif_out_switch_put(struct snd_kcontrol *kcontrol,
>  					  AC_VERB_SET_DIGI_CONVERT_1,
>  					  val & 0xff);
>  
> -		for (d = codec->slave_dig_outs; *d; d++)
> -			snd_hda_codec_write_cache(codec, *d, 0,
> +		if (codec->slave_dig_outs)
> +			for (d = codec->slave_dig_outs; *d; d++)
> +				snd_hda_codec_write_cache(codec, *d, 0,
>  					  AC_VERB_SET_DIGI_CONVERT_1,
>  					  val & 0xff);
>  		/* unmute amp switch (if any) */
> @@ -1664,8 +1666,9 @@ static int snd_hda_spdif_in_switch_put(struct snd_kcontrol *kcontrol,
>  		snd_hda_codec_write_cache(codec, nid, 0,
>  					  AC_VERB_SET_DIGI_CONVERT_1, val);
>  
> -		for (d = codec->slave_dig_outs; *d; d++)
> -			snd_hda_codec_write_cache(codec, *d, 0,
> +		if (codec->slave_dig_outs)
> +			for (d = codec->slave_dig_outs; *d; d++)
> +				snd_hda_codec_write_cache(codec, *d, 0,
>  					  AC_VERB_SET_DIGI_CONVERT_1, val);
>  	}
>  	mutex_unlock(&codec->spdif_mutex);
> @@ -2617,9 +2620,10 @@ static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
>  		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
>  			    codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
>  
> -		for (d = codec->slave_dig_outs; *d; d++)
> -			snd_hda_codec_write(codec, *d, 0,
> -					AC_VERB_SET_DIGI_CONVERT_1,
> +		if (codec->slave_dig_outs)
> +			for (d = codec->slave_dig_outs; *d; d++)
> +				snd_hda_codec_write(codec, *d, 0,
> +				    AC_VERB_SET_DIGI_CONVERT_1,
>  				    codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
>  	}
>  	snd_hda_codec_setup_stream(codec, nid, stream_tag, 0, format);
> @@ -2628,9 +2632,10 @@ static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
>  		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
>  				    codec->spdif_ctls & 0xff);
>  
> -		for (d = codec->slave_dig_outs; *d; d++)
> -			snd_hda_codec_write(codec, *d, 0,
> -					AC_VERB_SET_DIGI_CONVERT_1,
> +		if (codec->slave_dig_outs)
> +			for (d = codec->slave_dig_outs; *d; d++)
> +				snd_hda_codec_write(codec, *d, 0,
> +				    AC_VERB_SET_DIGI_CONVERT_1,
>  				    codec->spdif_ctls & 0xff);
>  	}
>  
> 
> 



-- 
[]'s
Herton
