From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: BT878 support.
Date: Wed, 12 May 2004 17:34:42 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405121732090.26780-100000@studcom.urz.uni-halle.de>
References: <409F78DB.2040008@fabricadeideias.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <409F78DB.2040008@fabricadeideias.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rodrigo Severo <rodrigo.lists@fabricadeideias.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Rodrigo Severo wrote:

> Clemens Ladisch wrote:
>
> >Rodrigo Severo wrote:
> >
> >>I have two Prolink PlayTV Pro capture cards (PV-BT878P+). One of them is
> >>revision 8E and tthe other is revision 9F.
> >>
> >>I tried to use both of them with the snd-bt87x driver. Both of them
> >>returned only static.

Did you try analog or digital or both?

> >>I managed to get analog sound from the 8E with the btaudio (OSS) driver,

Does digital work?

> >Which version?
> >
> ALSA 1.0.4 and btaudio which came with kernel 2.4.25.

In theory, btaudio and snd-bt87x should behave identically.
What btaudio mixer settings and input do you use when it works?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
