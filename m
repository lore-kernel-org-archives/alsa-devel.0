From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA and select, poll, ... (interrupted system calls)
Date: Wed, 23 Jun 2004 12:15:04 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406231146080.4564-100000@studcom.urz.uni-halle.de>
References: <E1Bd2aI-0003gd-00@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <E1Bd2aI-0003gd-00@mailer.emlix.com>
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
>
> On Tue, 22 Jun 2004, Clemens Ladisch wrote:
>
> > Then don't enable async signals.  Or do you need them for some ot=
her
> > reason than waiting for interesting events?
>
> Depending on the configuration I have a callback registered via
> snd_async_add_pcm_handler function. This enables the async signals.=
 My
> code relies on that 'callback functionality'.

SA_RESTART is said to make "certain" system calls restartable over
signals. ALSA already uses this, so it seems it doesn't work in your
case.

> But perhaps it's possible to turn async signals off temporarily
> before entering a sleep/poll/whatever and switch them on again
> afterwards?

fcntl(F_SETFL) can reset the O_ASYNC flag of the file descriptor
returned by snd_async_handler_get_fd().


HTH
Clemens





-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
