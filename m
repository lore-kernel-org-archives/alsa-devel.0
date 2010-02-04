From: "Rene E. Henriquez G." <rene.henriquez@gmail.com>
Subject: Re: ioctl problem - help please!!
Date: Thu, 4 Feb 2010 14:33:54 -0600
Message-ID: <60ef6ece1002041233he37c1b3k77a72e1ec6bddaf3@mail.gmail.com>
References: <60ef6ece1002021334q4eb53641p5308f84847ed3949@mail.gmail.com>
	<4B6A9722.3070109@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f223.google.com (mail-fx0-f223.google.com
	[209.85.220.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 16D8C10382F
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 21:33:55 +0100 (CET)
Received: by fxm23 with SMTP id 23so56455fxm.22
	for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2010 12:33:55 -0800 (PST)
In-Reply-To: <4B6A9722.3070109@ladisch.de>
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

Thanks a lot for your reply Clemens.

The driver is Type 10 ALSA emulation.

Yes, normal recording just works fine with the following command:

arecord -f dat -d 2800 audioDAT.wav


I'll wait for your comments, and thanks again.

Ren=E9.

PS: Sorry for the uncompleted mail before... wrong keystroke

On Thu, Feb 4, 2010 at 3:45 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Rene E. Henriquez G. wrote:
> > Does anybody know what might cause this:
> >
> > 2925  open("/dev/snd/pcmC0D0c", O_RDWR|O_NONBLOCK) =3D 5
> > 2925  ioctl(5, 0x80184151, 0x7ffff3351890) =3D -1 EIO (Input/output err=
or)
> >
> > to give EIO?
>
> Some error detected by the driver.  Which driver?
> Does normal recording work?
>
>
> Regards,
> Clemens
>
