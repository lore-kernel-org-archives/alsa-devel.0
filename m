From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA and select, poll, ... (interrupted system calls)
Date: Fri, 18 Jun 2004 19:21:20 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406181920390.9993-100000@studcom.urz.uni-halle.de>
References: <E1BbDGp-00086q-00@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <E1BbDGp-00086q-00@mailer.emlix.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso8859-15?Q?Nicolas_H=FCppelsh=E4user?= <nh@emlix.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nicolas H=FCppelsh=E4user wrote:
> Clemens Ladisch wrote:
> > What does the ALSA code in your program do?  There won't be any
> > signals unless you have enabled asynchronous notifications using
> > SIGIO.
>
> You're right - the interruption occurs only if asynchronous notific=
ations
> is enabled;  I enable it via the  snd_async_add_pcm_handler  functi=
on.
> The code itself does nothing very special: capturing and playing so=
und
> data via mmap.
>
> By now I workaround with a mixture of nanosleep/"time polling" (tra=
cking
> elapsed system time in a loop).  Is there a better way?

If you're waiting anyway, why don't you simply wait with poll?


Regards,
Clemens





-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
