From: Lukasz Pawelczyk <havner@pld-linux.org>
Subject: Re: How to stop playback on alsa synth?
Date: Sun, 16 Mar 2008 22:48:25 +0100
Message-ID: <47DD95A9.30606@pld-linux.org>
References: <47DD5093.6070702@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vega.livecd.pl (vega.livecd.pl [217.149.246.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 017D8246E2
	for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2008 22:48:14 +0100 (CET)
Received: from host-109-22.derby.waw.pl ([83.243.109.22])
	by vega.livecd.pl with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.67)
	(envelope-from <havner@vega.livecd.pl>) id 1Jb0cZ-0006Mc-WD
	for alsa-devel@alsa-project.org; Sun, 16 Mar 2008 22:42:24 +0100
In-Reply-To: <47DD5093.6070702@pld-linux.org>
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

I think I've done it, just don't know how correct my solution is

I've added snd_seq_drain_output() after snd_seq_event_output() in thread 
function so the events are processed more "real time" as I understand 
it. I've also moved queue creation to the beginning of thread function 
(because stop function deletes the queue).

Then the stop function calls:
sets a bool to break the thread loop.
snd_seq_free_queue()
snd_seq_drop_output()

This seems to work. Any comments?

One problem I got with it though is that sometimes when I stop one music 
and play another one some note(s) from the old one are played 
indefinitely during the new music. I suppose some 'clear' event should 
be sent to remove it. I've tried MIDI_CTL_ALL_SOUNDS_OFF control one (as 
pmidi does on exit) but no luck.

-- 
Regards    Havner                     {jid,mail}:havner(at)pld-linux.org
                    "Quis custodiet ipsos custodes?"
