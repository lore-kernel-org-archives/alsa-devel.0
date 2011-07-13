From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/5] ALSA: snd-usb: don't fail hard if
 mixer creation fails
Date: Wed, 13 Jul 2011 14:06:45 +0200
Message-ID: <CACTFLAOK=Mup6=LR4aC+9P2A77ULeT77S9SWv5uuE9fFRRJDOQ@mail.gmail.com>
References: <1310516009-4387-1-git-send-email-zonque@gmail.com>
	<s5htyaqg34m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 68DD524356
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 14:06:48 +0200 (CEST)
Received: by pzk26 with SMTP id 26so5417118pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2011 05:06:45 -0700 (PDT)
In-Reply-To: <s5htyaqg34m.wl%tiwai@suse.de>
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

On Wed, Jul 13, 2011 at 7:29 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 13 Jul 2011 02:13:25 +0200,
> Daniel Mack wrote:
>>
>> There are cards that the mixer code fails to create controls for, and
>> currently, the whole sound device creation fails in such cases. This
>> patch changes the code so that it just spits out warnings and continues
>> looking at other functions of the descriptor set which might work just
>> fine.
>
> It depends. =A0If a serious error like -ENOMEM, we should abort
> immediately. =A0It means something is really bad.

That's very true. I'll change this and resend the whole series.

Thanks,
Daniel
