From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Sending divided Sysex events to the ALSA sequencer
Date: Tue, 14 Dec 2004 11:24:01 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0412141102340.15302-100000@studcom.urz.uni-halle.de>
References: <20041214063450.16768.qmail@web51901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041214063450.16768.qmail@web51901.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michael Geis <michaelgeis11@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Michael Geis wrote:
> The ALSA docu says Sysex events must be sent with a beginning 0xF0
> and a terminating 0xF7. Does that imply that divided Sysex
> messages must be converted to a single Sysex message and then be
> sent to the ALSA sequencer at once (otherwise they would not
> possess a terminating 0xF7)? Or is there still a way to send them
> to the sequencer as is, i.e. with none but the last of the
> messages having a terminating 0x0F.

The documentation is lying.  Just send each part as is, like I'm doing
in aplaymidi.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
