From: Lukasz Pawelczyk <havner@pld-linux.org>
Subject: How to stop playback on alsa synth?
Date: Sun, 16 Mar 2008 17:53:39 +0100
Message-ID: <47DD5093.6070702@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vega.livecd.pl (vega.livecd.pl [217.149.246.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 76F5D103804
	for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2008 17:53:30 +0100 (CET)
Received: from host-109-22.derby.waw.pl ([83.243.109.22])
	by vega.livecd.pl with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.67)
	(envelope-from <havner@vega.livecd.pl>) id 1Jaw1N-0004BW-Bo
	for alsa-devel@alsa-project.org; Sun, 16 Mar 2008 17:47:41 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

I'd like to ask how to completely stop playback using alsa synth.

Basically my program initialized output in the following way:

snd_seq_open()
snd_seq_set_client_name()
snd_seq_client_id()
snd_seq_parse_address()
snd_seq_create_simple_port()
snd_seq_connect_to()
snd_seq_alloc_named_queue()

Then I create a new thread that processes events.
It sets tempo and in infinite loop it does:
snd_seq_ev_set_fixed()
snd_seq_event_output()

This all is based on aplaymidi code.

How can I asynchronously immediately stop all the playback? Basicaly it 
requires breaking snd_seq_event_output() thats locked on my thread.
I tried everything I could come up with. I know very little about alsa 
synth programming and basically thats the only thing i need to do now.

Tried:
snd_seq_ev_set_queue_stop()
snd_seq_stop_queue()
snd_seq_remove_events()

or even closing the seq completely to reopen it on another file playback 
with:
snd_seq_stop_queue()
snd_seq_disconnect_to()
snd_seq_delete_simple_port()
snd_seq_close()

All failed, results were very various. I simply run out of ideas. It 
doesn't matter if the method would require to close seq or not. I just 
need to stop the playback so i can gracefully stop the thread and play 
another file (with eventual reopening ports/seq).

Would appreciate any help.

-- 
Regards    Havner                     {jid,mail}:havner(at)pld-linux.org
                    "Quis custodiet ipsos custodes?"
