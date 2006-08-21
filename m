From: Tom Watson <sdc695@yahoo.com>
Subject: Sample rate errors (sample rate conversion quality) in
	ALSA
Date: Mon, 21 Aug 2006 11:08:55 -0700 (PDT)
Message-ID: <20060821180855.74467.qmail@web60813.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Aug 2006 16:03:38 +0100, John Rigg wrote:
> On Mon, Aug 21, 2006 at 03:02:07PM +0200, Marc Brooker wrote:
> > Let me see if I understand you correctly. In the scenario that you
> > presented the application is told that there are 940 samples per
> > period. ALSA, internally, converts these to 1024 samples per period at
> > 48kHz sample rate. So the material (sampled at 44100Hz) is played back
> > at a rate of 44062Hz? I don't know enough about the field to know if
> > this error (0.08%) will be audible.
> 
> To put that in perspective, a semitone is around 6% change in pitch.
> The error here looks small at 0.08% but it's enough to make a musical
> note sound out of tune.
> 
> John

Yes, you can hear the small differences in pitch, even an "untrained" ear.

It turns out that while few people have "absolute perfect pitch", most of
the general public has "relative perfect pitch".  This means that if one
can compare things, it can be easily detected as being "off".  The motion
picture industry found out about this LONG ago, when "talkies" started.  In
the "silent" days, the film speed varied considerably when "sampled" (the
film was exposed).  The rate was highly dependent on the operators skill
of maintaining a consistent crank speed.  When projected, the human eye
can easily interpolate and "gloss over" small differences in the frame
speed.  Not so in audio.  The recording of audio and its reproduction
need to be very precise, or the audience will detect the SLIGHTEST difference
in pitch from "norm".  They won't know exactly how to correct it, but
it will be perceived as being "bad".

>From this, it was extrapolated that one could compress (with loss) more
in the video area, than the audio area, and get results that are
"acceptable" to the general public.  Compression in general is not good,
but that is another topic for great debate.

Experiment to try (if you have the equipment):
Record on a reel-reel recorder a song, then playback the same song and see
how much you can alter the speed (thumb on capstan) before you can hear
a difference.  You will be surprised at the results.

We now return you to your regularly scheduled mailing list to discuss
further sample rate conversion software.  :-)

-- 
Tom Watson
tsw@johana.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
