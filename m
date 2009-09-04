From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Fri, 4 Sep 2009 09:57:43 +0200
Message-ID: <7c5010d60909040057m29b68361nd34a4bb1254860e8@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<7c5010d60909031003l317d7325s9082a30c418a28f8@mail.gmail.com>
	<s5hzl9bc3mo.wl%tiwai@suse.de>
	<7c5010d60909031127m51a91cceqbe48f3115a0ef6d2@mail.gmail.com>
	<s5h1vmnde4b.wl%tiwai@suse.de>
	<7c5010d60909031252v25a71577s3655297e47aa6fa2@mail.gmail.com>
	<s5hfxb3k8v8.wl%tiwai@suse.de>
	<7c5010d60909031503k36a30855h6115e4689d1dd0f4@mail.gmail.com>
	<7c5010d60909031543v4291a332ge415f91f3412dda@mail.gmail.com>
	<s5h7hwfb3h2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id D7505103816
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 09:57:44 +0200 (CEST)
Received: by bwz25 with SMTP id 25so488309bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 00:57:44 -0700 (PDT)
In-Reply-To: <s5h7hwfb3h2.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 4, 2009 at 8:58 AM, Takashi Iwai<tiwai@suse.de> wrote:
> OK, then upgrade your alsa driver stack to 1.0.21. =A0There have been
> some changes in PCM core. =A0Then, get dummy.c again from the latest
> alsa-driver-unstable tarball. =A0It already contains my latest fix.
>
> If 1.0.21+dummy.c doesn't work, apply the patch below to get position
> logs. =A0If this still causes the invalid backward jump to position 0,
> you should check xrun debug, e.g.
> =A0 =A0 =A0 =A0# echo 9 > /proc/asound/card0/pcm0p/xrun_debug
>

I'll do it and report

-giovanni
