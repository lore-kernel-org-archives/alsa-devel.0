From: "Henry \"Drew\" W. Abbot, Jr." <hwa5c@virginia.edu>
Subject: Re: yet another full duplex wannabe
Date: Tue, 23 Jan 2007 01:10:46 -0500
Message-ID: <45B5A6E6.10809@virginia.edu>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Whoops!  So, first of all, the feedback was due to me not muting PCM 
Playback via the mixer, haha.  No wonder there was so much feedback!  No 
wonder ecasound et al didn't work!  Doh!  Anyway, by realizing this 
silly mistake and coming up with better code, I achieved my goal.  If 
anyone cares to look at, laugh at, and/or criticize some code, advise me 
to use the async interface, take a different approach etc. here's what I 
got:
http://people.virginia.edu/~hwa5c/code/fulldup8b.c

Best,
Drew


Henry "Drew" W. Abbot, Jr. wrote:

>Greetings,
>   I'm trying to achieve a full-duplex sound processing app with ALSA.  
>I've been messing around with various code examples for days now, and 
>I've started hitting some of (what seems to be) the same ol' 
>difficulties any newbie encounters when trying to tackle full duplex 
>with ALSA.  For now, the goal is simply to simultaneously capture from 
>plughw:0,0 and playback to plughw:0,0.  I've gotten a few "working" test 
>apps -- by "working", I mean I can hear stuff, but the sound is really 
>choppy -- that is, I'll hear captured sound for one period, then I'll 
>hear about one period of silence while readi blocks, then another period 
>of sound, then another period of silence, etc. (this can resemble the 
>sound of a helicopter) -- anyway, the net result is an ugly and 
>distorted capture.  The main two test apps I'm working with right now 
>are both based on the pcm.c example.  In one, I essentially turned the 
>write_loop into a readwrite_loop, and in the other, I use two threads 
>(via pthreads), one to capture and one to playback.  I've only messed 
>with the standard interleaved, blocking interface.  From the discussion 
>at 
>http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg09937.html, 
>I assume a better approach would be to use snd_async_add_pcm_handler() 
>and/or mmapped access and snd_pcm_avail_update() on both capture and 
>playback PCMs.  However, should I be running the capture and playback in 
>separate threads or in the same thread?  In separate processes (i.e. 
>fork() vs. pthreads)?  Intuitively, separate threads seems like it could 
>help, but I should be calling writei pretty soon after calling readi 
>completes (right?), so it also seems like having them run in separate 
>threads would complicate things.  Right now, I've tried to "hack it," 
>such that whenever readi is blocking, sound will still be playing from 
>the last writei (is this conceptually accurate?), but to no avail.  
>Messing with the period and buffer sizes changes the "helicopter effect" 
>somewhat (i.e. for smaller periods, the sound has a tendency to blow up 
>/ be unstable -- I guess this is feedback), but basically it's the 
>same.  At first, I thought I was just way off, but after running the 
>latency.c example and getting the same "helicopter-like" results, I 
>gained back some confidence.  I even tried running 'ecasound -i 
>alsahw,0,0 -o alsahw,0,0' and it, too, yielded similar results.  I 
>didn't try messing with period or buffer sizes with ecasound, but I 
>tried many with latency.c and nothing seemed to produce smooth, 
>undistorted sound.  Surely, I don't have to apply low-latency patches or 
>something to simply run a full-duplex userland app, do I?  I know what 
>you guys want to say... I should just forget about all of it and use 
>JACK, and yes, I am already at the JACK website reading the 
>documentation, but I would like to get my own lower-level ALSA code 
>working, too.  In summary, my questions are:
>   1) Any ideas on why latency.c and ecasound aren't working smoothly?
>   2) Any advice on whether to use the standard ALSA interface, the 
>async, the mmap, etc. for a full duplex app?
>   3) Any advice on single-threaded vs. multi-threaded?
>   4) Should my capture and playback PCMs be configured the same way?  
>I.e. how about this for an app.. should I have a smaller period size for 
>capture, and capture each little bit at a time, and when the time comes 
>around to send another larger period for playback, I can send however 
>many smaller capture periods I have received at that time.
>
>Thanks for your time, and sorry for such a long post.
>
>
>Best,
>Drew
>
>
>
>
>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share your
>opinions on IT & business topics through brief surveys - and earn cash
>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>  
>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
