From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: rme9652 locks up my computer
Date: Wed, 20 Feb 2002 10:36:27 +0000
Message-ID: <20020220103627.M25432@ecs.soton.ac.uk>
References: <004401c1b9f8$d214efe0$0300a8c0@wgilmenau>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Received: from ecs.soton.ac.uk (inanna.ecs.soton.ac.uk [152.78.65.48])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA14587
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2002 11:36:37 +0100
Received: (from swh@localhost)
	by ecs.soton.ac.uk (8.11.6/8.11.2) id g1KAaR025693
	for alsa-devel@alsa-project.org; Wed, 20 Feb 2002 10:36:27 GMT
Content-Disposition: inline
In-Reply-To: <004401c1b9f8$d214efe0$0300a8c0@wgilmenau>; from robert@musicalica.de on Wed, Feb 20, 2002 at 11:24:39 +0100
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

On Wed, Feb 20, 2002 at 11:24:39 +0100, Robert Br=FCckmann wrote:
> Hi!
>=20
> only thing I can do is a hard reset. When the computer starts afetr tha=
t,
> and did the ext2-fschk, the alsa-driver-initialzation claims about too =
less
> memory for a buffer of one of the cards. But I've 512MB ram in my compu=
ter!?

The too little memory problem, it too little contiguous memory in the
part of the RAM that can be used by DMA.=20

Running fsck will fragment the memory to the state that the rme driver
can't allocate enough ram. You can fix it by adding an entry into
/etc/rc.d/rc.local or equivalent, but I can't remeber the exact line
offhand.

- Steve

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
