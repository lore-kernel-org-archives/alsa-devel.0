From: Richard Bown <bownie@bownie.com>
Subject: timestamps on recorded events
Date: Thu, 11 Apr 2002 10:42:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204110944.AFK42109@msgdirector2.onetel.net.uk>
References: <Pine.LNX.4.33.0204091221050.7128-100000@wotan.suse.de>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0204091221050.7128-100000@wotan.suse.de>
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

Hi.  Another simple one but another one I'm afraid I can't find an example for.

I'm writing and reading events from the same ALSA 0.9.0 port (on the same
duplex handle) - I receive the events correctly through snd_seq_event_input
but the timestamps are coming back as zero even when I've started a queue
against that handle.  I presume I don't have to extract the timestamps from
the queue itself?

Thanks,
Richard
-- 
http://www.all-day-breakfast.com/rosegarden
http://www.bownie.com
