From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: intel 8x0 went silent in 2.6.11
Date: Mon, 21 Mar 2005 23:47:40 +0100
Message-ID: <423F4F0C.2040203@drzeus.cx>
References: <4227085C.7060104@drzeus.cx> <20050321142138.3b9f3950.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050321142138.3b9f3950.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andrew Morton wrote:

>Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>  
>
>>I just upgraded to Linux 2.6.11 and the soundcard on my machine went 
>>silent. All volume controls are correct and there are no errors 
>>reported. But no sound coming from the speakers. And here's the kicker, 
>>the headphones work fine!
>>2.6.10 still works so the bug appeared in one of the patches in between.
>>The sound card is the one integrated into intels mobile ICH4 chipset.
>>
>>    
>>
>
>Pierre, did this end up getting fixed?
>
>Thanks.
>  
>
It worked as soon as I turned of those 'Sense' mixers. The problem was
with the defaults chosen when upgrading from 2.6.10 to 2.6.11 (tweaking
was required to restore functionality).

Takashi Iwai mentioned a patch not yet in mainline that was supposed to
fix this. I didn't actually test that patch but since the matter was
looked into it was enough for me.

Rgds
Pierre



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
