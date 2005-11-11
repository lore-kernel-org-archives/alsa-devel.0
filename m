From: Tom Watson <sdc695@yahoo.com>
Subject: Re: xxx_t replacement (was:ALSA SoC layer)
Date: Fri, 11 Nov 2005 12:05:40 -0800 (PST)
Message-ID: <20051111200540.44242.qmail@web60820.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web60820.mail.yahoo.com (web60820.mail.yahoo.com [209.73.178.228])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E1D9F1BD
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2005 21:05:56 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

While I agree with the usefulness of the task, for most of ALSA it was pr=
etty
simple to deduce the underlying struct that was typedef'd.  It seems that=
 for
almost ALL xxx_t, the definition was something like:

typedef struct xxx xxx_t;

Now that hte conversion is done (or is going to be done), I have a furthe=
r
request:  Please change the document(s) about writing an ALSA driver.  I =
just
pulled off the PDF version and it has bunches of "xxx_t" typedef uses.  A=
lso it
would be nice to have the document(s) updated to reflect changes incorpor=
ated
since its inception (it still refers to the 0.5 series, and mostly to the=
 0.9
series).  I suspect that the update would be welcome as well.  We have le=
arned
quite a bit in the past few years about sound drivers and all their quirk=
s.

Other than that, all is well.

Thanks.  I couldn't have done my project without ALSA!!

--=20
Tom Watson
tsw@johana.com


	=09
__________________________________=20
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
