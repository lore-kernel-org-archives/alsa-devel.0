From: Paul Davis <pbd@op.net>
Subject: Re: Difficulty of a Hammerfall DSP Cardbus Driver?
Date: Mon, 13 May 2002 20:23:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205140022.g4E0M6T09516@post2.fast.net>
References: <20020513184612.GA25861@dogsolitude.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 13 May 2002 14:46:12 EDT."
             <20020513184612.GA25861@dogsolitude.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: drclaw@dogsolitude.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>My questions are if there were currently any plans to support the
>cardbus H-DSP interface, and if not, how difficult would it be to write
>them in the opinion of someone familiar with either the existing pci
>driver or someone familiar with cardbus vs. pci programming in general?
>Also, where are the H-DSP specs living?  

* if you mean "technical details need for a driver":

There are none. When I say, I don't mean you can't have them. I mean:
there are none (they have never been written. there are only a couple
of people who know how the H-DSP works, and i'm happy to say that i'm
one of them :) The H-DSP driver that just entered ALSA CVS was written
using source code for a driver for a different OS, issued to me under
an do-not-distribute agreement. The ALSA driver *is* the
documentation, so now you can join the group of people who understand
it :)

* if you mean "technical specs needed to sell the card":

http://www.rme-audio.com/

					  I tried the link to Ico's page
>but I couldn't seem to find them.  Not to mention my browser was choking
>on all of the advanced features used therein...  

AFAIK, CardBus makes connected devices simply appear as regular PCI
devices.

Thus, the H-DSP driver that just entered ALSA CVS should work for the
CardBus interface as well as the PCI interface. If it doesn't, I want
to know about it, because its an illusion I've been operating under
for a while :)

--p


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
