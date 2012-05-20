From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: snd-usb endpoint rework
Date: Sun, 20 May 2012 15:13:25 +0100
Message-ID: <CAE-xCyP-mN=txZwjnV4Vd6h8UgM-Qgn83jxin6LiYH0Q2-Daiw@mail.gmail.com>
References: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2D590243DD
	for <alsa-devel@alsa-project.org>;
	Sun, 20 May 2012 16:13:26 +0200 (CEST)
Received: by vbip1 with SMTP id p1so3384160vbi.38
	for <alsa-devel@alsa-project.org>; Sun, 20 May 2012 07:13:25 -0700 (PDT)
In-Reply-To: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, gdiffey@gmail.com, clemens@ladisch.de, tiwai@suse.de, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

> Hello everyone,
>
> I compiled today the Kernel 3.4.0-rc7 from the git and used this git
> to add the FTU support:
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>
> Unfortunately, all my USB sound card simply stopped working.
>
> The FTU doesn't produce any sound, nor through Alsa or Jack.
> I tried playing a simple song through mplayer and nothing. I double
> checked the mixer, all volumes are set as they should.
> I checked dmesg, no error that could help.
> I'm running Ubuntu, and the only thing I can hear is the welcoming
> sound of ubuntu being cut-off almost instantly.
>
> I tested my Edirol UA-25Ex, it is working all ok.

Correction, the UA-25Ex doesn't work either.
The sound dies out after a few minutes being used.

When the sound dies out, dmesg prints:

[  550.114621] urb status -32
[  551.601237] urb status -32
[  551.681206] urb status -32
[  553.563336] urb status -32
[  565.588044] urb status -32
[  566.786965] urb status -32
[  625.130221] cannot submit urb 0, error -28: not enough bandwidth

If there is any other info I can provide, let me know,

Aur=E9lien
