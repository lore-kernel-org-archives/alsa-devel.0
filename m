From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Omnistudio USB
Date: Wed, 12 Jan 2005 10:02:40 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0501121001170.22429-100000@studcom.urz.uni-halle.de>
References: <1105506803.14697.8.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1105506803.14697.8.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rusty Phillips <rustyp@freeshell.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Rusty Phillips wrote:
> I recently purchased one, and have been trying to find out
> anything I can about getting it to work.  So far all I've gotten
> is playback on two channels at 48Khz with alsa (from the 2.6.10
> kernel as well as from alsa CVS).

What are the contents of /proc/asound/cardX/stream0?
Is there a second output device in the output of "aplay -l"?


Clemens



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
