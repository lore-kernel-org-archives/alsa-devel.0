From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: intel 8x0 went silent in 2.6.11
Date: Fri, 04 Mar 2005 01:36:17 +0100
Message-ID: <4227AD81.9000606@drzeus.cx>
References: <4227085C.7060104@drzeus.cx> <29495f1d05030309455a990c5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <29495f1d05030309455a990c5b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net, Mark Canter <marcus@vfxcomputing.com>, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

Nish Aravamudan wrote:

>On Thu, 03 Mar 2005 13:51:40 +0100, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
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
>
>There was some discussion of this on LKML a while ago. Are you sure
>you have disabled "Headphone Jack Sense" and "Line Jack Sense" in
>alsamixer?
>
>Thanks,
>Nish
>  
>
This has been rather wildly debated now but yes, muting those enables 
sound. I don't have a docking station so I can't try any effects there.
I wouldn't say that it's intuitive to mute two channels to get speakers 
working though.

Rgds
Pierre
