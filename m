From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: obtaining timestamps from sequencer events
Date: Wed, 22 Dec 2004 12:39:32 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0412221233360.2069@pnote.perex-int.cz>
References: <20041222003822.42138.qmail@web51908.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041222003822.42138.qmail@web51908.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michael Geis <michaelgeis11@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Dec 2004, Michael Geis wrote:

> Thanks Jaroslav. I played around with those functions. I now set up the
> port manually. I also check the queue time at very incoming event.
> Still, after setting a time stamp for my port, all timestamps remain 0.

You must also start the timer for given queue. See
snd_seq_start_queue() and event_decoder_start_timer() function
in alsa-lib/test/seq-decoder.c . I also mystified you a bit, because
you need to use snd_seq_port_subscribe_set_time_update() and
snd_seq_port_subscribe_set_time_real() functions rather than setting
capabilities of your allocated port. I've not used the sequencer stuff 
for long time. The seq-decoder.c source will help you with all things.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
