From: Bob Ham <node@users.sourceforge.net>
Subject: Re: guitar + sblive + ardour + ladspa effects
Date: 29 Jul 2002 22:25:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1027977926.10978.104.camel@insanity>
References: <E17ZHUa-0008M8-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17ZHUa-0008M8-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>, Ardour Devel Mailing List <ardour-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2002-07-29 at 21:53, Paul Davis wrote:

> you will also probably want to turn down the line-in level, so that
> the direct feed is not audible. that is also an sblive issue.

It's, unfortunately, the only issue :/

> >If it's not possible to this with only the sblive, I have the
> >motherboard's "soundcard" as well but how do I get jackd to deal with
> >more that one bit of hardware?  
> 
> jackd -d alsa -d hw:N
> 
> where N is the relevant card number for the motherboard audio
> interface.

Err.. I mean have *both* cards in jack.  I have a ~/.asoundrc with
"platinum51" and "via" devices defined.  I normally do "jackd -d alsa -d
platinum51".  Doing "jackd -d alsa -d platinum51 -d via" makes it only
use the via card.  How can I tell it to use both?

Bob

-- 
Bob Ham: bob@ham.org  http://pkl.net/~node/



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
