From: Peter Vollmer <remllov_@gmx.de>
Subject: Re: ice1712 - consumer mode capture
Date: Mon, 16 Jun 2003 19:05:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030616185939.00abcf68@pop.gmx.net>
References: <5.1.0.14.2.20030616152626.09e0abc0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306161713520.11284-100000@pnote.perex-int.c
 z>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

At 17:24 16.6.2003 +0200, Jaroslav Kysela wrote:

>You're more lucky. The hoontech hardware with the ice1712 chip does not
>work at all for consumer playback and capture (while DS playback works) in
>my test machine.
>
> > I noticed this problems first on a non PC platform (xscale ixp425) 
> which is
> > not fully PCI compliant and lacks some PCI-DMA transfer modes. So I first
> > assumed some PCI problems.
> > But checking back on PC/alsa 0.9.3 I found this similar behaviour. Now I
> > would think that the initialisation for consumer record is broken somehow.
> > Any suggestions/ideas ?
>
>I am sorry but none. It is really possible that initialization is broken,
>but it is difficult to find right one when my hardware configuration does
>not work at all with the current ALSA code.
>
>                                                 Jaroslav


Ok, then I'll try to play some more with the initialisation and I'll come 
back with the results if I get something

Thanks
Peter




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
