From: "Ivica Ico Bukvic" <ico@fuse.net>
Subject: RE: [Alsa-devel] dxs_support and via82xx (yet once more) -- some new findings
Date: Sat, 24 Apr 2004 14:02:32 -0400
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20040424180235.XUEA26114.smtp2.fuse.net@64BitBadass>
References: <s5hisfqmxkp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5hisfqmxkp.wl@alsa2.suse.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> yes, the module name still consists of snd- prefix.
> the snd_ prefix was dropped from the module OPTIONS.
> (e.g. dxs_support would have been named as snd_dxs_support in the old
>  versions.)

Oh, I see now. Thank you very much for explaining that.

Now, when I do put in an option into the modules.conf specifying a different
dxs mode, am I still supposed to get the same message in my syslog about
picking trying dxs=1 or 4 or does that message show up only when no options
have been successfully parsed?

I am asking this since even when I am 100% sure that my syntax is/was ok I
would still get the message no matter what option was specified in
modules.conf. I tried hacking via82xx.c file where I would hardwire my
vendor/card ID into the list of known cards and changing it that way and the
card worked the same no matter which options I chose, so I decided to leave
it at DXS_ENABLE (or 1 if I am not mistaken). This is the only way how I
would disable that message from appearing in syslog.

What kind of difference am I supposed to notice by changing dxs in order to
figure out the best option anyhow?

As it is right now I can play 4 simultaneous streams and they all sound ok
(no apparent glitches etc.). But this is the case no matter which option I
pick.

> BTW, i assume that are you using 2.4 kernel.  is it right?

No, I am working with 2.6.3 and 2.6.5 (both patched).

Finally, I've observed one extremely interesting phenomenon. I did notice
that when compiling preemptive versions of these kernels that I get tons of
xruns even when using aplay talking directly to hw:0. I literally need at
least buffer of 512 for aplay to play ok. I also noticed that certain
applications (i.e. frozen-bubble) would play stuff a bit faster than they
ought to be played (although I am not sure whether this is linked to a
particular alsa driver version or the preempt stuff).

With preemptive flag disabled, everything seems to be ok. 

Best wishes,

Ico




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
