From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Mon, 12 Jul 2010 10:13:46 +0800
Message-ID: <AANLkTimRSM01hFeVu_iJ1WneVgghDHTSJou1KbnvwNjk@mail.gmail.com>
References: <4C22670D.8010104@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 33DC91037FB
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 04:13:50 +0200 (CEST)
Received: by vws9 with SMTP id 9so3777681vws.38
	for <alsa-devel@alsa-project.org>; Sun, 11 Jul 2010 19:13:48 -0700 (PDT)
In-Reply-To: <4C22670D.8010104@epost.diwic.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/24 David Henningsson <launchpad.web@epost.diwic.se>

> These two patches are being used in Ubuntu Lucid (released this April)
> and are working well enough to have people asking us to backport them to
> Karmic. Today I got an email, asking for the upstream status of one of
> these patches, since he wanted them in Fedora. If posting them here
> isn't the correct way to upstream them, please tell me so.
>
> The first one (Fix invalid buffer pointer return value) fixes broken logic:
>
> This patch improves recovering from underruns, and prevents hangs inside
> snd_pcm_write* and snd_pcm_read* due to snd_pcm_avail* returning too
> low values. It especially helps low latency situations.
>
> The second one (Do not report underruns to the ALSA layer) is more a
> change of behavior, which could be questioned. The arguments for
> removing that code are these:
>
>  * If pulseaudio gets an underrun, the normal way to end that underrun
> is to feed it with more buffers. This is different from the ALSA way of
> dealing with underruns, which requires hardware buffer pointers to be
> reset.
>  * In addition, underrun signals are delivered asynchronously from
> pulseaudio. This means that there might be more buffers on the way to
> pulseaudio when the underrun is reported, making the underrun obsolete.
> Unfortunately, there is currently no known way to determine whether this
> is the case or not.
>
> // David
>
> For your test case (mpg123 produces skippy output in 9.10
https://bugs.launchpad.net/ubuntu/+source/alsa-plugins/+bug/464008


play silence when there is underrun

http://www.mpg123.de/cgi-bin/viewvc.cgi/trunk/src/output/alsa.c?r1=377&r2=385


static void flush_alsa(audio_output_t *ao)
{
	snd_pcm_t *pcm=(snd_pcm_t*)ao->userptr;

	/* is this the optimal solution? - we should figure out what we
really whant from this function */

debug("alsa drop");
	snd_pcm_drop(pcm);
debug("alsa prepare");
	snd_pcm_prepare(pcm);
debug("alsa flush done");
}


it  implement pause by create an underrun


[libmpg123.c:1083] debug: tell: 2207/1 first 0 buffer 0; frame_outs=2542464
[libmpg123.c:623] debug: read of frame 2207 returned 1 (to_decode=1) at
sample 2541935
[libmpg123.c:904] debug: got next frame, 1
[libmpg123.c:885] debug: decoding
[term.c:158] debug: control for frame: 2207
[alsa.c:246] debug: alsa drop
[alsa.c:248] debug: alsa prepare
[alsa.c:250] debug: alsa flush done
Stopped
[alsa.c:246] debug: alsa drop
[alsa.c:248] debug: alsa prepare
[alsa.c:250] debug: alsa flush done
[mpg123.c:632] debug: play_frame
[libmpg123.c:620] debug: read frame
[parse.c:456] debug: trying to get frame 2208 at 923915
[parse.c:772] debug: Frame 2208 fffb9260 414, next filepos=924333
[index.c:85] debug: wanting to add to fill 552, step 4, size 1000
