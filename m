From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: OSS midi emulation bug: 1.0.0pre3
Date: Tue, 02 Dec 2003 11:42:32 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312021137010.10104-100000@studcom.urz.uni-halle.de>
References: <200311302308.hAUN8w423494@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200311302308.hAUN8w423494@turbo.physics.adelaide.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jonathan Woithe wrote:
> Under Jazz++, any "hold on" controller event which occurs within the first
> bar played gets turned off too quickly (assuming playback starts at beat one
> of a bar).  In fact, even if there are no subsequent "hold off" events
> within the entire midi file the "hold on" is still turned "off".  The
> turning off happens very soon after the "hold on" is transmitted - the "hold
> on" has some effect but it's very short lived.

Apparently, an Active Sensing message is being sent at the start of
the file.  ALSA sends one when a rawmidi port is closed, but I don't
know why this should happen at the start of the file.

Does this still happen when you use aconnect to connect some dummy
port (e.g. 0:0) to your sound card's output port before starting
Jazz++?


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
