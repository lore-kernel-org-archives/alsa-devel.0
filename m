From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Hammerfall DSP System Problems
Date: Tue, 10 Jun 2003 13:02:57 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGCECJCHAB.mknecht@controlnet.com>
References: <20030610183131.76A8A3EFBF@vivaldi.controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030610183131.76A8A3EFBF@vivaldi.controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: frankgaetano@collegeclub.com, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> >
> >Later that evening I powered down. Upon rebooting the next morning it
> >failed, and has failed ever since. That was last Thursday evening.
>
> the same thing happened to me a week ago. i have, as usual, not had
> time to investigate further.
>

Well, it is actually quite comforting to know that folks with far more
experience than I sometimes see the same strange behaviors!

> >
> >This whole Alsa/HDSP thing is amazingly weird...
>
> at the moment, i regret that we made the move to user-space loading of
> the "firmware" when we did. i think now that it was a mistake to do it
> at that time. it has caused a fundamental change in the way the driver
> sets up, but it came at a time when we weren't confident that setup
> was working for various cases.

I'm sure that it will get worked out. I think Joshua is currently having
some good successes with the HDSP 9652, and I'm currently learning how to
modify a Gentoo ebuild to accomplish doing a patch. I also have (after more
pain than I wish to recount) Windows on this Gentoo box in a dual boot
config, and have the RME firmware tools to upgrade and downgrade, so I think
I'm almost set to be able to try this stuff out again.

I'm sure over the next few weeks and months this will get straightened out.
:-)

Mark




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
