From: Joerg Mayer <jmayer@loplof.de>
Subject: Re: 1.0.2 release
Date: Tue, 27 Jan 2004 12:13:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127111343.GI31683@thot.informatik.uni-kl.de>
References: <Pine.LNX.4.58.0401271049310.3133@pnote.perex-int.cz> <4016394B.7080201@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from uni-kl.de (mail.uni-kl.de [131.246.137.52])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA17145
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 12:13:56 +0100
Received: from mailgate1.uni-kl.de ([131.246.120.5] verified)
  by uni-kl.de (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 2226983 for alsa-devel@alsa-project.org; Tue, 27 Jan 2004 12:13:49 +0100
Received: from mailinf.rhrk.uni-kl.de (mailinf.rhrk.uni-kl.de [131.246.137.54])
	by mailgate1.uni-kl.de (8.12.10/8.12.10) with ESMTP id i0RBDmtT021417
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 12:13:49 +0100
Received: from thot.informatik.uni-kl.de (thot.informatik.uni-kl.de [131.246.76.12])
	by mailinf.rhrk.uni-kl.de (8.12.6/8.12.6) with ESMTP id i0RBDmv6024374
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 11:13:48 GMT
Received: from thot.informatik.uni-kl.de (localhost [127.0.0.1])
	by thot.informatik.uni-kl.de (8.12.10/8.12.9) with ESMTP id i0RBDhxq017324
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 12:13:43 +0100
Received: (from jmayer@localhost)
	by thot.informatik.uni-kl.de (8.12.10/8.12.7/Submit) id i0RBDhGW017323
	for alsa-devel@alsa-project.org; Tue, 27 Jan 2004 12:13:43 +0100
Content-Disposition: inline
In-Reply-To: <4016394B.7080201@gmx.net>
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

On Tue, Jan 27, 2004 at 11:11:23AM +0100, Carl-Daniel Hailfinger wrote:
> Jaroslav Kysela wrote:
> > Hello all,
> >=20
> > 	we released packages 1.0.2.
>=20
> The current tree from kernel.org claims in linux/include/sound/version.=
h
> that only Alsa 0.9.7 is integrated. Is that correct?

Another point: With the release of 1.0, I really think that ALSA should
be integrated into 2.4 (while Marcelo still accepts such updates).
Reasoning: 2.4 isn't going to die for quite a while and having a uniform
way of ALSA integration into the various distros would be helpful
(does RedHat aka Fedora habe ALSA support by now?)
It would also send a clear message to developers that ALSA is the way to
go, not OSS and ALSA with the 1.0 API and not something older (Wine comes
to my mind).

  ciao
    J=F6rg
--=20
Joerg Mayer                                           <jmayer@loplof.de>
We are stuck with technology when what we really want is just stuff that
works. Some say that should read Microsoft instead of technology.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
