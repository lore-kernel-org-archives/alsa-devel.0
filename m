From: Tim <terminator356@users.sourceforge.net>
Subject: Re: Need help: My .asoundrc no longer works.
Date: Sat, 20 Jan 2007 22:06:06 +0000 (UTC)
Message-ID: <loom.20070120T220253-181@post.gmane.org>
References: <loom.20070120T001557-202@post.gmane.org>
	<20070120140107.GC3067@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

John Rigg <aldev <at> sound-man.co.uk> writes:

> You shouldn't need the plug converter if you specify the slaves channels
> correctly. The ice1712 has 12 inputs and 10 outputs (regardless of how
> many physical inputs/outputs your card has) and this needs to be
> set explicitly in .asoundrc using separate playback and capture device
> definitions. 
>
I should have been more clear. I am only using the multi device for record. 
My playback device is hw:1,0 - the ice1712, and I believe there is no 
 problem with it, because I can connect any jack input to those 
 outputs and get sound (except for the inputs I'm complaining about, of 
 course - the ones which come from 'b' slave - which can be the ice OR emu!). 
Inputs from other apps work. 
(And I should have said "ten hw:1,0" not "twelve hw:1,0" ouputs, sorry).


> See here for explanation:
> 
> http://www.sound-man.co.uk/linuxaudio/ice1712multi.html
>
I was going to contact your site:
       "type multi
        slaves.a.pcm hw:0      <--- No quotes? Jack won't start.
        slaves.a.channels 12
        slaves.b.pcm hw:1
        slaves.b.channels 12"
"You will also need this patch to prevent a floating point exception which   
 kills jackd at seemingly random times"
How does replacing a jack_nframes_t variable, (which is some sort of u32),
 with a double cure an fp exception? I'm running fine without it.

"Users may also have problems using the -rt kernel with pcm_multi. At the time  
 of writing, the -rt kernel (2.6.17-rt8) gives lots of xruns when using 
 pcm_multi (that's on AMD64 SMP - on UP it locks up completely). It works fine 
 with a single sound card."
Funny, me too! Seemed like once each display update of qjackctl, there
 would be a big burst of x-runs.
Until I realized I was still running the 'stock' jackit Mandriva2007 package,
 and I had not built my own jackit as I always do with the ramfs enabled. 
Well, ok, it was either THAT which cured my x-runs, or this patch mentioned:
"To make it work it's necessary to remove the linking code which was added in 
 pcm_multi.c rev 1.89. Here's a patch..." 
 which I tried but didn't cure my problems. It was the ramfs.
But I admit I'm running x86 not 64.

I notice that fp exception problem patch applies to a section called:
 /* post x-run handling */
Hmm, x-runs?...

Cheers. Tim.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
