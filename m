From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Query devices in a non-blocking fashion
Date: Mon, 8 Dec 2003 16:19:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031208161936.310df2cb.pochini@shiny.it>
References: <oprztqwoi4q1sf88@mail.broadpark.no>
	<200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: aknuds-1@broadpark.no, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 07 Dec 2003 14:19:28 -0500
Paul Davis <paul@linuxaudiosystems.com> wrote:

> i personally am heading towards believing that we made a design
> decision that was wrong here. i now tend to think that the PCM
> interface should not be involved with configuring the hardware at all,
> and that this should be left to the control API. when you open the PCM
> device, you get whatever is currently configured. if that's not what
> you want, you open the control API first, configure the device, then
> open the PCM device. i think this would be much much simpler for
> most application programmers (not as simple as JACK, but ...) and it
> would also mirror what happens in the windows world to some extent,
> where control applets are used to change aspects of the card config.
>
> still, its pretty much too late for that.

I don't agree. The control API (usually) is for things that don't affect
the way data is transferred between the card the the computer. Sample rate,
format, etc. are used to configure the hardware at the driver level, but
from the point of view of the application they are attributes of the
substream. The application has to take them into account. It can't just
open the PCM device and play/record something without knowing the format. So
you'll end up always using two different APIs to do the same things you now
can do with only one.


--
Giuliano.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
