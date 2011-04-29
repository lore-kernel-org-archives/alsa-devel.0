From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: SALSA-library version 0.1.0 released
Date: Fri, 29 Apr 2011 09:27:41 -0500
Message-ID: <BANLkTi=BV80T3K9bHoNciXt8DjhEnmnNpA@mail.gmail.com>
References: <s5hzkn9efi4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CAE2C1037EA
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 16:27:42 +0200 (CEST)
Received: by vxi40 with SMTP id 40so3160664vxi.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2011 07:27:41 -0700 (PDT)
In-Reply-To: <s5hzkn9efi4.wl%tiwai@suse.de>
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

On Fri, Apr 29, 2011 at 1:30 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Hi,
>
> my old small pet project, salsa-lib, was refreshed recently and bumped
> to version 0.1.0 after a long pause.
>
> Now it can build a drop-in libasound.so.* that is ABI-compatible with
> the real alsa-lib. =A0At least, the programs in alsa-utils (except for
> sequencer stuff) and PulseAudio daemon worked somehow.

Aren't you missing snd_pcm_hw_params_set_period_wakeup() ?
This is required by PulseAudio now.
Also if you had a description of what is supported it'd be great.
Thanks,
-Pierre
