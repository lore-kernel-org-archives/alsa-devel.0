From: "Rene E. Henriquez G." <rene.henriquez@gmail.com>
Subject: ioctl problem - help please!!
Date: Tue, 2 Feb 2010 15:34:08 -0600
Message-ID: <60ef6ece1002021334q4eb53641p5308f84847ed3949@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id C2A85103861
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 22:34:09 +0100 (CET)
Received: by fxm1 with SMTP id 1so625016fxm.4
	for <alsa-devel@alsa-project.org>; Tue, 02 Feb 2010 13:34:09 -0800 (PST)
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

Good day to everyone.

I'm developing a system in which I need to gather some entropy from
/dev/random. In order to increase the entropy, I'm using a daemon called
audio-entropyd from Folkert van Heusden, but it has some problems that maybe
you guys can help me with this.

Does anybody know what might cause this:

2925  open("/dev/snd/pcmC0D0c", O_RDWR|O_NONBLOCK) =3D 5
2925  ioctl(5, 0x80184151, 0x7ffff3351890) =3D -1 EIO (Input/output error)

to give EIO?

The daemon just stops with the KILL signal.

Thanks for reading this, I really need your assistance for this please.

Regards,

Ren=E9.
