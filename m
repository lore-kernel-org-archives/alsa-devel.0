From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH alsa-lib 0/1] bug fix and comment on
	"switch"
Date: Mon, 14 May 2012 23:47:58 +0800
Message-ID: <CAAj6DX1X+B4V98DuUr7tJzKRP+7+KT33OEmEcdnQ5zC7STYVSA@mail.gmail.com>
References: <1336838783-30686-1-git-send-email-borneo.antonio@gmail.com>
	<s5h8vguyfkm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6BD2F24A33
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:48:00 +0200 (CEST)
Received: by dajt11 with SMTP id t11so8578672daj.38
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2012 08:47:59 -0700 (PDT)
In-Reply-To: <s5h8vguyfkm.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 14, 2012 at 10:58 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 13 May 2012 00:06:22 +0800,
> Antonio Borneo wrote:
>>
>> Hi,
>>
>> this is a very simple one line patch but the issue was
>> driving me crazy for few days.
>>
>> After this finding, I have reviewed all the "switch"
>> statements in alsa-lib. All well done with proper comment
>> when a "case" falls through the next "case".
>
> Thanks, applied the patch now.

Thanks!

>
>> But there is one "switch" that does not follow the usual
>> scheme.
>> In file src/pcm/pcm_dsnoop.c
>> procedure snd_pcm_dsnoop_delay()
>> following code fragment:
>>
>> =A0 =A0 =A0 =A0 switch(dsnoop->state) {
>> =A0 =A0 =A0 =A0 case SNDRV_PCM_STATE_DRAINING:
>> =A0 =A0 =A0 =A0 case SNDRV_PCM_STATE_RUNNING:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D snd_pcm_dsnoop_sync_ptr(pcm);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> =A0 =A0 =A0 =A0 case SNDRV_PCM_STATE_PREPARED:
>> =A0 =A0 =A0 =A0 case SNDRV_PCM_STATE_SUSPENDED:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *delayp =3D snd_pcm_mmap_capture_hw_avai=
l(pcm);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> If snd_pcm_dsnoop_sync_ptr() returns no error, execution
>> falls through next "case".
>> It's missing the usual comment
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Fall through */
>> to highlight such code behavior.
>> I think the code is correct, but I do not have enough
>> experience on alsa-lib to be sure. Please confirm.
>> In such case, I would suggest adding the comment above.
>
> Yes, the comment should be added.
> Care to send a patch?

I'll send it shortly.

Best Regards
Antonio Borneo
