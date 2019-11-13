Return-Path: <SRS0=Rgv7=ZF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B022C432C3
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:22:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346E2206DA
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G0A7+UOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346E2206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7426167A;
	Wed, 13 Nov 2019 18:21:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7426167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573665769;
	bh=qcDDW5VhXLZlAaixbTDh6hzzIrgi7gzA6Mj5eOuuSJQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G0A7+UOfMvd8BaHxWte6R8EQJ5w1Ui9YQ5RN2xUj9qa/VGnn9jdkm6iFOx31wUj3y
	 g4tOfPodBYPe9eSjzPlAWtmSfM3vo7o10ZwDFg3s4PEUs3+wwfrHt5aC/CUpvBZF5c
	 Evl5GwFGgLygOw6TMTTq+kYQLv0R0RZIBLLMUtvY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B7D3F80084;
	Wed, 13 Nov 2019 18:20:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6EAFF80087; Wed, 13 Nov 2019 18:20:23 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD758F8007E
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2019 18:20:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD758F8007E
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MwQGj-1hdWmJ12yz-00sMbT for <alsa-devel@alsa-project.org>; Wed, 13 Nov
 2019 18:20:14 +0100
Received: by mail-qt1-f175.google.com with SMTP id j5so1971297qtn.10
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2019 09:20:13 -0800 (PST)
X-Gm-Message-State: APjAAAV3ubYrEO7FYGmskdnQ94AaXzSe2Gvo66JtVXaXn9PDkwmNQoXe
 xGWsU2UhKuzpkhR+hTrWslLUAz71m52zvL4w88Q=
X-Google-Smtp-Source: APXvYqwmpR2V1doWZnyYpxhN/Fh6aq/URcW9mkmoia5+D3Pk9FBLnqjBXoeZEyZfu7PZXes37gnz66fvK1fgXnT2CO0=
X-Received: by 2002:ac8:2e57:: with SMTP id s23mr3777653qta.204.1573665612998; 
 Wed, 13 Nov 2019 09:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de>
 <s5hk1847rvm.wl-tiwai@suse.de>
 <CAK8P3a2TMEUhzxH7RKvAW9STk33KrbCriUaQawOMffoFC6UTQw@mail.gmail.com>
 <s5hzhgzn304.wl-tiwai@suse.de>
 <CAK8P3a3n9hrb-qfAYW9=eYApSX=pkOK5p6iGe0T29-KqGuh0tg@mail.gmail.com>
 <s5hy2wjn1w2.wl-tiwai@suse.de>
In-Reply-To: <s5hy2wjn1w2.wl-tiwai@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Nov 2019 18:19:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2+DgOBXS9MmPfvyyCUmqMB-pOx-qLjTV-VjDgStP6tww@mail.gmail.com>
Message-ID: <CAK8P3a2+DgOBXS9MmPfvyyCUmqMB-pOx-qLjTV-VjDgStP6tww@mail.gmail.com>
To: Takashi Iwai <tiwai@suse.de>
X-Provags-ID: V03:K1:cIJyijWPrzvaMzeZM3hf8yGus64M8NuCoLmCmiIdudjKxiHGIHl
 NopKqvVaJ8J2tpP+Um8e+06kbHioFXnwFPTd2uwFbvRwbDAjHtHdavmo5f/2nL4q1qBga9X
 l41apZhA/Mw8FgVGZPin7wvY/BxR5l5OVONSEhyB3mow6P6qx+CmSRJT/kJFcmHEG0k/Eg8
 MUkAvuOWylkXVGrFf9YAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IX7AfFUN8RA=:2ptXBX3gCl+yfbOc2kVZRb
 jlbpStG0pVOR9KITFXNVu/ivVYWkRV2Xc0FP2rigx8Y0NYzWxvwSC56p7b1CzhrFOtM5s7xu5
 RRAXA0PTj0fSYiz7ZjPsjx2cAeVj0y8oq1fyFnE3sosEomZ6H5ZkPeOufHbuTDkGhN6o1aLJN
 LpS1fq0SJ7VJFgJUoU3uOJKVWaaIOHvSPWYfreszM02BSrkqgCHbsyZbVqGpOYsrrW6ojFge2
 KQef92ZxWt7S1A5hGv/AJ4dgB94RHQU0YA78rexzzir0mCoAQcd9Qyu89usGvXf73TmfbXblG
 6JEfezi9VjBkg0MiMkljQodmxv1vWH0khR9HGBMgSnjgGnvzgucrPVbm/cLOS+Y6bAfDTzO5R
 wjY2zLjUnCPUVkJwPV3lyMYd2wb8Y3mL8V9+KgNox/RDb8D7Bw9vedCNUiW0Ip8cBINRtOeRk
 byadKj1rl/VVTNC7e0DDPSvSJVMaQZOEGkW8S8cVy7nhiC2j2Jzvw5Jd13V6WcfGIjw4Oc70/
 lL+RpjtIEIy8a/1WE4NvnlLFlRbbyvnIM3stp0xwLEkCTacP1MvIzwnEWNOOpv1p3arMNs9e2
 viScpxwJR5oOCbdG8Mv2xR2juhSd8cwgPxF5NYnwhcEoEylYDSLmrORmO/k/P6FfC78vYLfho
 ATIQFvIIWkakFKFiyTLx7nXIkxqv3aMtHDxclzev5sgcCeM2d6uG/KUlJ3dd9g+UxxqQKPd9M
 E8whxc0O13/vESeUYAOfuFseJZ5CNAtvSyqDwqwWc+MzFIzMsvsrFkyYTgThLZUCluPwvvtuC
 43LAWLvnCqnDr7FD9p+gFRmvGPfaO03xvE+SA/ZN70PlcyrNWh7lfUpjXo9PfuCaTmPlAp7Iu
 3nagVGZEg4msHM+IXp8w==
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [alsa-devel] [PATCH v6 0/8] Fix year 2038 issue for sound
	subsystem
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Nov 13, 2019 at 6:04 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 13 Nov 2019 17:51:57 +0100,
> Arnd Bergmann wrote:
> >
> > On Wed, Nov 13, 2019 at 5:40 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > On Wed, 13 Nov 2019 15:32:44 +0100, Arnd Bergmann wrote:
> >
> > > > We had discussed alternatives for this one last time, and decided
> > > > to go with the solution I posted here. The main alternative would
> > > > be to change the 'timespec' in snd_timer_tread to a fixed-length
> > > > structure based on two 'long' members. This would avoid the
> > > > need to match the command with the time_t type, but the cost would
> > > > be requiring CLOCK_MONOTONIC timestamps to avoid the
> > > > overflow, and changing all application source code that requires
> > > > the type to be compatible with 'timespec'.
> > >
> > > Fair enough.
> > >
> > > One thing I forgot to mention: when we add/modify the ioctl or ABI, we
> > > need to increment the protocol version, e.g. SNDRV_PCM_VERSION to
> > > indicate user-space the supported ABI.  Please change these in your
> > > next patches, too.
> >
> > Just to confirm: this should be a simple one-line patch at the end of the
> > series like
> >
> > diff --git a/tools/include/uapi/sound/asound.h
> > b/tools/include/uapi/sound/asound.h
> > index df1153cea0b7..72e8380c6dcd 100644
> > --- a/include/uapi/sound/asound.h
> > +++ b/include/uapi/sound/asound.h
> > @@ -154,7 +154,7 @@ struct snd_hwdep_dsp_image {
> >   *                                                                           *
> >   *****************************************************************************/
> >
> > -#define SNDRV_PCM_VERSION              SNDRV_PROTOCOL_VERSION(2, 0, 14)
> > +#define SNDRV_PCM_VERSION              SNDRV_PROTOCOL_VERSION(2, 0, 15)
> >
> >  typedef unsigned long snd_pcm_uframes_t;
> >  typedef signed long snd_pcm_sframes_t;
> >
> > right? Most other kernel interfaces have no version numbering, so
> > I don't know what policy you have here.
>
> I don't mind much about that, so it's up to you -- we can fold this
> change into the patch that actually adds or modifies the ioctl, too.

I've added the patch below to the end of the series now, will repost
the series  after no more comments come in for this version.
Having a single patch to update the version seems better than updating
it multiple times with each patch touching the ABI in this series.

      Arnd

commit b83a3eaece9b445f897a6f5ac2a903f2566a0e9d
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Nov 13 17:49:14 2019 +0100

    ALSA: bump uapi version number

    Change SNDRV_PCM_VERSION to indicate the addition of the time64
    version of the mmap interface and these ioctl commands:

    SNDRV_PCM_IOCTL_SYNC
    SNDRV_RAWMIDI_IOCTL_STATUS
    SNDRV_PCM_IOCTL_STATUS
    SNDRV_PCM_IOCTL_STATUS_EXT
    SNDRV_TIMER_IOCTL_TREAD
    SNDRV_TIMER_IOCTL_STATUS

    32-bit applications built with 64-bit time_t require both the headers
    and the running kernel to support at least API version 2.0.15. When
    built with earlier kernel headers, some of these may not work
    correctly, so applications are encouraged to fail compilation like

     #if SNDRV_PCM_VERSION < SNDRV_PROTOCOL_VERSION(2, 0, 15)
     extern int __fail_build_for_time_64[sizeof(long) - sizeof(time_t)];
     #endif

    or provide their own updated copy of the header file.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 25dbf71fa667..5cddfe62c97a 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -156,7 +156,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/

-#define SNDRV_PCM_VERSION              SNDRV_PROTOCOL_VERSION(2, 0, 14)
+#define SNDRV_PCM_VERSION              SNDRV_PROTOCOL_VERSION(2, 0, 15)

 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
