From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Channel modes feature request.
Date: Tue, 12 Aug 2003 10:25:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F38B29E.3080906@superbug.demon.co.uk>
References: <3F382486.4070604@superbug.demon.co.uk> <s5hy8xzi6je.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8xzi6je.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 12 Aug 2003 00:19:34 +0100,
> James Courtier-Dutton wrote:
> 
>>I have a SB live audio card.
>>I can open it with device names like: -
>>surround40 (Front Left, Front Right, Rear Left, Rear Right)
>>surround51 (Front Left, Front Right, Rear Left, Rear Right, Center, LFE)
>>
>>There is a requirement for: -
>>surround41 (Front Left, Front Right, Rear Left, Rear Right, LFE)
>>surround50 (Front Left, Front Right, Rear Left, Rear Right, Center)
>>
>>How can I get alsa to support these ?
> 
> 
> i still don't understand your question quite correctly.
> 
> do you mean open a multi-channel (5ch) pcm stream wihh the
> configuration above?
> if so, it's not too difficult for sb live (but not always easy for
> other cards).  it would look like:

Can you expand on why. Because it seems sensible to me that all cards 
that do surround51, can also do surround50 and surround41.
If by what you say, it is not possible (when I say not possible, I mean 
not possible with adding extra memcpy's to move the channels around in 
alsa-lib) , then I will adjust my application to use the surround51 pcm, 
and just mute the un-needed channel.

> 
> pcm.my5ch {
> 	type multi
> 
> 	slaves.a.pcm "front"
> 	slaves.a.channels 2
> 	slaves.b.pcm "rear"
> 	slaves.b.channels 2
> 	slaves.c.pcm "lfe"
> 	slaves.c.channels 1
> 
> 	bindings.0.slave a
> 	bindings.0.channel 0
> 	bindings.1.slave a
> 	bindings.1.channel 1
> 	bindings.2.slave b
> 	bindings.2.channel 0
> 	bindings.3.slave b
> 	bindings.3.channel 1
> 	bindings.4.slave c
> 	bindings.4.channel 0
> }
> 
> 
> Takashi
> 
> 

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
