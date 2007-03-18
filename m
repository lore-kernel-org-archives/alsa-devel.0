From: "M. Gagnon" <fire_void@hotmail.com>
Subject: Re: Development Question
Date: Sat, 17 Mar 2007 21:19:48 -0400
Message-ID: <BAY120-F17E8FDED841B64CE8247F09C770@phx.gbl>
References: <45FC5F5F.4090104@joow.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45FC5F5F.4090104@joow.be>
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

This is interesting, Pieter, however my app already has the knowledge of 
notes and events, the only reason i had midi bytes was because i converted 
the events into bytes because then i could make them play using a single 
function on mac.

Apparently on Linux/Alsa it's not this way, so i should probably learn how 
to put a serie of events in a sequence and then play it. The most recent 
sample of this i found was dated '2002' and didn't work, and my own attempts 
with the documentation didn't either.

I am already able to send events directly. Where can i find recent 
infomation on how to schedule them in a queue and play them after?

thanks


>From: Pieter Palmers <pieterp@joow.be>
>To: "M. Gagnon" <fire_void@hotmail.com>
>CC: alsa-devel@lists.sourceforge.net
>Subject: Re: [Alsa-devel] Development Question
>Date: Sat, 17 Mar 2007 22:36:31 +0100
>
>M. Gagnon wrote:
>>Hi, i am now trying to port an application to linux using Alsa. At some 
>>point, i have midi bytes as char* and i have to play them. This is exactly 
>>the same data you'd find in a file, expect that it's in memory instead. 
>>How is that possible?
>>
>>If this is not possible, i could always take any help on playing midi 
>>using sequencers I looked at the docs, i found a few samples, but they 
>>seemed to be outdated and the one that could interest me segfaulted. After 
>>i debugged it and fixed the segfault, it played nothing... (and i'm sure 
>>my midi is configured correctly BTW, pmidi works and i also succeeded in 
>>getting single notes to play)
>This is how I do playback in the freebob backend for jack:
>
>for (s=0;s<samples_read;s++) {
>   signed int *byte=(buff+s);
>   snd_seq_event_t ev;
>   if ((snd_midi_event_encode_byte(
>          port->parser,(*byte) & 0xFF, &ev)
>        ) > 0) {
>       // a midi message is complete, send it out to ALSA
>       snd_seq_ev_set_subs(&ev);
>       snd_seq_ev_set_direct(&ev);
>       snd_seq_ev_set_source(&ev, port->seq_port_nr);
>       snd_seq_event_output_direct(port->seq_handle, &ev);			   }
>}
>
>you can check the freebob_driver_midi_* functions in the freebob jack 
>backend for more detail.
>
>Pieter
>

_________________________________________________________________
Windows Live Spaces: partagez vos photos avec vos amis! 
http://spaces.live.com/?mkt=fr-ca


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
