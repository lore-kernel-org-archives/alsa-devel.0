From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: again on the us-x2y
Date: Thu, 4 Nov 2004 17:53:17 -0000 (WET)
Message-ID: <52065.195.245.190.93.1099590797.squirrel@195.245.190.93>
References: <1099580321l.2337l.0l@Zeryn>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from exch01smtp11.hdi.tvcabo (smtp4.netcabo.pt [212.113.174.31])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 047131B1
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2004 18:54:22 +0100 (MET)
In-Reply-To: <1099580321l.2337l.0l@Zeryn>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Antonio Willy Malara <behappy@maialone.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Antonio Willy Malara wrote:
> i've been off from the discussion for a while, been busy with moving,
> now i seen that the ohci issue is solved, but the lastest driver wont
> work for me, i attach the log jackd and the kernel give me
>
> however i can run jack and alsa apps with this card with the 0.8.3a,
> jack with his oss driver, using the alsa emulation driver, and apps
> like mplayer of rhythmbox directly to the alsa driver
>
> wil

What happens if you use hw:0 instead of plughw:0 on jackd?
--=20
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
