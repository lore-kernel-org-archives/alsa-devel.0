From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: question regarding latest CS4205 laptop    soundcard driver
Date: Tue, 26 Feb 2002 21:26:26 -0500
Message-ID: <a5hge7$7mq$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.44.0202261636480.19581-100000@sasami.anime.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Dan Hollis' <goemon@anime.net>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > P.S. What about Yamaha/Intel 753 chip that is found in the Toshiba
> > Satellite 5005's?
> 
> All yamaha 75x should be supported with the alsa 'ymfpci' driver.

Yes, but does it include hardware mixing?

I do not mean to be hammering this issue into the ground, but Linux OS
as an audio workstation solution has been around for 3 years now, yet
the only soundcard I am aware of that is capable of doing hardware
mixing is SBLive!, and even that one is due to fact that Creative had
their hands in the driver devel.

So my question is since this problem of not being able to open /dev/dsp
(or audio or whatever you desire to call it) more than once (i.e. only
one app can "hog" the audio at one time) is the case with most of the
Linux audio hardware, why is there no solution as of yet to have a
kernel-implemented software mixing of multiple audio streams, so that
the soundcard can be queued from multiple apps/processes? (I am
mentioning kernel implementation, since my guess is that it would
provide better latencies for such stuff) I am involved heavily in
electroacoustic and multimedia projects/composition and am a huge Linux
enthusiast, but am seriously growing tired of this roadblock which I
have to worry constantly about when working on my project(s)/piece(s).

Yes, I know, there are some efforts of implementing workarounds for
this, but none of them are universal:

*There is esd, which is outdated and simply crappy.
*There is artsd, which is better, but not good enough, and again, the
app must be made to be aware of it in order to utilize it.
*There is JACK project which has a huge potential but none of its
effects are again universal, nor backwards-compatible with already
released software.
*There is Gstreamer, but I do not honestly know enough about it.

I am sure there are more. Yet, no viable solution has been provided
despite the fact that even Beos had this solved, needless to mention Mac
and Win os's which do this flawlessly.

So my final question is, is there even any effort being put into solving
this issue in an universal fashion where software mixer would be
transparently intercepting calls to dsp resources (both input and
output) and made them available to any process that requested access to
them, mixing audio output audio streams as needed, while dispatching
audio input streams to as many processes that required input stream?

Now that Alsa has become "default" kernel driver, we should definitely
try to use the opportunity to finally provide this rudimentary, yet
extremely important aspect of audio system.

I overheard that the new 2.5.x kernels have multiplexing feature (which
I am guessing enables sharing of the dev resources -- please correct me
if I am wrong), if so, will this solve this issue?

Any thoughts/news on this issue would be utmostly appreciated!
Sincerely,

Ico




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
