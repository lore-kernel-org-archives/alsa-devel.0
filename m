From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: alsa-lib bloat.
Date: Wed, 13 Dec 2006 11:31:19 -0800
Message-ID: <45805507.6090802@pianodisc.com>
References: <45795C6D.9030100@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45795C6D.9030100@superbug.co.uk>
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

All,

Sorry it's taken me so long to add my 2cp, it's been a bit of a crazy 
few days.

I really don't think libasound should worry about paring down for 
embedded platforms.  Look, ALSA is an _Advanced_ Linux Sound 
Architecture, right?  Yes, it's got a lot of features, code, and 
ultimately power.  There's been complaints over the years of how hard it 
is to use also.  Well, true, but that's often the cost of powerful 
frameworks.

Really, anyone who is using Linux as an "embedded" platform isn't doing 
what I would regard as real embedded work.  Often these sort of 
developers are actually PC (or Linux, or whatever) application 
developers called upon to do embedded work, or are embedded workers 
wanting a common OS and have a board with capabilities that can handle a 
full OS like Linux.  I'm not saying that Linux doesn't have value on 
embedded systems, but really, you're providing a full (even if it is 
custom hardware) nominal computer to the OS in order to get Linux 
running on it, with certain minimum requirements:  This isn't a small 
embedded system with severely limited 8bit processing power, 1MB flash, 
and 256K RAM.

Anyone with severe embedded real time requirements will probably be 
using one of the specially designed embedded OSes or will be using a 
home-grown OS or no OS.  Take a look at the various stats published in 
places like Embedded Systems Programming or compiled by people like Jack 
  Ganssle over the years if you want proof of that assertion.

That said: Linux and ALSA have a great future in the newer 
psudo-embedded systems that are actually tiny industrially packaged PCs. 
  And even in custom boards with enough resources to handle it.  I use 
it and love it.

I do think the power to selectively include or disable feature groups as 
  Jaroslav pointed out is great.  In my experience a few hundred K or 
even a couple of M isn't a killer for most embedded uses that have 
decided to use Linux.

For me it boils down to this: libasound was designed for and is intended 
for advanced usage by people that were unsatisfied with the capabilities 
and performance of the more simple interfaces provided with Linux a few 
years ago.  It is powerful and exactly what I need for our advanced usage.

* Do I wish it was sometimes easier to use? Sometimes.
* Do I wish for more features or power? Rarely.  And when I do, I fix it 
where necessary.
* Do I wish the documentation was better?  Sometimes.  But I guess I 
could contribute to that if I was really bothered by it.
* Do I wish the community was better?  Never!  You're all great and 
stand behind the library and answer questions quickly.
* Do I wish it were smaller?  Honestly, I've never noticed the size of 
libasound; I've always had other programs or libraries that are much 
bigger problems.

My vote: by all means make it smaller, and include ways to trim out 
function groupings that a particular application doesn't need.  But, I'd 
rather see the time and effort go into stability, ease of use, speed, 
power, and enhanced compatibility (drivers).

Just the opinion of one actual embedded developer.

Thanks for listening,
- Steve




James Courtier-Dutton wrote:
> Hi,
> 
> On my desktop system, I have this:
> /usr/lib/libasound.so.2.0.0
> size: 2785380 bytes.
> 
> libasound is really too big for what is does.
> I was talking to some embedded platform developers recently, and they 
> really don't like it at all.
> 
> Could something be done about it?
> I was thinking that we could really cut down the API to a very limited 
> subset of the current api, and place #ifdef in the source code, so that 
> developers could build alsa-lib for embedded systems using just this 
> subset of the current api. I would suggest just using the poll() 
> callback method would be needed, as then it is similar to Mac OS X, and 
> generally accepted as the best way to talk to a sound device.
> 
> I would also like to ask any embedded developers out there who have 
> already done this, to post patches back to ALSA so that it saves 
> developers time in future.
> 
> How about also separating libasound into separate libs, one for PCM, one 
> for MIDI, and one for CONTROL that could in turn use a separate "helper 
> functions" lib for any common functions. Some embedded applications 
> might not need any of the MIDI/sequencer stuff.
> 
> Any comments?
> 
> James
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
