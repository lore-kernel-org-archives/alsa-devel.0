From: =?iso-8859-1?q?Carlos=20Pita?= <cpitaar@yahoo.com.ar>
Subject: Re: hw/plughw strange behaviour
Date: Thu, 10 Jun 2004 14:16:35 -0300 (ART)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040610171635.95104.qmail@web50406.mail.yahoo.com>
References: <Pine.HPX.4.33n.0406101857110.3148-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0406101857110.3148-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> >    snd_pcm_hw_params_set_access(handle, hwparams,
> SND_PCM_ACCESS_RW_INTERLEAVED);
> >    snd_pcm_hw_params_set_format(handle, hwparams,
> SND_PCM_FORMAT_S16_LE);
> >    snd_pcm_hw_params_set_rate_near(handle,
> hwparams, &rate, &dir);
> >    snd_pcm_hw_params_set_channels(handle,
> hwparams, numchannels);
> >    snd_pcm_hw_params_set_periods(handle, hwparams,
> numperiods, 0);
> >    snd_pcm_hw_params_set_buffer_size_near(handle,
> hwparams, &buffersize);
> 
> Does any of these calls return an error?
> 

No, I have stripped out error checking code for
brevity purposes; but none of the
snd_pc_hw_params_set_XXX invokations return an error,
just snd_pc_hw_params do it, as I described in my
previous post.

Regards,
Carlos

------------
Los mejores usados y las más tentadoras 
ofertas de 0km están en Yahoo! Autos.
Comprá o vendé tu auto en
http://autos.yahoo.com.ar


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
