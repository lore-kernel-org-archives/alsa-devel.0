From: =?ISO-8859-1?Q?Lorenzo_Fundar=F3?= <lfundaro@etu.utc.fr>
Subject: about ioctl calls
Date: Thu, 26 May 2011 12:07:02 +0200
Message-ID: <BANLkTi=NFkcwxPiwULYxtLGv+=dgjXgFdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 49D0E103AA8
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 12:07:24 +0200 (CEST)
Received: by qyk7 with SMTP id 7so330448qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2011 03:07:23 -0700 (PDT)
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

Hi folks,

I have a program that constantly make ioctl calls like this:

ioctl(4, 0x4122, 0x8b703)
ioctl(4, 0x4122, 0xbfb65768)

I suspect that this call pertains to ALSA, since I have straced other
programs that play music and they always use in the ioctl request field the
0x4122 code.
I am interested on finding out what's in the third argument of the ioctl
call,
is it a sort of struct that contains the audio samples ?

Thanks in advance,

Lorenzo Fundar=F3 Garc=EDa
Universit=E9 de Technologie de Compi=E8gne
G=E9nie Informatique
