From: Doug <nostar@comcast.net>
Subject: Re: ALSA Test suite
Date: Mon, 15 Mar 2004 14:11:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4055FFC9.10305@comcast.net>
References: <20040314095115.73922.qmail@web61103.mail.yahoo.com>	<s5hptbeiecx.wl@alsa2.suse.de>	<4055CFA4.4040600@superbug.demon.co.uk>	<s5h3c8ahzh4.wl@alsa2.suse.de> <20040315193001.4cad17ac.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040315193001.4cad17ac.mista.tapas@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I wouldn't mind taking a look at it.  I'm studying the ALSA driver / lib 
API right now and wrote a pcm player for the purpose of studying the 
API, and I do stuff like load it up with all the info and debug type 
alsa functions, experiment heavily with all of the hw_params functions 
on various devices, run gdb on it and step thu the inner workings of the 
alsa functions, etc.  I'd like to get more ideas from other pieces of 
small code.

Florian Schmidt wrote:
> On Mon, 15 Mar 2004 17:00:39 +0100
> Takashi Iwai <tiwai@suse.de> wrote:
> 
> 
>>oh thanks, it was under evaluation before getting permission ;)
> 
> 
> Hi, i don't know if my pcm config tester is in some way braindead [it
> sure is], and also it's far from complete. But if you guys feel that the
> program could be of any serious use, i would "donate" it to the ALSA
> project after cleaning it up and filling in the missing tests..
> 
> Just for remembering: it's a little program which browses the
> configuration space of a pcm device, trying to open it with different
> configurations [periodsize, periodcount, sample rates [for
> capture/playback/fullduplex] ..  It doesn't actually try to play any
> sound through it [cause the different access methods are already tested
> by the pcm test program in alsa-lib/test]...
> 
> Flo
> 

-- 
http://nostar.isa-geek.com/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
