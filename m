From: Steven Walter <srwalter@yahoo.com>
Subject: Sound distortion on cm8738 with 0.9.0rc1 and beta12
Date: Mon, 20 May 2002 15:39:32 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020520203932.GA23691@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Resent-To: alsa-devel@lists.sourceforge.net
Resent-Message-Id: <E17AgDq-0000bB-00@hapablap.dyn.dhs.org>
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

Those are the only two version that I have tried so far.  This problem
is a recent one however.  It exhibits itself when playing a DVD movie
(The Matrix, region one) with xine.  I have spoken to a xine developer,
and he was of the opinion that it was an ALSA problem, not a xine one.
So I am reporting this here.

During the beginning Warner Bros. logo clip, the sound has a
helicopter-effect going on (you hear the sound, but broken up by a
whop-whop-whop-whop noise).  This stops once the DVD menu is reached,
but begins again for the actual movie.

There are a few interesting differences between the clips that do and
don't work.  The one's that do not work on 4 channel, and use a buffer
size of 8192 bytes.  The one that does is only 2 channels, and has a
buffer size of 16384.  Is it possibly that there is a bug (hardware or
software) in the usage of this small buffer size?

If I tell xine not to use four-channel sound, the two problematic clips
sound perfect.  However, they are then played as 2 channel clips, again
with the 16384 buffer size.

Four channel playback did work at one time.  Possibly in the beta10 era.
If there is interest, I will try reverting to this version, and testing
for the problem there.  Any assistance is appreciated.  Thanks
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
