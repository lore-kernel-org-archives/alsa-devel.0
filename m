From: Mark Knecht <markknecht@comcast.net>
Subject: Re: After warm boot Alsa not detecting sound card
Date: Mon, 03 Nov 2003 17:52:34 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1067910754.2615.18.camel@Wizard.knechthome.com>
References: <1067832822.2011.8.camel@Wizard.knechthome.com>
	 <1067893471.24188.135.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1067893471.24188.135.camel@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-11-03 at 13:04, Fernando Pablo Lopez-Lezcano wrote:

> It _is_ strange that the alsa usb modules are also loaded...

It seems to be used when I make MIDI connections with aconnect to make
MIDI connections. The usage count jumps up.

I looked at your alsasound script (from /etc/init.d) and the Gentoo one.
They are *very* different. I think for the short term I'll just stop and
start alsa by hand, maybe in a sudo script or something, until I get
some time to really think about this stuff. 

Or possibly you're comments will start a discussion that leads to a
better script. Why wouldn't this be better for Alsa to be in CVS?

Thanks!

Cheers,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
