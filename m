From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Routing of channels, more than one output.
Date: Wed, 22 Mar 2006 12:29:19 +0100
Message-ID: <20060322112919.GB7675@turing.informatik.uni-halle.de>
References: <20060322014203.83101.qmail@web60816.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20060322014203.83101.qmail@web60816.mail.yahoo.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Tom Watson wrote:
> What I desire to do is by specifying a sound 'device' have the audio routed
> specially.  If I specify 'mono2' for example, I'd like my mono sound samples
> routed to BOTH the left and right speaker.

untested:

pcm.mono2 {
	type route
	slave {
		pcm "hw:42"    # or whatever ...
		channels 2
	}
	ttable.0.0 1
	ttable.0.1 1
}

> If I say 'stereo4' I'd like my stereo channels (sent with 'writei' calls)
> routed to both the front AND rear speakers.

pcm.stereo4 {
	type route
	slave {
		pcm "hw:42"    # or whatever ...
		channels 4
	}
	ttable.0.0 1
	ttable.1.1 1
	ttable.0.2 1
	ttable.1.3 1
}


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
