From: Nicolas =?iso-8859-1?q?H=FCppelsh=E4user?= <nh@emlix.com>
Subject: Re: Float sample format
Date: Fri, 5 Nov 2004 08:33:52 +0100
Message-ID: <E1CPyba-0008S3-1P@mailer.emlix.com>
References: <Pine.HPX.4.33n.0411041550420.25979-100000@studcom.urz.uni-halle.de>
Reply-To: nh@emlix.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.emlix.com (mail.emlix.com [193.159.217.188])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A477721D
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2004 08:33:55 +0100 (MET)
In-Reply-To: <Pine.HPX.4.33n.0411041550420.25979-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 04 November 2004 15:52, Clemens Ladisch wrote:
> Nicolas H=FCppelsh=E4user wrote:
> > What are the sample value ranges used when having sample format float(l=
e)
> > or double(le)?
>
> Between -1 and 1. (LE/BE doesn't make any difference.)
>
> > When playing, the sound is loudest when using the whole range the type
> > offers.
>
> Really?  What sound card lets you play inifinitely loud samples? :-)

;-)  Well, in fact for playback I use [FLT_MIN,FLT_MAX] and it turned out t=
o=20
be louder than [-1,1] on the Duo USB Audiosport (and in fact when playing t=
he=20
first time I had to pull down my ear-phones - that means the sound is=20
approximatly infinitely loud).

Viele Gruesse / best regards
        Nicolas Hueppelshaeuser

=2D-
nicolas hueppelshaeuser, emlix gmbh, http://www.emlix.com,
mailto:nh@emlix.com
fon +49 551 30664 -0, fax -11, bahnhofsallee 1b, 37081 g=F6ttingen, germany

emlix - your embedded linux partner


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
