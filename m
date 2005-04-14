From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Speaker-test improvements
Date: Thu, 14 Apr 2005 22:16:25 +0100
Message-ID: <425EDDA9.4010004@superbug.co.uk>
References: <425D7AD7.2010706@superbug.co.uk> <s5hzmw1ec8n.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0A4E7258
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2005 00:15:55 +0200 (MEST)
In-Reply-To: <s5hzmw1ec8n.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 13 Apr 2005 21:02:31 +0100,
> James Courtier-Dutton wrote:
> 
>>Hi,
>>
>>I have got some voice samples saying things like "Front Right" etc. that
>>I want the speaker-test program to output instead of the loud sine wave
>>it currently does. The sine wave will stay there as an option as I find
>>it useful for some things.
>>
>>The samples are 10 .wav files in 48khz mono S16_LE format.
>>Where abouts should I put them in the CVS, and where abouts should they
>>get installed to, so that speaker-test can find them?
> 
> 
> That's great.  (Is the voice female or male?  We might need both to be
> PC ;)
> 
> The suitable location of such data files would be something like
> $(datadir)/sounds/alsa or $(datadir)/sounds/speaker-test. 
> 
> 
> Takashi
> 
> 

Thank you. The current samples are here:
http://www.alsa-project.org/~james/speaker-test/samples/

I will hopefully modify the speaker-test program to use them soon.

James




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
