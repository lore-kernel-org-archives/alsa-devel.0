From: =?iso8859-15?Q?Nicolas_H=FCppelsh=E4user?= <nh@emlix.com>
Subject: Re: ALSA and select, poll, ... (interrupted system
 calls)
Date: Tue, 22 Jun 2004 12:01:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1Bci5z-0007D7-00@mailer.emlix.com>
References: <Pine.HPX.4.33n.0406181920390.9993-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0406181920390.9993-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Fri, 18 Jun 2004, Clemens Ladisch wrote:

> Nicolas H=FCppelsh=E4user wrote:
> > By now I workaround with a mixture of nanosleep/"time polling" (trackin=
g
> > elapsed system time in a loop).  Is there a better way?
>
> If you're waiting anyway, why don't you simply wait with poll?

I need to wait a defined amount of time.
And it doesn't make a differecne whether using poll or nanosleep since
both get interrupted by alsa async signals.

regards
=09Nicolas




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
