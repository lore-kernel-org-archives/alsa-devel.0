From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: YES! :-) Was: Bug: ALSA Sequencer or MTPAV - easy to reproduce
Date: Wed, 12 Feb 2003 18:33:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18j6JC-0002K5-00@sc8-sf-list1.sourceforge.net>
References: <20030212134436.3b9e2f10.rpav@nwlink.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 12 Feb 2003 13:44:36 PST."
             <20030212134436.3b9e2f10.rpav@nwlink.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@nwlink.com>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>For a somewhat elegant solution, it may be possible to have the mtpav
>track the last device and running status.  I initially thought this
>would be impossible, but it looks like it could be done in
>snd_mtpav_output_port_write() (mtpav.c:298).  I will work on this and
>submit a patch shortly, unless someone suggests a better solution.

FYI, the isa/wavefront driver does the same thing (it has two ports
and uses un-assigned MIDI bytes to switch between them). you might (or
might not) find it useful to take look there.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
