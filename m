From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 3/3] ALSA: usb-audio: Move configuration to
	prepare.
Date: Tue, 18 Sep 2012 09:41:17 -0700
Message-ID: <CAEUnVG7f6b6tMeGBj19=w1=8AOOKYi85tWqrfVvmogy1FBMifg@mail.gmail.com>
References: <1347912699-9969-1-git-send-email-dgreid@chromium.org>
 <1347912699-9969-4-git-send-email-dgreid@chromium.org>
 <s5hboh3o5uf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C0392650D7
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 18:41:38 +0200 (CEST)
Received: by weyx10 with SMTP id x10so24089wey.38
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 09:41:38 -0700 (PDT)
In-Reply-To: <s5hboh3o5uf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 18, 2012 at 5:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 17 Sep 2012 13:11:39 -0700,
> Dylan Reid wrote:
>>
>> @@ -451,74 +487,32 @@ static int snd_usb_hw_params(struct snd_pcm_substr=
eam *substream,
>>       struct snd_usb_substream *subs =3D substream->runtime->private_dat=
a;
>>       struct audioformat *fmt;
>>       unsigned int channels, rate, format;
>
> Need to delete this line, as these variables won't be used any longer.
>
> sound/usb/pcm.c: In function =91snd_usb_hw_params=92:
> sound/usb/pcm.c:494:31: warning: unused variable =91format=92 [-Wunused-v=
ariable]
> sound/usb/pcm.c:494:15: warning: unused variable =91channels=92 [-Wunused=
-variable]
> sound/usb/pcm.c:509:15: warning: =91rate=92 may be used uninitialized in =
this function [-Wuninitialized]

Sorry about that, thanks for catching it, I'll send an updated series.

>
>
>
> Takashi
