From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ALSA: Include linux/pci.h in sound/core.h
Date: Mon, 30 Jan 2012 14:01:37 +0800
Message-ID: <CAF+7xW=CcvgVaNBZc+Ky8ogC-vn-XehxesLQT9Shb7ADYuypTQ@mail.gmail.com>
References: <1327902275.12540.1.camel@phoenix>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m020-f179.google.com (mail-lpp01m020-f179.google.com
	[209.85.217.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BC7FF24499
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 07:01:57 +0100 (CET)
Received: by lbbge1 with SMTP id ge1so236339lbb.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 22:01:57 -0800 (PST)
In-Reply-To: <1327902275.12540.1.camel@phoenix>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2012/1/30 Axel Lin <axel.lin@gmail.com>:
> commit d1458279b "ALSA: Add snd_pci_quirk_lookup_id()" introduces below b=
uild
> waring:
> =A0CC =A0 =A0 =A0sound/sound_core.o
> In file included from sound/sound_core.c:15:
> include/sound/core.h:454: warning: 'struct pci_dev' declared inside param=
eter list
> include/sound/core.h:454: warning: its scope is only this definition or d=
eclaration, which is probably not what you want
>
> Include linux/pci.h to fix the build warning.
>
oh.. The correct fix should be to add #ifdef CONFIG_PCI guard for
snd_pci_quirk_*
I'll send the fix now.

Axel
