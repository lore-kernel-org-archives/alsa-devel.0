From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Float sample format
Date: Thu, 4 Nov 2004 18:28:20 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411041820400.4510@pnote.perex-int.cz>
References: <E1CPfq9-0006EQ-UC@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B5954252
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2004 18:29:42 +0100 (MET)
In-Reply-To: <E1CPfq9-0006EQ-UC@mailer.emlix.com>
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

On Thu, 4 Nov 2004, Nicolas H=FCppelsh=E4user wrote:

> Hi all!
>=20
> What are the sample value ranges used when having sample format float(le)=
 or=20
> double(le)?
>=20
> When playing, the sound is loudest when using the whole range the type of=
fers.

Of course, if you gain the samples, then you'll get louder output but
not in full dynamic range.

> When recording it seems the values are in range [-1,1].  Is that correct?

Yep:

        /** Float 32 bit Little Endian, Range -1.0 to 1.0 */
        SND_PCM_FORMAT_FLOAT_LE,
        /** Float 32 bit Big Endian, Range -1.0 to 1.0 */
        SND_PCM_FORMAT_FLOAT_BE,
        /** Float 64 bit Little Endian, Range -1.0 to 1.0 */
        SND_PCM_FORMAT_FLOAT64_LE,
        /** Float 64 bit Big Endian, Range -1.0 to 1.0 */
        SND_PCM_FORMAT_FLOAT64_BE,

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
