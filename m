From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: re: CS4281 fixes (2nd try) (fwd)
Date: Mon, 19 Aug 2002 19:50:14 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208191942420.8042-100000@aino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vaino.wakkanet.fi (vaino.wakkanet.fi [212.83.117.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA24888
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 19:10:57 +0200
Content-ID: <Pine.LNX.4.44.0208191942422.8042@aino.wakkanet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

After doing a cvs update and recompiling and reinstalling the driver
package, snd-cs4281 now freezes my ibm-x20 laptop (rh7x, kernel 2.4.16,
today's ALSA-CVS). 0.9.0rc1 works fine. Anyone with similar experience? I
didn't get any debug info as the system freezes up completely and I don't
have time to debug it more now, but I'm willing to try out changes if need
be. This regression might be related to the below recent patch set.

And another cs4281 mystery: with 0.9.0rc1 the record wakeup is constantly
late. Even though I've set avail_min to x frames, upon wake-up there's
continuously more than y*x frames available (ie. not just a few samples).
This is not a scheduling issue as the playback direction works fine (if
not counting system load spikes, there's always ~avail_min of data
available).

-----Original Message-----
From: ext Sander van Leeuwen [mailto:sandervl@xs4all.nl]
Sent: 08 August, 2002 13:38
To: alsa-devel@lists.sourceforge.net
Subject: [Alsa-devel] PATCH: CS4281 fixes (2nd try)


Changelog:
- Added suspend/resume support; works fine for wave; FM sounds strange
   after a resume if you previously used it. Not sure why.
- Increased loop delays during init to prevent detection failures
- Move card init code to seperate procedure since resume needs it too
- Fixed snd_cs4281_pointer; returned wrong position resulting in
  many clicks during wave playback and recording
- Leave wave playback FIFO enabled or else FM will not be audible
  (unless wave playback is active)
- Added mixer control for FM volume
- Added SNDRV_PCM_IOCTL1_SETVOLUME/SNDRV_PCM_IOCTL1_GETVOLUME
  to control the volume of wave streams
  (AC97 PCM affects both FM & wave; see crystal docs)
  Use it if you wish. I've added a similar ioctl to the ported SB Live driver to control
  the volume of each individual wave stream. (since I found no other way to do that)
  (some header updates are missing; if you want them, let me know)

The attached source file isn't up to date with the latest CVS. All my changes are marked by
#ifdef TARGET_OS2.





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
