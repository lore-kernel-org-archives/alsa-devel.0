From: Richard Bown <bownie@bownie.com>
Subject: ALSA sequencer input buffer
Date: Thu, 25 Apr 2002 13:08:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204251211.AFT92055@msgdirector2.onetel.net.uk>
References: <Pine.LNX.4.44.0204241639410.10208-100000@volamar.theswamp.priv>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0204241639410.10208-100000@volamar.theswamp.priv>
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

Hi,

Is it correct that an app should have to snd_seq_drop_input_buffer() every
so often when reading events in via snd_seq_event_input()?

If I don't drop the input buffer periodically then the input buffer appears
eventually to clog up - only allowing a few events through at a time.  Whilst
the number of events received by the app becomes severely limited it still
just about continues to work.  Is there an easy explanation for this behaviour?

Am I doing the right thing in dropping the buffer?  It certainly appears to
fix the problem.

Cheers,
Richard
-- 
http://www.all-day-breakfast.com/rosegarden
http://www.bownie.com
