From: AthlonRob <athlonrob@data.4t3.com>
Subject: Re: status pointer's problem with dmix.
Date: 21 Sep 2003 10:06:46 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1064164006.15525.6.camel@localhost>
References: <Pine.HPX.4.33n.0309201305480.16509-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0309201305480.16509-100000@studcom.urz.uni-halle.de>
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

On Sat, 2003-09-20 at 04:07, Clemens Ladisch wrote:
> AthlonRob wrote:
> > On Wed, 2003-09-17 at 11:52, Takashi Iwai wrote:
> >
> > > is it through the rate plugin?
> > > there was a bug about rate plugin together with dmix, which was fixed
> > > recently on cvs.
> >
> > Is the 'rate' plugin == the 'plug' plugin?
> 
> No. Yes.  ;-)  Well, the "plug" plugin uses the same code as the
> "rate" plugin when converting the sample rate.

I guess what I'm actually asking is....

I was unable to get the plug plugin working with the dmix plugin. 
Seperately, they both worked (although the dmix only with very few WAV
files).... but together, they didn't work at all.  They acted like the
PCM was busy all the time, whenever audio was to be sent to them.

Is this dmix/rate bug they recently fixed... going to fix my problem
above, or is it an unrelated bug?

-- 
Rob                                |  If not safe,
   Jabber: athlonrob at axpr.net   |    one can never be free.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
