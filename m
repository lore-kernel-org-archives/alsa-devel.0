From: AthlonRob <athlonrob@data.4t3.com>
Subject: Re: status pointer's problem with dmix.
Date: 27 Sep 2003 14:13:56 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1064697236.7563.7.camel@localhost>
References: <Pine.HPX.4.33n.0309201305480.16509-100000@studcom.urz.uni-halle.de>
	 <1064164006.15525.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1064164006.15525.6.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-09-21 at 10:06, AthlonRob wrote:

> I was unable to get the plug plugin working with the dmix plugin. 
> Seperately, they both worked (although the dmix only with very few WAV
> files).... but together, they didn't work at all.  They acted like the
> PCM was busy all the time, whenever audio was to be sent to them.
> 
> Is this dmix/rate bug they recently fixed... going to fix my problem
> above, or is it an unrelated bug?

I just upgraded to 0.9.7, which I would assume includes whatever patch
was provided to CVS to let dmix and rate play nicely together...

I wanted to report, I'm now able to use plug and dmix together, quite
nicely.  :-)

It gets a little shakey with a few streams running, but it's more than I
was expecting - sound events are now able to play while I listen to
stuff.  :-)

Thanks!

-- 
Rob                                |  If not safe,
   Jabber: athlonrob at axpr.net   |    one can never be free.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
