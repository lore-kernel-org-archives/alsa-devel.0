From: "Karsten Wiese" <annabellesgarden@yahoo.de>
Subject: AW: general audio card Q
Date: Wed, 31 Jul 2002 13:20:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <DAELIEGDPLDDCIJPAICBIECECDAA.annabellesgarden@yahoo.de>
References: <200207302324.BAA10183@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp012.mail.yahoo.com (smtp012.mail.yahoo.com [216.136.173.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id NAA18112
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2002 13:19:06 +0200
In-Reply-To: <200207302324.BAA10183@alsa.alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org, l5gibson@hotmail.com
List-Id: alsa-devel@alsa-project.org

Paul wrote:

> cards that do not use DMA should generally be considered inferior
> because of the extra CPU cycles they force on the host system.

not generally. i.e. the pinnacle/fiji way is to map a piece of memory int=
o
the pc's memory space.
thus an application using alsa-mmap can write (or read) directly into the
cards pcm-memory.
pretty efficiently, don't you think? (except that its ISA-memory)
(it can do so with 2 or 3 periods per buffer).
I don't see any drawback here caused by the lack of DMA.

regards, Karsten

__________________________________________________________________=0D
=0D
Gesendet von Yahoo! Mail - http://mail.yahoo.de=0D
M=F6chten Sie mit einem Gru=DF antworten? http://grusskarten.yahoo.de=0D


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
