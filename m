From: "r10 kindsofpeople" <r10kindsofpeople@hotmail.com>
Subject: stopping sequencer output queue gracefully
Date: Thu, 14 Dec 2006 08:12:29 -0600
Message-ID: <BAY21-F222A395293750A95AC6FE3CDD50@phx.gbl>
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

Is there example code around that shows how to stop MIDI playback 
gracefully?

At present, I'm doing a snd_seq_drop_output() and a snd_seq_stop_queue(), 
and getting some interesting behavior when I try to restart.

I'm also wondering if Alsa does anything to track or handle the stuck notes 
that result, or if my client needs to be responsible for tracking these and 
turning them off before stopping the queue.

John

_________________________________________________________________
Talk now to your Hotmail contacts with Windows Live Messenger. 
http://clk.atdmt.com/MSN/go/msnnkwme0020000001msn/direct/01/?href=http://get.live.com/messenger/overview


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
