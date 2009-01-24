From: Cristian Morales Vega <cmorve69@yahoo.es>
Subject: Re: snd_pcm_set_params() bug?
Date: Sat, 24 Jan 2009 11:53:14 +0100
Message-ID: <8235e6f40901240253h17774341s9dd21d6c0b7b9ac0@mail.gmail.com>
References: <8235e6f40806020930t42e9b62brff93c5e23b59eac5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 0511A2436E
	for <alsa-devel@alsa-project.org>; Sat, 24 Jan 2009 11:53:15 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so4951267rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 24 Jan 2009 02:53:14 -0800 (PST)
In-Reply-To: <8235e6f40806020930t42e9b62brff93c5e23b59eac5@mail.gmail.com>
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

2008/6/2 Christian Morales Vega <cmorve69@yahoo.es>:
> This code:
>
> #include <alsa/asoundlib.h>
>
> int main(){
>    snd_pcm_t *handle;
>    if(snd_pcm_open(&handle, "default:1", SND_PCM_STREAM_PLAYBACK, 0) < 0) {
>      exit(1);
>    }
>
>    if(snd_pcm_set_params(handle, SND_PCM_FORMAT_S16_LE,
> SND_PCM_ACCESS_RW_INTERLEAVED,
>       2, 24000, 1, 100000) < 0) {
>      exit(2);
>    }
> }
>
> fails with error "ALSA lib pcm.c:7193:(snd_pcm_set_params) Unable to
> get period size for PLAYBACK: Invalid argument"
> Disable resampling and you get "ALSA lib
> pcm.c:7142:(snd_pcm_set_params) Rate doesn't match (requested 24000Hz,
> get 0Hz)" (normal, I suppose). With other samplerates works fine.
>
> I'm using alsa-driver-kmp-default-1.0.16.20080602 and
> alsa-1.0.16.hg20080510 RPM packages from multimedia:audio openSUSE
> Build Service repository (from Takashi Iwai) and an AD1988 (hda-intel)
> codec. A XUbuntu user also has the same problem with an hda-intel
> codec (that I suppose uses stable 1.0.16).
> With a SB Live! in the same computer there are no problems.
>
>
> This was discovered with bsnes ( http://byuu.cinnamonpirate.com/bsnes/
> - http://board.zsnes.com/phpBB2/viewtopic.php?t=11584 ) that can use
> openal, libao or alsa directly. The problem just happens when using
> 24KHz with alsa. So I suppose the problem is in the
> snd_pcm_set_params() itself, since openal and libao have not the
> problem but they set parameters "manually", not with
> snd_pcm_set_params().
>

The problem persists with alsa-1.0.19.git20090122-1.1 and
alsa-driver-kmp-default-1.0.19.20090124_2.6.27.7_9.1-1.1 from openSUSE
11.1 multimedia:audio(:kmp) Build Service repository.

Note that the problem only happens with snd_pcm_set_params(). Using
snd_pcm_hw_params_set_* functions works fine (and I really get 24KHz):
http://board.zsnes.com/phpBB2/viewtopic.php?p=170478#170478

The problem happens with default, plughw and hw.
