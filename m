From: Florian Schmidt <mista.tapas@gmx.net>
Subject: alsa pcm jack plugin
Date: Sun, 8 Jan 2006 20:44:54 +0100
Message-ID: <20060108204454.511ad978__2432.90193980119$1136763151$gmane$org@mango.fruits.de>
Reply-To: alsa-devel@alsa-project.org <alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 29C7F130
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2006 20:44:56 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@alsa-project.orgalsa-devel@alsa-project.org, The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>, jackit-devel@lists.sourceforge.netjackit-devel@lists.sourceforge.net, mdeboer@iua.upf.es, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


Please reply to alsa-devel only (it is open to nonsubscribers), i
crossposted to get the attention of everybody who might be able to shed
light on this issue [or even be able to fix it].

Hi,

i've seen some reports on #lad (irc.freenode.org) about how the alsa pcm
jack plugin (pcm_jack from now on) fails to work with some (most)
applications. The two cases i know about from my own experience are:

- xmms

- ninjam

They fail in slightly different ways though. For reference, you find my
relevant .asoundrc excerpt at the bottom of this mail.

xmms simlpy doesn't start playback when using the jackplug device (well,
it seems it wants to, but its clock simply stays at 00:00). Jack seems
to stay functional though.

With ninjam, it is possible to actually get some audio from it (for
about 10 seconds), then it goes silent/frozen and jack's watchdog kicks
it out after the timeout time has expired. And jackd is taken down with
it, too :(

20:28:08.662 Audio connection graph change.
20:28:08.842 Audio connection change.
subgraph starting at alsaP.26465.1 timed out (subgraph_wait_fd=20, status = 0, state = Finished)
**** alsa_pcm: xrun of at least 1.018 msecs
jackd watchdog: timeout - killing jackd
zombified - calling shutdown handler
20:28:20.839 Shutdown notification.
20:28:20.842 Client deactivated.
20:28:20.849 JACK is stopping...
cannot send request type 7 to server
cannot read result for request type 7 from server (Broken pipe)
cannot send request type 7 to server
cannot read result for request type 7 from server (Broken pipe)
20:28:21.092 JACK was stopped successfully.

This implies to me, that the pcm_jack process callback must have blocked
(a big NO-NO which the jack api docs clearly state :)).

I took a small look at the source code (pasted here:
http://rafb.net/paste/results/W8tJPa63.html for reference (non permanent
link)) and i found:

        write(jack->fd, buf, 1); /* for polling */

(snd_pcm_jack_process_cb(), line 144 in pcm/jack/pcm_jack.c)

write() is a potentially blocking system call. I don't know the details
well enough to judge whether this is a problem here.

Besides that write() call there's some alsa_lib calls, too, of which i
don't know whether they potentially block. Namely:

 snd_pcm_area_silence
 snd_pcm_area_copy
 snd_pcm_ioplug_mmap_areas

I wonder whether cleanly designed this thing would need to have to use
an alsa lib calls in the process callback at all. And most of all the
write() should be avoided, too. Shouldn't all communication with the
pcm_jack's process callback be done via lockless ringbufffers/condition
variables?

Or am i misunderstanding the problem here completely? someone might add
some explanatory words on how the code is supposed to work?

Thanks for all insights,
Flo

~/.asoundrc:

pcm.jackplug {
    type plug
    slave { pcm "jack" }
}

ctl.jackplug {
        type hw
        card 0
}

pcm.jack {
    type jack
    playback_ports {
        0 alsa_pcm:playback_1
        1 alsa_pcm:playback_2
    }
    capture_ports {
        0 alsa_pcm:capture_1
        1 alsa_pcm:capture_2
    }
}


-- 
Palimm Palimm!
http://tapas.affenbande.org


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
