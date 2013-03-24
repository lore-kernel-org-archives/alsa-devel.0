From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [Vorbis-dev] libao problem (Re: No dmix/dsnoop on
	Intel ICH4/5 by default?)
Date: Sun, 24 Mar 2013 21:28:36 +0000
Message-ID: <201303242128.36843.gineera@aspect135.co.uk>
References: <50F6FF00.7020706@gmail.com>
 <CACrD=+_whofChWJU+hVR3opb_baHvTjqmLzWrbQAqu9r08GCPQ@mail.gmail.com>
 <514F4B0C.8020309@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip05ir2.opaltelecom.net (out1.ip05ir2.opaltelecom.net
 [62.24.128.241])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FEE02615AE
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 22:32:03 +0100 (CET)
In-Reply-To: <514F4B0C.8020309@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sunday 24 March 2013 18:50, Clemens Ladisch wrote:
> xiphmont@xiph.org wrote:
> >> The only thing I personally had an actual issue with is using "front"
> >> for stereo rather than "default". I don't seem able to come up with a
> >> compelling reason why it should be "front" myself, so one tweak could
> >> perhaps be to only change the stereo device back to "default"?
> >
> > Because then you can't guarantee or even discover what the playback
> > rate and bitdepth are. There's no way to ensure bit-exact playback in
> > a plug device, where 'front' is usually a non-plug alias.
>
> The SND_PCM_NO_AUTO_* flags are there for exactly this reason:
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#ga64fa40b5
>56374dabe40d4874242fee19

Where would those flags be used, and how is that different from calling

    snd_pcm_hw_params_set_rate_resample()

(with '0' to disable) on the pcm/configuration space?

Thanks

Alan
