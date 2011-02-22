From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: ALSA: usb-audio: fix oops due to cleanup race when
	disconnecting
Date: Tue, 22 Feb 2011 16:19:20 -0600
Message-ID: <AANLkTi=tYR1daV8zWschBikOkcOgWk864n+b-30q4sSD@mail.gmail.com>
References: <Pine.LNX.4.44L0.1102111737280.13739-100000@netrider.rowland.org>
	<4D58EDA9.2020805@ladisch.de> <s5hoc6ejz2j.wl%tiwai@suse.de>
	<20110216235422.GB6375@xanatos> <s5hk4gyy9m1.wl%tiwai@suse.de>
	<4D63800E.30509@ladisch.de> <s5hfwrg9zpv.wl%tiwai@suse.de>
	<AANLkTikcXPTZYYwYDunq4pJwzDhxSv5u++jEWN0RU4EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 500FC103804
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 23:19:22 +0100 (CET)
Received: by yxp4 with SMTP id 4so1162549yxp.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 14:19:21 -0800 (PST)
In-Reply-To: <AANLkTikcXPTZYYwYDunq4pJwzDhxSv5u++jEWN0RU4EQ@mail.gmail.com>
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
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

>> Ah, I forgot to put my sign-off since I was waiting for any test
>> result... =A0Has anyone tried it?
>
> Doesn't work for me. same oops as before. Either I made a mistake when
> merging this patch manually (there were some rejects), or the problem
> is still there.

Added some additional traces, the dereference takes place before the
mutex is unlocked.

usb 3-1: USB disconnect, address 5
ALSA card.c:556: locking USB shutdown mutex
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err =3D -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err =3D -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err =3D -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err =3D -19)
ALSA urb.c:186: NULL substream (subs->running 0)
ALSA urb.c:186: NULL substream (subs->running 0)
ALSA card.c:575: UNlocking USB shutdown mutex
