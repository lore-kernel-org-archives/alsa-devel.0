From: <ico@fuse.net>
Subject: Weird xruns in via82xx+ 2.6.x kernels/ via82xx+jackd/ and what is dxs_support
Date: Thu, 22 Apr 2004 2:12:29 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040422021229.TBVL4748.smtp1.fuse.net@smtp.fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
Cc: ico@fuse.net, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

Hi all! (I posted this a while ago using a different account but it never went through so here it is again :-)

Two questions:

1) when using via82xx driver the sound using aplay sounds choppy, faster than usual, and has xruns (???) even when using a simple aplay command on a wavefile.

syslog suggests using something called dxs_support=1 or 4 but even if I put this into my /etc/modules.conf it still does nothing and syslog continues to suggest the same thing.

Does anyone know where am I supposed to put this statement in order for it to work? Please be as verbose as possible. Thanks!

The sound sounds fine when using "play" though and there are no xruns.

2) when trying to use jackd and via82xx as a regular user it always starts up does not report any errors but qjackctl complains that it could not connect to the jack and when starting it on command prompt it starts without any apparent errors but when trying to connect to it using for instance jack_metro it says "is jack running?" or something similar. Now, when I do the same as a root, it works like a charm. Any ideas why is this?

Any help on these issues would be greatly appreciated!

Best wishes,

Ico



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
