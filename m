From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: aoss failures under Alsa-1.0.0rc1
Date: Fri, 05 Dec 2003 18:06:48 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312051804500.8570-100000@studcom.urz.uni-halle.de>
References: <NDBBLGIKBJENLAMOLFHGIEHIECAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <NDBBLGIKBJENLAMOLFHGIEHIECAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
> I didn't see an announcement, but the Alsa page now shows 1.0.0rc2. Are you
> suggesting that this might actually have been fixed in rc2? If so, what was
> the cause?

There is a change in alsa-oss.c, immediately after rc1 came out, with
the following log message:

- avoid the assert in snd_pcm_drain().
- fixed the possible segfault at the wrong release of resources.
- more debug messages.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
