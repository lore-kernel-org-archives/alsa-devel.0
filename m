From: Antti Boman <antti.boman@mindcom.fi>
Subject: Re: snd-cmipci with Jack not working
Date: Thu, 30 Jan 2003 14:29:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E391A92.4050001@mindcom.fi>
References: <3E379E8A.10502@mindcom.fi>	<s5hsmvblw0e.wl@alsa2.suse.de>	<3E386842.5000908@mindcom.fi>	<s5hn0ljkm4g.wl@alsa2.suse.de>	<3E38F7C0.9000904@mindcom.fi> <s5hisw7kkh5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisw7kkh5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 30 Jan 2003 12:00:32 +0200, Antti Boman wrote:
 >>
>>Andrew Morton's 
>>(http://www.zip.com.au/~akpm/linux/schedlat.html#downloads) patch. Sorry 
>>about the flaws in terminology, I'm kind of half-dumb with these. If 
>>there are even difference with those ones, I have to check them out 
>>tonight and tell you then.
>  
> basically LL-patch is safer...

Well, I've gone along with the recommendations of LAU Low-latency Howto 
at http://www.djcj.org/LAU/guide/Low_latency-Mini-HOWTO.php3 but then 
again, the basic problem I'm experiencing is not that enabling LL 
crashes the machine. It's the fact that I cannot get anything but 
garbled audio out of jackd with cmipci, along with the symptoms of 
playback/capture only.

But yes, I will get into those safety issues when I get the basics 
working :)

> anyway i recommed to use without LL-patch (or disabled via sysctl) as
> the first tests.

"echo 0 > /proc/sys/kernel/lowlatency" is enough, right?

> otherwise we don't know which is the culprit.
> as long as no heavy disk access, the normal scheduler should work
> fine.

Yes, I found that out, too. I just wanted to do the tests with both LL 
enabled and disabled, and obviously ran more tests with it enabled, as 
it caused more severe errors :)

>>>if the above function is directly called from jack, then it should be
>>>a bug of jack.  the error above says the passed argument is a null
>>>pointer.
>>
>>I know. But I don't know if it's directly called from jackd. I'll try 
>>and ask more on jackit-devel or try to find things myself. May be 
>>another dead-end, though.
>  
> you can run non-stripped jackd in the source tree before installation,
> and run from gdb to trace at which point this happens.

Ok, that's what I'll do tonight or tomorrow. I'll have all the weekend 
for solving this problem, and I will try to solve it even if it takes 
the whole weekend.

>>Then again, even without enabling low latency (whatsoever) it doesn't 
>>work. I'm just afraid this won't be solved. And I'm not afraid for 
>>myself, just for the fact that 8738 is a highly used chip. Have you 
>>tried running jackd with the one of yours?
> 
> yes.  no hang up with -R and/or -P options, so far.
> 	# jackd -v -R -d alsa -d hw -r 44100 -p 512 -n 2
> 	# jackd -v -R -d alsa -d hw -r 44100 -p 512 -n 2 -P

Ok. The second one definitely crashes every time.

Did you see the message in the the original thread in jackit-devel 
concerning watching /proc/asound/card0/pcm0p/sub0/status and 
/proc/asound/card0/pcm0c/sub0/status? If you did, was there anything 
abnormal there? If not, here's a link in case you want to see the results:

http://sourceforge.net/mailarchive/message.php?msg_id=3656330

Thanks a lot, Takashi, for helping me out. I'll do the tests and 
debugging you asked me to do as soon as I find the time for it. Tomorrow 
night if not before that.

-a



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
