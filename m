From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Adds 24bit, 96khz support for multichannel
 playback on the Audigy 2 sound cards.
Date: Sun, 13 Mar 2005 12:24:00 +0000
Message-ID: <423430E0.1080705@superbug.co.uk>
References: <423349A5.8020001@superbug.co.uk> <Pine.LNX.4.58.0503130906540.1755@pnote.perex-int.cz> <42341B5F.20504@superbug.co.uk> <Pine.LNX.4.58.0503131304410.1755@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EE4881E0
	for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2005 13:24:01 +0100 (MET)
In-Reply-To: <Pine.LNX.4.58.0503131304410.1755@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Sun, 13 Mar 2005, James Courtier-Dutton wrote:
> 
> 
>>Jaroslav Kysela wrote:
>>
>>>
>>>Could you cleanup a bit your code before merging? It seems that there is 
>>>alot of #if 0 .. #endif parts....
>>>
>>
>>The code inside the #if 0 .. #endif implements features that I have not 
>>yet finished merging. E.g. 24bit capture.
>>As I fix each section, the #if 0 etc. will be removed.
>>Would you prefer that I just remove all the current sections under #if 0 
>>and then add them back in as I get them working?
> 
> 
> Okay, applied the stripped version and new code slipped into 1.0.9rc1 
> (will be available in next minutes)...
> 
> 						Jaroslav

Nice, thanks

James


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
