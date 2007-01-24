From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: yet another full duplex wannabe
Date: Wed, 24 Jan 2007 03:09:36 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0701240256460.3526@ecabase.localdomain>
References: <45B528BA.9020101@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45B528BA.9020101@virginia.edu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Henry \"Drew\" W. Abbot, Jr." <hwa5c@virginia.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, 22 Jan 2007, Henry "Drew" W. Abbot, Jr. wrote:

>   I'm trying to achieve a full-duplex sound processing app with ALSA.
> I've been messing around with various code examples for days now, and
> I've started hitting some of (what seems to be) the same ol'
> difficulties any newbie encounters when trying to tackle full duplex
> with ALSA.  For now, the goal is simply to simultaneously capture from
> plughw:0,0 and playback to plughw:0,0.  I've gotten a few "working" test
> apps -- by "working", I mean I can hear stuff, but the sound is really
> choppy -- that is, I'll hear captured sound for one period, then I'll

have you tried the code on another computer, and/or with different 
soundcard? That sounds like a driver problem. The most basic:

sh> arecord -f cd - |aplay -f cd -

... should produce acceptable audio quality in most cases. Getting that to 
work reliably, with all kinds of soundcards, and with a low latency, is 
somewhat trickier (and this is when I'd recommend taking a look at JACK 
:)). But simple full-duplex recording'n'playback should work 
out-of-the-box...

> playback PCMs.  However, should I be running the capture and playback in
> separate threads or in the same thread?  In separate processes (i.e.
> fork() vs. pthreads)?  Intuitively, separate threads seems like it could

In most cases you want to run in the same thread, or otherwise you need 
complicated measures (as done in JACK) to synchronize the different 
execution contexts, and to keep the cost of these contexts switches at a 
reasonable level.

> same.  At first, I thought I was just way off, but after running the
> latency.c example and getting the same "helicopter-like" results, I

This really is pointing towards a driver/hw bug... latency.c has always 
worked for me (and I've been using it with dozens of ALSA versions and 
soundcards).

> gained back some confidence.  I even tried running 'ecasound -i
> alsahw,0,0 -o alsahw,0,0' and it, too, yielded similar results.  I
> didn't try messing with period or buffer sizes with ecasound, but I

That should work as well ... in majority of cases, ecasound will tune the 
buffering parameters automatically (based on what you've asked ecasound to 
do).

> undistorted sound.  Surely, I don't have to apply low-latency patches or
> something to simply run a full-duplex userland app, do I?  I know what

No patches of any sort should be needed for the basic functionality
(latency.c) to work.

> you guys want to say... I should just forget about all of it and use
> JACK, and yes, I am already at the JACK website reading the
> documentation, but I would like to get my own lower-level ALSA code
> working, too.  In summary, my questions are:

You could of course install JACK and test whether you get the same
helicopter effect with it, too? That would potentially help to track down 
the problem.

-- 
  links, my public keys, etc at http://eca.cx/kv

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
