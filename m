From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: [linux-audio-user] USB sound
Date: Sun, 30 Jun 2002 03:18:52 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1DFA0C.30504@boosthardware.com>
References: <B93F5FB3.BCB%Alexander_Carot@gmx.net> <s5h8z4zog7t.wl@alsa2.suse.de> <3D1CAA0D.5070608@boosthardware.com> <200206290818.04426.speaker-to-vegetables@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have moved this to alsa-devel as it seems more relevant to discuss there.

Speaker to Vegetables wrote:
> Not to be overly pedantic or anything, but putting stuff in the kernel 
> that doesn't have to be there would be the unprofessional thing.

But it will be a driver module right?

> Stuff 
> that goes in the kernel is harder to install and usually harder to use. 

huh?

> More importantly, bugs in code that goes in the OS kernel can easily 
> crash the whole computer, while userland code seldom crashes anything 
> beyond its own little process. 

I don't think it will be included in the kernel until it is sufficiently 
tested and then if there is a bug it will be found much quicker.

>The golden reason for putting anything 
> in a kernel-level driver is when that's the only way to get it to 
> perform well enough.
> 

Good point but then if then we shouldn't have included ALSA if that is 
true. The ALSA code base is large and having the usb midi module as a 
userland app seems to me to go against the precendant set by the rest of 
the modules.




> On Friday 28 June 2002 02:25 pm, Patrick Shirkey wrote:
> 
>>Takashi Iwai wrote:
>>
>>>i could write it soon if there were enough requests and reasons to
>>>do that.  (actually i had a half-finished code.)
>>>imo, however, if a user-land solution really works well, it doesn't
>>>make sense to write a new kernel driver.
>>
>>Ease of use/installation and professionalism. IMO people will be
>>happier if you include it internally. The only reason I can see for
>>it not to be is if an external api has better latency performance.
> 
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
