From: "Sam" <4l8uie002@sneakemail.com>
Subject: Re: Please add snd-ice1712 problem to "Known bugs"
	page
Date: Wed, 10 Sep 2003 13:17:33 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <7616-64105@sneakemail.com>
References: <200309101206.h8AC6xW9005709@oud>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309101206.h8AC6xW9005709@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-09-10 at 05:06, Paul Davis wrote:
> although it makes me happy to see you feeling this way, i felt
> compelled to add that i'm not necessarily sure that the linux way *is*
> better. its more flexible, that's true. but the two different
> standards for "input maximum signal level" are just that - standards -
> and the fader to control this makes it much harder to switch between
> the two levels that all of my equipment uses.

This is a good point.  Maybe my sound problem is only my poor skill at
setting the output signal level appropriately.

Chances are M-Audio put some thought into the +4dBu,
Consumer, and -10dbV presets.  Does anyone know how we could map these
to the corresponding 7 bit values?  I could probably patch envy24control
to add analog signal presets so we could have the best of both features.

Sam




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
