From: =?iso-8859-1?Q?J=FCrgen?= Zimmermann <jnzimmer@informatik.uni-kl.de>
Subject: Reverse engineering from Windows 2000 WDM drivers?
Date: Fri, 10 May 2002 16:47:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDBDD6F.F67EEA8F@informatik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from uni-kl.de (mail.uni-kl.de [131.246.137.52])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA15586
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2002 16:48:42 +0200
Received: from mailgate2.uni-kl.de (mailgate2.uni-kl.de [131.246.120.7])
	by uni-kl.de (8.11.6+Sun/8.11.5) with ESMTP id g4AElQk01121
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2002 16:47:26 +0200 (MET DST)
Received: from mailinf.rhrk.uni-kl.de (mailinf.rhrk.uni-kl.de [131.246.137.54])
	by mailgate2.uni-kl.de (8.12.1/8.12.1) with ESMTP id g4AElQd9016790
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2002 16:47:26 +0200
Received: from vw1-nehmer.informatik.uni-kl.de (vw1-nehmer.informatik.uni-kl.de [131.246.19.251])
	by mailinf.rhrk.uni-kl.de (8.10.2+Sun/8.11.5) with SMTP id g4AElPd23742
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2002 16:47:25 +0200 (MET DST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I wonder if anyone has experience in doing reverse engineering=20
Windows 2000 WDM drivers in order to create a new driver for
the ALSA chipset.

The card I have in question is a YAMAHA SW1000XG, and there are both
Windows9x and Windows 2000 WDM drivers available, but to my knowledge
there are no signs for Linux support (as this is a "professional"
card... Hm...).

On the other hand, perhaps it could be possible to setup the card
and create a driver with the knowledge derived from the Windows drivers.

So, can anyone give me some hints how to "trace" the card's setup and
working?

So long,
  J=FCrgen


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
