From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: LiveDrive MIDI
Date: Wed, 10 Dec 2003 09:16:27 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312100912590.5603-100000@studcom.urz.uni-halle.de>
References: <S19912AbTLIUCX/20031209200223Z+9280@nic.funet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <S19912AbTLIUCX/20031209200223Z+9280@nic.funet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juhana Sadeharju <kouhia@nic.funet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Juhana Sadeharju wrote:
> >From: Eckhard Jokisch <e.jokisch@u-code.de>
> >>
> >> Now we should look at why LiveDrive "midi-in" does not work.
> >
> >As far as I remeber it worked half a year ago.. no?
>
> Another person with LiveDrive said it does work, but
> it does not work for me.

ALSA's emu10k1 entry says "MIDI on SB live drive not working properly"
is a known bug.

> I have Alsa 1.0.0pre3. I tested with
>   amidi -d -p hw:0,0
> but nothing was read in (hw:0,1 and hw:0,2 were available as
> well with the same result; no other devices were available).
>
> Would anyone would like to tell the simplest way to test the
> midi-in port?

The above amidi command is right. (The other ports should work if
there is something connected to them.)


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
