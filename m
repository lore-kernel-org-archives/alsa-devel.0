From: Hannu Savolainen <hannu@opensound.com>
Subject: Re: Implementing ALSA compatibility in OSS
Date: Mon, 15 Nov 2004 19:31:23 +0200 (EET)
Message-ID: <Pine.LNX.4.58.0411151859220.9516@zeus.compusonic.fi>
References: <Pine.HPX.4.33n.0411151354510.12617-100000@studcom.urz.uni-halle.de>
 <Pine.LNX.4.58.0411151518070.9417@zeus.compusonic.fi>
 <Pine.LNX.4.58.0411151655090.1751@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411151655090.1751@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Nov 2004, Jaroslav Kysela wrote:

> On Mon, 15 Nov 2004, Hannu Savolainen wrote:
>
> > OSS is a driver API and it's definitely designed to be used directly.
>
> It's (and was) a broken idea. We have never ending trouble to reroute your
> API to ours, because you have not designed a proper library in the user
> space to handle application requests.
Interesting point. Do you mean that all Linux drivers for whatever devices
should have defined their own library interface instead of the using the
traditional Unix device/file interface?

To me this uniform and robust device/file abstraction was the main reason
to get married with Unix. That happened exactly 20 years ago, btw. It was
also the reason why I originally designed OSS in this way.

OSS doesn't have it's own library API. Our goal has been to develop  as
good device drivers as possible and nothing else. As a small company have
intentionally left all user space development (including libraries) to
others.

> While you can use alsa-lib to
> reroute ALSA apps to the OSS driver, we have no such simple way for ALSA
> -> OSS path. We must do an emulation in the kernel side or use some hacks
> to do proper rerouting.
Such is life.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
