From: Rusty Phillips <rustyp@freeshell.org>
Subject: Re: Omnistudio USB
Date: Fri, 14 Jan 2005 15:07:05 -0500
Message-ID: <1105733225.1897.37.camel@localhost.localdomain>
References: <Pine.HPX.4.33n.0501141230020.25187-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0501141230020.25187-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Excellent work, and great turnaround!  Not only did that fix the problem
I was having with the first two channels, but now that part of the card
works in full duplex mode!

This means that I have now gotten all the functionality that the card
offers - I can do 4x2 or 2x4 capture/send with Jack.

The only claimed functionality that is missing is sending on 3 and 4
while capturing on 1-4 (in other words, using channels 3 and 4 in full
duplex mode.  I couldn't even get this to work in windows...it could be
a physical limitation (does the Quattro have this problem?)

Strangely, each input channel is returning a different gain even with
the same settings.  Also, the preamps are absolutely horrible.  If
anyone is thinking of purchasing this thing because it of the built-in
mixer functionality, don't.

On Fri, 2005-01-14 at 12:34 +0100, Clemens Ladisch wrote:
> Rusty Phillips wrote:
> > Okay, I've been trying most of my testing with the first two channels.
> >
> > However, I just figured out that recording and playback works on
> > channels #3 and #4 at 96000.
> 
> The first two channels use an additional 16-bit interface, probably
> for compatibility with the Windows USB Audio driver.
> 
> Please try the patch below.
> 
> 
> HTH
> Clemens
> 
-- 



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
