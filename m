From: Lee Revell <rlrevell@joe-job.com>
Subject: querying card properties
Date: Sat, 08 Jan 2005 16:52:24 -0500
Message-ID: <1105221144.24592.107.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

In a recent LAU thread it came to light that some (all?) distros alsa
setup scripts don't configure dmix when the card is known not to support
hardware mixing.  The end result is the user has to edit config files to
get software mixing to work.  On a modern distro this is a BUG.

Is there an API function to detect whether hardware mixing is supported?
Also useful would be a way to detect codecs with no hardware volume
control, so the softvol plugin can be set up.

I know there are hacks like comparing the number of streams to the
number of substreams, but what's the right way?

Lee






-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
