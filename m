From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Thu, 24 Jun 2010 07:44:26 +0800
Message-ID: <AANLkTikRPPlq_3_m37I6wctz4-5OPdnIqNU8v6wcx5bB@mail.gmail.com>
References: <4C22670D.8010104@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 19DFE2444A
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 01:44:28 +0200 (CEST)
Received: by vws20 with SMTP id 20so1572867vws.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 16:44:26 -0700 (PDT)
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
>
>
Are there any test program which can reproduce this condition ?

any program similar to alsa-time-test.c which PA developer use to test the
alsa-driver but alsa-time-test.c aborted when I specify to use the pulse
device
