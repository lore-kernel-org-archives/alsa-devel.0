From: David McNab <rebirth@orcon.net.nz>
Subject: HELP! seq - writing to q in realtime mode
Date: Wed, 12 May 2004 22:08:58 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A1F7BA.6020109@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(apologies if you've received this twice)

Hi,

I'm experienced in C, but am a total beginner to alsa seq api (only been
coding to it for a week), and desperately need some help. I'm going
crazy here!

I'm trying to create and schedule outbound events, in realtime absolute
mode.

When sending these events directly, using SND_SEQ_QUEUE_DIRECT, the
events get delivered fine to subscribers.

But when adding realtime absolute timestamps, and marking the event to a
queue I've created, only the very first event (time=0) gets sent.

I've struggled for days with the doco, reading example code etc, but am
having no success. There are no simple examples that cover my situation.

Can someone please give an overview (or preferably sample code)
explaining what I need to do to transmit events in realtime absolute mode?

For instance, do I need to set up timers on the queue?
What obscure function calls do I need to make, from the first
snd_seq_alloc_queue() call, to the actual snd_seq_event_output_direct()
calls sending the individual midi events?

What are the little details - obvious to you experts, but not obvious to
hackers new to the ALSA APIs?

I really need help here - I'm tearing my hair out in frustration, and am
brain-fried from wading through the thousands of different api functions
and macros, and hampered by the lack of detailed doco and tutorial
examples (the miniArp example doesn't help, because it's tick-based).

Thanks profusely in advance for your help

Kind regards
David

PS - ALSA is really great software. The APIs are very comprehensive. But
IMO ALSA could really benefit from the addition of an
ultra-stupid-simple-dumbed-down API which covers most basic scenarios,
doesn't confuse the newer programmer with 5,347 different function calls
and data types, and doesn't require weeks of learning.



-- 

Kind regards
David

--

leave this line intact so your email gets through my junk mail filter


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
