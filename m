From: Zaar Hai <haizaar@haizaar.com>
Subject: Re: Is Intel 82801G (ICH7 family) with VIA VT1708B
	8-Ch supported?
Date: Wed, 17 Feb 2010 15:07:33 +0200
Message-ID: <cfb54191002170507n25e28f1fodec06458570cf7ae@mail.gmail.com>
References: <cfb54191002141233w4ba7cc85j81c31aabd45950c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 1954B10388A
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 14:07:58 +0100 (CET)
Received: by ewy5 with SMTP id 5so2643987ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 05:07:57 -0800 (PST)
Received: by ewy5 with SMTP id 5so2643904ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 05:07:55 -0800 (PST)
In-Reply-To: <cfb54191002141233w4ba7cc85j81c31aabd45950c6@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

No one have replied, so I'll ask again.
May be someone can give just yes/no answer: VIA VT1708B as ICH7 HDA codec -
supported or not?

On Sun, Feb 14, 2010 at 10:33 PM, Zaar Hai <haizaar@haizaar.com> wrote:

> Good day, dear ALSA developers!
>
> I've got several boards based on Intel G41 chipset, which has ICH7
> south bridge with VT1708B codec on it. While VT1708B seems to be
> supported since 2007, on all my computers the card is recognized, but
> mixer does not work:
>
>   $ alsamixer
>   alsamixer: function snd_mixer_load failed: Invalid argument
>
> I've tried it on Debian, OpenSuse and Ubuntu (including nightly
> builds), both 32 and 64 bit version, on 4 computers (all have the same
> hardware) - result is the same: card recognized, sound is played, but
> mixer (volume channels, etc.) does not.
>
> So, I've thought, that since G41 is rather new, may be this ICH7 with
> VT1708B combo is not supported by alsa yet?
>
> [1]. http://pastebin.com/m50dcbff0 - contents of
> /proc/asound/card0/codec#0
> [2]. http://pastebin.com/m42320afc - lspci output
> [3]. http://pastebin.com/m443eaa12 - aplay -l output
>
> P.S. If you think this message rather belongs to users and not devel
> list, just tell me to go there. I've just thought that supported/not
> supported question should better be asked devel list.
> --
> Zaar
>



-- 
Zaar
