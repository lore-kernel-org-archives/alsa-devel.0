From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: signed/unsigned pcm formats
Date: Wed, 08 Sep 2004 10:26:55 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0409081016460.20437-100000@studcom.urz.uni-halle.de>
References: <E1C4dNi-0000yJ-0z@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B68182AF
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 10:27:13 +0200 (MEST)
In-reply-to: <E1C4dNi-0000yJ-0z@mailer.emlix.com>
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
> What is the value range of a signed format type of data width x?

Without the sign, there are x-1 bits for the value, so the maximum
value is 2^(x-1)-1.  Negative values are stored as two's complement,
so the minimum value is -(2^(x-1)).

> For 8 bit I would expect -127,...,128.

It's -128 ... 127.

> How is this range encoded in unsigned type of equal bit width?

Add/subtract 128 (which is the equivalent of flipping the most
significant bit).

> Or is it hardware dependent?

SND_PCM_FORMAT_U8 is defined as above.  If there would be any hardwar=
e
using a different unsigned format (there isn't), another PCM_FORMAT_
would have to be defined.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
