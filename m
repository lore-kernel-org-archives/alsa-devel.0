From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Migration from 0.5 to 0.9?
Date: Fri, 05 Apr 2002 19:52:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CADF26A.5070402@superbug.demon.co.uk>
References: <1017927701.1777.12.camel@lel1.sthlm.i3micro.se> 	<3CAD0534.5050102@superbug.demon.co.uk> <1018000807.2534.66.camel@lel1.sthlm.i3micro.se> <3CADDFD4.6020100@superbug.demon.co.uk> <3CADECF1.598D9C3@rfa.org>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from tele-post-20.mail.demon.net (tele-post-20.mail.demon.net [194.217.242.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA08836
	for <alsa-devel@alsa-project.org>; Fri, 5 Apr 2002 20:53:13 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Eric Dantan Rzewnicki <rzewnickie@rfa.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eric Dantan Rzewnicki wrote:

>James Courtier-Dutton wrote:
>
>>Leif Lindholm wrote:
>>
>>>On Fri, 2002-04-05 at 04:00, James Courtier-Dutton wrote:
>>>
>
>>I guess you might be out of luck then, as there is currently no
>>documentation on how to write sound card drivers for alsa09.
>>
>>I think the only way you can possibly compare alsa05 with alsa09 at the
>>moment, is pick simple sound card like the sb16, and compare the card's
>>source code in alsa05 and alsa09.
>>
>>Cheers
>>James
>>
>
>I know this information is about writing an alsa client and not a
>driver....
>But, perhaps Mark Rages', Matthias Nagorni's and Paul Davis's pages on
>writing clients with the alsa library would be helpful in some way:
>http://mlug.missouri.edu/~markrages/wiki/index.php?WritingAnAlsaClient
>
>The later two are linked to from the first.
>
>I appologize if this isn't helpful.
>
>-Eric Rz.
>
I think Leif was asking how to write drivers for the sound hardware 
device to alsa-lib interface(i.e. What alsa-driver/alsa-kernel does) and 
not the application to alsa-lib interface.
Maybe I will write some documentation when i attempt to write a new 
hardware driver myself. I am thinking of writing one for the dxr3 mpeg2 
decoder board, which has a simple audio out jack on it, which currently 
only have oss support.

Cheers
James
