From: =?ISO-8859-1?Q?Ingo_M=FCller?= <alsa@ingomueller.net>
Subject: Re: Ideas for the softvol plugin
Date: Fri, 12 Jan 2007 19:31:01 +0100
Message-ID: <45A7D3E5.9060509@ingomueller.net>
References: <70a871c80701092048v23fbf0d8yc40d434eab023506@mail.gmail.com>	<70a871c80701101406y3f8293e9sd57b1d4c5ba9b166@mail.gmail.com>	<45A64FBF.5070503@ingomueller.net>
	<s5h3b6ggld0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h3b6ggld0.wl%tiwai@suse.de>
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

Hi!

Thanks for the answer!

Takashi Iwai schrieb:
> At Thu, 11 Jan 2007 15:54:55 +0100,
> Ingo M=FCller wrote:
>> Hi!
>>
>> I have some ideas about features that could be added to the softvol
>> plugin, that I want to discuss with you.
>>
>> 1) A mute/unmute function. I think this is the most easy job.
> =

> Likely.
> =

>> 2) Ability to replace an existing control. I have no idea whether it is
>> possible to realize this, but this would be very usefull (see below).
> =

> Well, my idea is to overwrap the existing mixer elements with the new
> user-space elements instead of replacing the kernel space entries.
> This would be a plugin for ctl interface.

I'm not sure whether I understand it right. But that doesn't matter.
Anything that lets the master volume control control the master volume
is fine :-)

> =

>> 3) Multi channel capabilities. This is just a vague idea. The aim is to
>> be able to control e.g. front, rear and center/lfe channels seperately
>> from each other. Maybe like this:
>>
[...]
> =

> Hm, this wouldn't be too hard, too...

I'd really love if some of those ideas would be implemented.
Unfortunately, I really can't do it myself. What I can do and sure will
is testing. So if anyone needs a tester for one of those things, here I
am :-)

Greets, Ingo

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
