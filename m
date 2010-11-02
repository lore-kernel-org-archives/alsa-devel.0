From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH 1/2] pcm: pass hw_params flags to slave
Date: Tue, 2 Nov 2010 07:52:58 -0500
Message-ID: <AANLkTimN7R3W6w4NQLpLbVmby6jFaBR=Lg3120vs7xLs@mail.gmail.com>
References: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
	<s5heib418z5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C524D244F1
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 13:53:01 +0100 (CET)
Received: by iwn2 with SMTP id 2so7774067iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Nov 2010 05:52:59 -0700 (PDT)
In-Reply-To: <s5heib418z5.wl%tiwai@suse.de>
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

Thanks Takashi for the review.

> I'm a bit skeptical whether this is safe to apply.
> The plugins might not be always transparent. =A0Double-check whether
> this doesn't break all plugins behaviors.

I am really not sure how I can prove that passing flags does not alter
existing behavior, I identified this issue experimentally after
several hours and I must admit I don't really understand the alsa-lib
code.
The question is really why weren't the flags propagated in the initial
code? All parameters (info, rate, etc) are passed to the slave, except
the flags. Either this was a conscious design decision, in which case
my patch would create a problem, or this was a miss and my patch
corrects it.

>> =A0 =A0 =A0 params->info &=3D src->info;
>> + =A0 =A0 =A0 =A0params->flags =3D src->flags; /* propagate flags to sla=
ve */
