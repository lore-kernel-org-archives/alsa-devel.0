From: Carlo Wood <carlo@alinoe.com>
Subject: ViaVoice or ALSA bug?
Date: Wed, 9 Jul 2003 17:43:41 +0200
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20030709154341.GA7479@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-user-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net, xvoice@yahoogroups.com
List-Id: alsa-devel@alsa-project.org

Dear ALSA developers,

Ok, I fixed the previous problem; now running the
latest kernel + latest modules (and alsa 0.9.4).

The REAL problem I have is the following:

Recording has always been extremely hard to impossible
with linux - one of the applications that I REALLY
cannot get working is the speech recognition tool of
IBM: ViaVoice.

I downloaded the commercial sound drivers from Front4
and with that it works perfectly.  In the past I've also
got this to work with the OSS/Free stuff.

However... with ALSA, it has never has worked; and I've tried
a lot of things :(.

I can't see this anymore being anything else but a bug
in ALSA.  The problem however is to find WHY it doesn't
work (and then fix it).

I'd like to get some guidance with that.

My setup is as follows:

1) It works (recording speech with microphone) when using
   the Front4 commercial sound drivers.
2) With ALSA, playback works and I hear myself back over
   the speakers when I talk into the microphone.  I even
   can let it 'sing around' by capturing Mic (of course) and
   turning on max. "AC97" and "Capture == Igain".  Also
   "AC97 Capture" was set to the maximum.  In fact, I turned
   EVERYTHING on to the maximum with alsamixer, unmuted
   everything and captured Mic [1]... No recording.

I am willing to get to the bottom of this, but I am out
of ideas right now :/

Please help.

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
