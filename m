From: Mark Canter <marcus@vfxcomputing.com>
Subject: Re: intel 8x0 went silent in 2.6.11
Date: Thu, 3 Mar 2005 13:46:03 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx> <29495f1d05030309455a990c5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
In-Reply-To: <29495f1d05030309455a990c5b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The same issue exists on a T42p (ICH4).  Doesn't that kind of defeat the 
purpose?  The thought of having to disable the headphone jack and reenable 
it each time is trivial considering you can go with the fact that sound 
did not require the sound system touched under <= 2.6.10.

+----------------------------------------------------+
| Mark Canter (marcus@vfxcomputing.com)              |
| http://www.vfxcomputing.com                        |
+----------------------------------------------------+

On Thu, 3 Mar 2005, Nish Aravamudan wrote:

> On Thu, 03 Mar 2005 13:51:40 +0100, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>> I just upgraded to Linux 2.6.11 and the soundcard on my machine went
>> silent. All volume controls are correct and there are no errors
>> reported. But no sound coming from the speakers. And here's the kicker,
>> the headphones work fine!
>> 2.6.10 still works so the bug appeared in one of the patches in between.
>> The sound card is the one integrated into intels mobile ICH4 chipset.
>
> There was some discussion of this on LKML a while ago. Are you sure
> you have disabled "Headphone Jack Sense" and "Line Jack Sense" in
> alsamixer?
>
> Thanks,
> Nish
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
