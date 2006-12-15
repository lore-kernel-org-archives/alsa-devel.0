From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: stopping sequencer output queue gracefully
Date: Fri, 15 Dec 2006 08:30:54 +0100
Message-ID: <1166167854.20860.280597815@webmail.messagingengine.com>
References: <BAY21-F222A395293750A95AC6FE3CDD50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <BAY21-F222A395293750A95AC6FE3CDD50@phx.gbl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: r10 kindsofpeople <r10kindsofpeople@hotmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

r10 kindsofpeople wrote:
> Is there example code around that shows how to stop MIDI playback 
> gracefully?
> 
> At present, I'm doing a snd_seq_drop_output() and a snd_seq_stop_queue(), 
> and getting some interesting behavior when I try to restart.

What do you mean with "interesting"?

After snd_seq_stop_queue(), you have to call snd_seq_drain_output() to
actually send the stop event.

> I'm also wondering if Alsa does anything to track or handle the stuck notes 
> that result, or if my client needs to be responsible for tracking these and 
> turning them off before stopping the queue.

A queue is just a tool for delivering events; ALSA doesn't try to
interpret the events sent through it.  Besides, different devices may
have different rules about sending of note-on/note-off events.

I'd just send an All Notes Off message.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
