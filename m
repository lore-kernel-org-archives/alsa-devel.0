From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [PATCH] emu10k1: add interval timer support
Date: Fri, 24 Sep 2004 10:53:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409241453.i8OErtVR029650@localhost.localdomain>
References: <Pine.LNX.4.58.0409241546570.2289@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 24 Sep 2004 15:56:52 +0200."
             <Pine.LNX.4.58.0409241546570.2289@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>On Fri, 24 Sep 2004, Takashi Iwai wrote:
>
>> > How would I open only channels 10 and 11 with one app and 1-6 with
>> > another using a single 16 channel device?  
>> 
>> It's doable to implement the multi-channel non-interleaved PCM with
>> multi open.  But even in this case, we provide eventually 16
>> substreams, so perhaps providing 16 mono substreams would be easier to
>> implement (at least for the kernel driver).
>> 
>> Regarding the efficiency (latency), there will be no difference
>> between the multi-channel and multi-substream implementations.
>> In the latter case, we can use linked substreams, as you already
>> mentioned.
>
>I don't understand much the requirement. If you want to use other ALSA 
>(legacy) applications, you can reroute them to appropriate FX bus only.
>The controls are already available.
>
>The multichannel PCM should be best only for multichannel recording /
>playback. You're trying to desing a new API which does not make much
>sense.

more to the point, perhaps, is that the very first implementation of
the RME Hammerfall (digi9652) driver that i did took lee's approach
and when we measured it, there was a very definite performance
hit. having to call the "elapsed" function for every mono stream added
measurable overhead. when we collapsed it back to a single
non-interleaved, 26 channel device, it was significantly more
efficient.

if the "multi" PCM device/plugin works this would be a far preferable
way to implement the multichannel PCM device on this card, IMHO.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
