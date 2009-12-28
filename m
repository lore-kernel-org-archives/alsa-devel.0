From: Devin Heitmueller <dheitmueller@kernellabs.com>
Subject: Re: [PATCH - usb/usbaudio.c 1/1] sound/usb: Relax urb
	data align. restriction for HVR-950Q and HVR-850 only
Date: Mon, 28 Dec 2009 06:44:56 -0500
Message-ID: <829197380912280344q336908aasff04ecca46ce287c@mail.gmail.com>
References: <s5hy6krtc1r.wl%tiwai@suse.de>
	<4b379748.9453f10a.5e00.ffffcc05@mx.google.com>
	<s5h7hs7uybh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 8884B10385D
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 12:44:56 +0100 (CET)
Received: by fxm4 with SMTP id 4so33108337fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 03:44:56 -0800 (PST)
In-Reply-To: <s5h7hs7uybh.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, johnsgruber@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 28, 2009 at 6:34 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 27 Dec 2009 12:19:56 -0500,
> johnsgruber@gmail.com wrote:
>>
>> Rebase to git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.=
git c1e3acc1131be209a27676d8f363cbabcf9e0c76
>>
>> Refine frame counting
>>
>> Sent with git send-email to avoid MUA line folding.
>
> Thanks. =A0Applied all three patches now (with a minor fix for a compile
> warning).

John,

Thanks for taking the time to work through the issues and getting this
into the mainline.  I'm sure it will help out users quite a bit.

Cheers,

Devin Heitmueller
(the resident HVR-950q maintainer)

-- =

Devin J. Heitmueller - Kernel Labs
http://www.kernellabs.com
