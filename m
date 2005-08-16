From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Re: Compulab sound device
Date: Tue, 16 Aug 2005 05:58:13 -0700 (PDT)
Message-ID: <20050816125813.75232.qmail@web54609.mail.yahoo.com>
References: <Pine.HPX.4.33n.0508160918350.11998-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0508160918350.11998-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I can't compile a newer kernel version. This is
because Compulab Armcore only supports till kernel
2.6.7 and in that contains ALSA 1.0.4.=20

Anymore options to solve this? Really appreciate the
help all this while.

Regards,
Chow Raymond

--- Clemens Ladisch <clemens@ladisch.de> wrote:

> Chow Raymond wrote:
> > Im not sure how to use CVS. Anyway I followed what
> you
> > suggested which is to copy the content in
> > alsa-kernel/arm to kernel's sound/arm. However,
> when i
> > rebuild the kernel, i face a missing header file.
> >
> > asm/arch/audio.h: No such file or directory
>=20
> It seems your kernel is too old.
> A newer kernel would have a newer ALSA, too.
>=20
>=20
> HTH
> Clemens
>=20
>=20
>=20
>
-------------------------------------------------------
> SF.Net email is Sponsored by the Better Software
> Conference & EXPO
> September 19-22, 2005 * San Francisco, CA *
> Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects
> & Teams * Testing & QA
> Security * Process Improvement & Measurement *
> http://www.sqe.com/bsce5sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
