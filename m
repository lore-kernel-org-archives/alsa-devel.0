From: tom burkart <alsa@aussec.com>
Subject: Re: Major problem with the current alsa mixer.
Date: Mon, 15 Sep 2003 21:26:13 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309152112400.1554-100000@home.aussec.com>
References: <s5hd6e63sbq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6e63sbq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sep 12, Takashi Iwai wrote:

> > >>Zero as a minimum value is not very meaningfull in audio terms. With a
> > >>mixer, the zero dB point is probably more use. The minimum value of a
> > >>slider should be the equivalent of mute, so I think that instead of a
> > >>minimum value, it should display "mute" for the user.
I don't believe this is a good idea.  In "live audio" you tend to have
mute groups and other advanced features that must be activated by a button
press rather than when the slider reaches the minus infinity (dB) point.

> > >>The user should be able to reduce the volume, and if they hit the
> > >>minimum, mute automatically becomes active, but if they increase the
Same comment as above.

> > >>volume again, mute automatically is disabled. I am thinking about the
> > >>way a TV volume/mute control works. If one is muted, turning volume up
> > >>or down automatically un-mutes the sound. This programming could
> > >>probably be done at the application level, but I think that as so many
> > >>people would want it that way, it should maybe move to alsa-lib.
Do you really want this to be a fancy "HiFi" system or potentially a
professional console?  I have no problem of two different APIs being
implemented in some library but I really wish not to be "forced" into
either.


> > So, if we can agree on how the mixers will behave consistently in the
> > application. I prefer the dB range myself, with 0 dB or -3.4 dB meaning
Agree.

> > the same thing for all sound cards, and minimul volume causing a "mute"
> > to happen. (I think most TV and HiFi's work that way)
That may well be so but disagree.

> > If a user has two different sound cards, the same mixer value on both
> > cards should give the exact same volume out of the speakers.
That should be the goal, implementation may differ somewhat.
On the other hand a flat 1-2 dB difference most people cannot even tell.


> therefore, we shouldn't put this into the drivers but solve on
> the user-space as much as possible.
Definitely agree.

tom.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
