From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 0/3] Fallback mechanism for pulse plugin
Date: Sun, 25 Sep 2011 06:43:14 +0800
Message-ID: <CAN8cciZ_=chhMQLd7kTUBcHQS+xj7wrwgBr4Lu+7gQBwFX2DBg@mail.gmail.com>
References: <s5hk4b5w7aq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7513A2440E
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Sep 2011 00:43:16 +0200 (CEST)
Received: by fxe22 with SMTP id 22so5072477fxe.38
	for <alsa-devel@alsa-project.org>; Sat, 24 Sep 2011 15:43:14 -0700 (PDT)
In-Reply-To: <s5hk4b5w7aq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/7/26 Takashi Iwai <tiwai@suse.de>:
> Hi,
>
> the following are experimental patches for implementing the fallback
> option of PCM / control pulse plugin. =A0When the connection to PA
> server fails, the plugin tries to open the fallback name.
>
> For achieving this, I added the new standard definition "sysdefault",
> which is equal with the normal "default" PCM / control definitions.
> The difference is only the name, i.e. it won't be overridden by other
> setups. =A0Then two new API functions for opening a fallback PCM /
> control, and finally a patch for pulse-plugin will follow. =A0All
> changes are relatively small and easy.
>
> Let me know if you have any suggestions or a better idea.
>

if  the definition of sysdefault for pcm is

pcm.sysdefault cards.pcm.default

it seem that definition of sysdefault for ctl should be

ctl.sysdefault ctl.hw


since aplay -Dsysdefault:1 any.wav can select card 1 's default pcm
