From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: intel 8x0 went silent in 2.6.11
Date: Thu, 3 Mar 2005 09:45:34 -0800
Message-ID: <29495f1d05030309455a990c5b@mail.gmail.com>
References: <4227085C.7060104@drzeus.cx>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <4227085C.7060104@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 03 Mar 2005 13:51:40 +0100, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> I just upgraded to Linux 2.6.11 and the soundcard on my machine went
> silent. All volume controls are correct and there are no errors
> reported. But no sound coming from the speakers. And here's the kicker,
> the headphones work fine!
> 2.6.10 still works so the bug appeared in one of the patches in between.
> The sound card is the one integrated into intels mobile ICH4 chipset.

There was some discussion of this on LKML a while ago. Are you sure
you have disabled "Headphone Jack Sense" and "Line Jack Sense" in
alsamixer?

Thanks,
Nish
