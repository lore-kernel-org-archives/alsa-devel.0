From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: snd-usb endpoint rework
Date: Sun, 20 May 2012 14:08:04 +0100
Message-ID: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6944A243C5
	for <alsa-devel@alsa-project.org>;
	Sun, 20 May 2012 15:08:05 +0200 (CEST)
Received: by vbip1 with SMTP id p1so3372626vbi.38
	for <alsa-devel@alsa-project.org>; Sun, 20 May 2012 06:08:04 -0700 (PDT)
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

Hello everyone,

I compiled today the Kernel 3.4.0-rc7 from the git and used this git
to add the FTU support:
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Unfortunately, all my USB sound card simply stopped working.

The FTU doesn't produce any sound, nor through Alsa or Jack.
I tried playing a simple song through mplayer and nothing. I double
checked the mixer, all volumes are set as they should.
I checked dmesg, no error that could help.
I'm running Ubuntu, and the only thing I can hear is the welcoming
sound of ubuntu being cut-off almost instantly.

I tested my Edirol UA-25Ex, it is working all ok.

Let me know if there is any other info I could provide that would help,

Thanks in advance,
Aur=E9lien
