From: Joshua Haberman <joshua@haberman.com>
Subject: Re: PCM API questions
Date: Mon, 24 Jun 2002 09:57:34 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020624165734.GA11051@reverberate.org>
References: <s5hptyg96f0.wl@alsa2.suse.de> <200206241415.g5OEFkf09744@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200206241415.g5OEFkf09744@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

* Paul Davis (pbd@op.net) wrote:
> >the names above are not defined on all cards (except for default).
> >i think we need a kind of config database for each card.
> >this is useful not only for pcm but also for parsing the mixer
> >structure.
> 
> i think this is the wrong solution. i believe the correct solution is
> to provide a **simple** way to get every defined PCM device name.

I agree.  I also think its important that users can do basic things
(stereo in and out) with any physical card in their system without having
to touch ~/.asoundrc.

The complexity of ~/.asoundrc configuration is apparently necessary to
accommodate the high-end: people using one or more professional
multichannel cards.  That's fine, but now that ALSA is in 2.5 there are
going to be a hoarde of basic users who want to run XMMS and watch DVDs.
They will want it to just work, and if it doesn't work they'll come and
flood your mailing lists and proclaim that ALSA sucks because it can't
even do basic things.

Maybe this is what the "default" device is intended for, but can it
accommodate more than one card?  I happen to have a sound card built into
my motherboard and another in a PCI slot -- how do I tell XMMS which one
to use?

Don't take my comments the wrong way: I'm glad to know that ALSA was done
the right way and can scale up to multiple multichannel cards.  I just
hope that it can also be a good fit for basic, stereo-only users.

In this same line of thought, I still have no idea what half the channels
alsamixer shows me correspond to, nor why my digital CD input is labelled
"IEC958 TTL" (I discovered this via guess and check).

Josh


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
