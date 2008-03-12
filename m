From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] Metallic recording in cs46xx
 on	Thinkpad T22
Date: Wed, 12 Mar 2008 17:39:48 +0100
Message-ID: <47D80754.1020400@keyaccess.nl>
References: <3948f0730803110024k1e7b90ecr31b745e333913c1d@mail.gmail.com>	<47D70143.3010705@keyaccess.nl>
	<s5hk5k89f52.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5hk5k89f52.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>, Gadi Oron <gadior@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12-03-08 15:43, Takashi Iwai wrote:

> At Tue, 11 Mar 2008 23:01:39 +0100,
> Rene Herman wrote:
>> On 11-03-08 08:24, Gadi Oron wrote:
>>
>>> I am trying to record sound on an old Thinkpad T22 that uses the cs46xx 
>>> sound driver.
>>>
>>> Each time you start to record you have a 10% chance of having the 
>>> recording completely distorted and having a metallic sound. When you 
>>> look at the waveform it looks as though there are small segments with 
>>> sharp transitions between them, a little like if these segments were 
>>> moved a little from their correct place.
>> No insights, but I confirm the bug with a TerraTec DMX XFire 1024 (CS4624).
> 
> Hm, cs46xx driver hasn't been much changes since long time ago (around
> year 2005).  The only big change was about some PM fixes, and I don't
> think it's relevant...  Could you run als-info.sh to get the status?

At:

http://pastebin.ca/939784

Script was run just after repeating the problem. I have two of these same 
cards (TerraTec DMX XFire 1024) by the way and the same thing happens on 
both. If desperately need be, I can also test a CS4630 in the form of a 
TerraTec SiXPack 5.1+.

This may indeed have been broken for a long time. I (sometimes) use this 
card in a little P1-133 machine in my living room to feed music to my 
regular amp and, seldomly, use it to record from for example LP.

Last time that I did was some 2 months ago and I experienced the problem and 
at the time I remembered seeing that problem before, which may well have 
been 2005. As said, it doesn't happen each time and I use recording on that 
card seldomly...

I expect this is going to be difficult to debug. It's no doubt a timing 
problem and yes, Gadi's description matches. This is what a bad capture 
sounds like:

http://members.home.nl/rene.herman/cs4624-bad-capture.wav

(a good capture is just, well, good)

Didn't report it before since when I'm recording on that thing I'm recording 
for someone else and when I'm busy trying to do something _with_ a computer 
instead of _to_ a computer, all those pesky little linux problems just get 
on my nerves so incredibly bad at times...

Rene.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
