From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: Setting format to SND_PCM_FORMAT_MU_LAW does not
 let	me apply hardware parameters
Date: Tue, 01 Jul 2008 19:20:27 -0700
Message-ID: <486AE5EB.1010908@cox.net>
References: <3B6F5C9068D5864096EB291236C3386F02CE1633@xmb-sjc-21d.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao101.cox.net (fed1rmmtao101.cox.net [68.230.241.45])
	by alsa0.perex.cz (Postfix) with ESMTP id CC687244FC
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 04:20:29 +0200 (CEST)
In-Reply-To: <3B6F5C9068D5864096EB291236C3386F02CE1633@xmb-sjc-21d.amer.cisco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mitul Sen (misen)" <misen@cisco.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mitul Sen (misen) wrote:
> Hi Stan,
>
> Thanks for all your help! I have some more questions though...
>
> I downloaded the source code for alsa-lib-1.0.15 =

> Based on the code, if the format is SND_PCM_FORMAT_MU_LAW, I am not sure
> why it does a get/put index to SND_PCM_FORMAT_S16 Also, if the stream is
> SND_PCM_STREAM_PLAYBACK, then I would think that it should decode the
> data. Why does it call snd_pcm_mulaw_decode function if the format is
> SND_PCM_FORMAT_MU_LAW and snd_pcm_mulaw_encode otherwise. I have an
> Intel HDA soundcard and according to the specs, it should support PCM
> ulaw format.
>
> All ALSA documentation and examples I have come across use specific
> hw_params (like sample rate of 44100, SND_PCM_FORMAT_S16, 2 channel
> interleaved data). According to the documents, hw_params refer to the
> stream related info so that's the reason I tried to change it to that of
> mu-law (sampling rate of 8000 Hz, SND_PCM_FORMAT_MU_LAW etc). Not sure
> if that's the way to do it though. Based on the code it looks like the
> hardware just seems to support SND_PCM_FORMAT_S16. Any pointers to help
> me better understand the ALSA code would be much appreciated.
>
>   =


Hi Misen,

First, a gentle remonstrance.  You probably have noticed that I always =

put my responses after or mixed with your message.  On public mailing =

lists this is considered good form, rather than posting your response at =

the top of the message.  Why?  So that anyone who steps into the =

interaction doesn't have to read the messages out of order and that =

future searchers have an easier time understanding the message.  While =

top posting is the norm in communications between two or a few people =

because the context is familiar to all and it saves time not to have to =

look for the response, on a public mailing list that isn't necessarily true.

Now to the matter at hand.
I had never heard of mu law so I looked it up.  =

http://www.digitalpreservation.gov/formats/fdd/fdd000039.shtml
...
Standard companding algorithm used in digital communications systems in =

North America and Japan (telephones, for the most part) to optimize the =

dynamic range of an analog signal (generally a voice) for digitizing, =

i.e., to compress 16 bit LPCM =

<http://www.digitalpreservation.gov/formats/fdd/fdd000011.shtml> (Linear =

Pulse Code Modulated) data down to 8 bits of logarithmic data. See also =

Notes =

<http://www.digitalpreservation.gov/formats/fdd/fdd000039.shtml#notes> =

below. =B5-Law is similar to the A-Law =

<http://www.digitalpreservation.gov/formats/fdd/fdd000038.shtml> =

algorithm used in Europe.
...

The code that you extracted below is designed to convert mu law from the =

compressed form back into the 16 bit signed form.  I haven't checked the =

rest of the code myself, but it appears to assume that the sound device =

is incapable of internal conversion.  If that is true, you shouldn't =

have to specify anything else to the library except mu law.  It should =

take care of everything else. i.e.  as soon as you specify mu law, it is =

known that the stream is 8 bit mono that has to be uncompressed to 16 =

bit mono.   I presume that is why there is the error when you try to set =

the hardware parms with mu law.  The library should probably be modified =

to use this new capability of sound device internal conversion for mu =

law if it is available on the sound device.  Maybe it already does;  as =

I said I haven't looked at the code, and I'm not really familiar with mu =

law.

So, given my ignorance, my explanation and proposed solution might be =

completely wrong.  :-)  Perhaps a developer familiar with the coding of =

mu law will give a better explanation.

At this point, I really don't have more to offer for your problem.  I =

would have to look at the code to decipher it in order to give an =

answer.  You might as well do that yourself, as you will get a better =

understanding than I could give with an explanation.
> The code that I am referring to is in pcm_mulaw.c and is as follows:-
>
> static int snd_pcm_mulaw_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *
> params)
> {
>         snd_pcm_mulaw_t *mulaw =3D pcm->private_data;
>         snd_pcm_format_t format;
>         int err =3D snd_pcm_hw_params_slave(pcm, params,
>  =

> snd_pcm_mulaw_hw_refine_cchange,
>  =

> snd_pcm_mulaw_hw_refine_sprepare,
>  =

> snd_pcm_mulaw_hw_refine_schange,
>                                           snd_pcm_generic_hw_params);
>         if (err < 0)
>                 return err;
>
>         err =3D INTERNAL(snd_pcm_hw_params_get_format)(params, &format);
>         if (err < 0)
>                 return err;
>
>         if (pcm->stream =3D=3D SND_PCM_STREAM_PLAYBACK) {
>                 if (mulaw->sformat =3D=3D SND_PCM_FORMAT_MU_LAW) {
>                         mulaw->getput_idx =3D
> snd_pcm_linear_get_index(format, SND_PCM_FORMAT_S16);
>                         mulaw->func =3D snd_pcm_mulaw_encode;
>                 } else {
>                         mulaw->getput_idx =3D
> snd_pcm_linear_put_index(SND_PCM_FORMAT_S16, mulaw->sformat);
>                         mulaw->func =3D snd_pcm_mulaw_decode;
>                 }
>         } else {
>                 if (mulaw->sformat =3D=3D SND_PCM_FORMAT_MU_LAW) {
>                         mulaw->getput_idx =3D
> snd_pcm_linear_put_index(SND_PCM_FORMAT_S16, format);
>                         mulaw->func =3D snd_pcm_mulaw_decode;
>                 } else {
>                         mulaw->getput_idx =3D
> snd_pcm_linear_get_index(mulaw->sformat, SND_PCM_FORMAT_S16);
>                         mulaw->func =3D snd_pcm_mulaw_encode;
>                 }
>         }
>         return 0;
> }  =

>
> Thanks and regards,
> Mitul
>
> -----Or
