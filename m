From: Dan Hollis <goemon@anime.net>
Subject: RE: question regarding latest CS4205 laptop    soundcard
 driver
Date: Tue, 26 Feb 2002 19:09:36 -0800 (PST)
Message-ID: <a5hjea$9j7$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <000001c1bf36$280ec3c0$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Feb 2002, Ivica Bukvic wrote:
> > > P.S. What about Yamaha/Intel 753 chip that is found in the Toshiba
> > > Satellite 5005's?
> > All yamaha 75x should be supported with the alsa 'ymfpci' driver.
> Yes, but does it include hardware mixing?

Yes it does.

> So my question is since this problem of not being able to open /dev/dsp
> (or audio or whatever you desire to call it) more than once (i.e. only
> one app can "hog" the audio at one time) is the case with most of the
> Linux audio hardware, why is there no solution as of yet to have a
> kernel-implemented software mixing of multiple audio streams, so that
> the soundcard can be queued from multiple apps/processes?

Because kernelspace is the wrong place to do audio mixing. IIRC the 
problem was solved by userspace libraries and LD_PRELOAD which intercept 
calls from badly-behaved-oss-applications and manage mixing in userspace. 
Although I haven't tried this yet.

> *There is esd, which is outdated and simply crappy.
> *There is artsd, which is better, but not good enough, and again, the
> app must be made to be aware of it in order to utilize it.
> *There is JACK project which has a huge potential but none of its
> effects are again universal, nor backwards-compatible with already
> released software.
> *There is Gstreamer, but I do not honestly know enough about it.

Then make them better.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
