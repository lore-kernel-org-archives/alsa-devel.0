From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: status pointer's problem with dmix.
Date: Sat, 20 Sep 2003 13:07:27 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309201305480.16509-100000@studcom.urz.uni-halle.de>
References: <1063937855.6201.2.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1063937855.6201.2.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: AthlonRob <athlonrob@data.4t3.com>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

AthlonRob wrote:
> On Wed, 2003-09-17 at 11:52, Takashi Iwai wrote:
>
> > is it through the rate plugin?
> > there was a bug about rate plugin together with dmix, which was fixed
> > recently on cvs.
>
> Is the 'rate' plugin == the 'plug' plugin?

No. Yes.  ;-)  Well, the "plug" plugin uses the same code as the
"rate" plugin when converting the sample rate.


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
