From: Alan Jenkins <aj504@student.cs.york.ac.uk>
Subject: Re: SiS 7012 with snd_intel8x0 is silent
Date: Mon, 10 Jan 2005 11:16:21 +0000
Message-ID: <1105355781.10455.53.camel@localhost>
References: <1105049276.12514.11.camel@localhost>
	 <1105105972l.10186l.0l@localhost>  <s5h3bxdw4az.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3bxdw4az.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Problem sorted; it was a mixer configuration issue.  The kernel update
added new controls, the default values of which did not work with my
setup.  I can send you the settings which worked if you like.

I think some more effort needs to go into intuitive mixer design and
documentation - My card has 40 controls and I'm damned if I know what
all of them do.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
