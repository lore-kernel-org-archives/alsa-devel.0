From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: hw_rule
Date: 10 May 2003 11:59:45 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052567986.1226.8.camel@Jay>
References: <1052435969.2728.15.camel@Jay>  <s5hbrycb3fk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrycb3fk.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, paul@linuxaudiosystems.com
List-Id: alsa-devel@alsa-project.org

On ven, 2003-05-09 at 14:27, Takashi Iwai wrote:
> > - How many stupid bugs are there ? :)
>
> i see only subtle issues.
> it's better to use snd_interval_any() instead of memset().
> the resultant interval_t would accept all values.

Done, tnx.

rme9652.c::snd_rme9652_hw_rule_*() functions do not initialize the
structures. They may fail, unless I'm missing something.

> the constraint for the another direction would be needed, too,
> that is, the constraint for the channels which checks the acceptable
> formats from the current values.

Yes, of course.


Bye.




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
