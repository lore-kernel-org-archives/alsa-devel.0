From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Float sample format
Date: Fri, 5 Nov 2004 09:37:49 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411050933220.6258-100000@studcom.urz.uni-halle.de>
References: <E1CPyba-0008S3-1P@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D1466213
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2004 09:37:50 +0100 (MET)
In-Reply-To: <E1CPyba-0008S3-1P@mailer.emlix.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicolas =?iso-8859-1?q?H=FCppelsh=E4user?= <nh@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nicolas H=FCppelsh=E4user wrote:
> On Thursday 04 November 2004 15:52, Clemens Ladisch wrote:
> > Nicolas H=FCppelsh=E4user wrote:
> > > When playing, the sound is loudest when using the whole range the t=
ype
> > > offers.
> >
> > Really?  What sound card lets you play inifinitely loud samples? :-)
>
> ;-)  Well, in fact for playback I use [FLT_MIN,FLT_MAX] and it turned o=
ut to
> be louder than [-1,1]

The float->linear conversion code clips at -1/1 (search for GET32F_END
in alsa-lib/src/pcm/plugin_ops.h), so what you got what a case of
extreme compression.  No doubt this _is_ louder. :)


Best regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
