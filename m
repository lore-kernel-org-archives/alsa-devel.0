From: Rusty Phillips <rustyp@freeshell.org>
Subject: Re: Omnistudio USB
Date: Wed, 12 Jan 2005 15:50:02 -0500
Message-ID: <1105563002.14697.45.camel@localhost>
References: <Pine.HPX.4.33n.0501121001170.22429-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0501121001170.22429-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Okay, I've been trying most of my testing with the first two channels.

However, I just figured out that recording and playback works on
channels #3 and #4 at 96000.

The first two are the best ones to get, though, because those are the
ones with built-in preamps and XLR inputs.  Note that even bypassing the
preamps by going directly through the line-ins doesn't work, though.

Clues?

On Wed, 2005-01-12 at 10:02 +0100, Clemens Ladisch wrote:
> Rusty Phillips wrote:
> > I recently purchased one, and have been trying to find out
> > anything I can about getting it to work.  So far all I've gotten
> > is playback on two channels at 48Khz with alsa (from the 2.6.10
> > kernel as well as from alsa CVS).
> 
> What are the contents of /proc/asound/cardX/stream0?
> Is there a second output device in the output of "aplay -l"?
> 
> 
> Clemens
> 




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
