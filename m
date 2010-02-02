From: Jani Frilander <j.frilander@gmail.com>
Subject: Re: Zoom R16 (USB), will a quirk make it work
Date: Tue, 2 Feb 2010 20:23:08 +0200
Message-ID: <e53c6f621002021023s64f7cefct668505aa6ed72c5@mail.gmail.com>
References: <e53c6f621002012146n71ac0f7enb7e9f6e9c3b098d2@mail.gmail.com>
	<4B67DB5E.9080208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 85F25103825
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 19:23:10 +0100 (CET)
Received: by ewy23 with SMTP id 23so93068ewy.4
	for <alsa-devel@alsa-project.org>; Tue, 02 Feb 2010 10:23:09 -0800 (PST)
In-Reply-To: <4B67DB5E.9080208@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/2 Clemens Ladisch <clemens@ladisch.de>:

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ifnum =3D=
 .1  #< Is this a typo? Should be -1?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},

>
> I don't know why there was an audio device at all (in theory, your quirk
> entry shouldn't have worked), but the device supports only 24-bit
> samples, so use "plughw" instead of "hw" (or better "default" for
> software mixing).

No sound with plughw.

-Jani
