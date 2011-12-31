From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Sat, 31 Dec 2011 15:02:09 +0000
Message-ID: <CAE-xCyOC2dJUAZeR+Efm+1Yd7NehN0vUkix4rnhR-D59UEMAuA@mail.gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
	<CAFz=ag41GGEB6X6AzZi9xshpQLUUuzqkd3qtjiFNEYAs=6N+qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 65D4524396
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 16:02:11 +0100 (CET)
Received: by vcbf13 with SMTP id f13so10254669vcb.38
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 07:02:09 -0800 (PST)
In-Reply-To: <CAFz=ag41GGEB6X6AzZi9xshpQLUUuzqkd3qtjiFNEYAs=6N+qQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Grant Diffey <gdiffey@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

> OK, it doesn't work for me. Each time I try to start a stream I get
> error messages like this:
>
> cannot submit urb 0, error -28: not enough bandwidth

Hi Felix,

Is this when using the FTU or another USB device?

Would your USB device by any chance be of type USB 1, and the type of
the USB port on your machine EHCI?

If so, could it be related to this problem?
http://lists.linuxaudio.org/pipermail/linux-audio-user/2011-November/081814=
.html

There used to be a problem with EHCI and USB1 soundcards.
I never got my Edirol UA-25Ex to work on my machine, gettting the
exact same error as the one you described.

But, few weeks ago, while testing the RC 3.2 kernel with Daniel's
patch, it worked.
I don't believe Daniel's patch fixed the problem, but more the changes
done in 3.2 by Clemens.

Now, after more testing, it turns out my Edirol UA25-Ex works only if
I have a pretty high latency on Jack (25ms).
If I try and decrease the Frames/Period, then the bandwitdh issue
occurs again (mind me, it's way better then before where the sound
card wouldn't work in Full Duplex)...

Hope this helps,
Aur=E9lien
