From: Tim Goetze <tim@quitte.de>
Subject: Re: Why do I get broken pipe on write to a pcm in state
 PREPARED?
Date: Thu, 12 Sep 2002 11:08:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209121053050.584-100000@summer.quitte>
References: <200209120406.g8C46T025177@d1o87.telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209120406.g8C46T025177@d1o87.telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Anders Torger wrote:
>On Wednesday 11 September 2002 23.52, you wrote:
>> Anders Torger wrote:
[...]
>> >The problem here is that the output buffer is full, the pcm is not
>> >RUNNING, but the file descriptor gets triggered anyway. When can
>> > that happen?
>>
>> we had a hauntingly similar discussion about this a few months ago,
>> maybe a year. iirc everybody considered the pcm behaviour broken,
>> except for the alsa coders.
>>
>> seeing that you come to the same conclusion makes me again vote
>> for changing this behaviour to 'poll/select blocks until running'.
>
>I shall be humble in this question, but of what I know now, the 
>behaviour does indeed seem broken. I get the effect "program stops 
>working when software buffer > hardware buffer", which would not happen 
>if it blocked as expected. It is harder for me to see what is the 
>advantage of the current behaviour, apart from that an obviously buggy 
>program gets a broken pipe instead of blocking infinitely. However, I 
>don't think that very small advantage justifies breaking programs that 
>expect sound cards file descriptors to behave as ordinary files.

if the api can still be changed every now and then, i don't see why
one would avoid a fix here to avoid compatibility problems. actually 
i don't think there are applications out there that make use of this
'feature', because it defies human logic (as your case shows us
again). and it is hard to imagine code logic that is based on 'poll/
select returns immediately', everyone rather has to work around it.

>So, I would appriciate to get a full explanation of why the behaviour 
>is like it is.

me too (still ;).

tim

ps: cannot say much about xruns in readX access -- i've only done 
mmap()d IO so far, which seems very reliable with an ice1712 and
an emu8k here.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
