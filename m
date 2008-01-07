From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: fujitsu siemens amilo la 1703 vt1807 hda
	intel	card problem
Date: Mon, 07 Jan 2008 13:29:50 -0800
Message-ID: <1199741390.4061.162.camel@razman.gruemaster.com>
References: <f5976be10801041748j5271c4eas8a6b2d2851b4a838@mail.gmail.com>
	<1199501784.3732.527.camel@razman.gruemaster.com>
	<f5976be10801050853k10092aedlced1a1edef5db25c@mail.gmail.com>
	<f5976be10801071259j6ace136bieda124de94b0afb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id E71DF24999
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 22:29:53 +0100 (CET)
In-Reply-To: <f5976be10801071259j6ace136bieda124de94b0afb4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Norayr Chilingaryan <gnorayr@gmail.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The information you provided is good, we're just a bit behind.  I'm
trying to get some programming specs for this codec now.

In the mean time, could you try using a tip build of the alsa driver?
You can download it here:
ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/

This may have some newer code that will enable your audio.  Also, try
the drivers on http://viaarena.com.  THey may have an updated version
that hasn't hit the main tree yet.

Tobin

On Mon, 2008-01-07 at 21:59 +0100, Norayr Chilingaryan wrote:

> Excuse me for bothering you.
> May be I need to provide other info?
> Did you receive the link?
> Di you have any ideas?
> 
> Thank you
> 
> Norayr
> 
> 
> On Jan 5, 2008 5:53 PM, Norayr Chilingaryan < gnorayr@gmail.com>
> wrote:
> 
>         http://pastebin.ca/842745
>         
>         Thank you very much!
>         
>         
>         
>         
>         
>         On Jan 5, 2008 3:56 AM, Tobin Davis <tdavis@dsl-only.net>
>         wrote:
>         
>                 Could you download and run
>                 http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh
>                 
>                 This script will provide a lot of useful information.
>                 After running it, please reply to this email with the
>                 link that the script generates, so we can retrieve the
>                 data, thanks.
>                 
>                 Tobin
>                 
>                 
>                 
>                 
>                 On Sat, 2008-01-05 at 02:48 +0100, Norayr Chilingaryan
>                 wrote:
>                 > 
>                 > Hello I decided to write here, firtly, because my
>                 > messages in aksa-user have been ingored, and
>                 > secondly, because I understood that my card most
>                 > probably just unsupported and I must contact
>                 > developers. I have tried to pass options
>                 > model=fujitsu, because I have a fujitsu siements
>                 > notebook etc I have also tried to pass amny other
>                 > options in /etc/modules.d/alsa but withnot effect I
>                 > use gentoo, and the only thing I noticed with latest
>                 > kernels and alsa drivers 1.0.15 is that I can hear
>                 > sound through  the headphones, but with low volume.
>                 > It is not possible to get volume higher or speaker
>                 > to make sounds now. So, please, this is information
>                 > about the card 04:01.0 Audio device: VIA
>                 > Technologies, Inc. VIA High Definition Audio
>                 > Controller (rev 10) kakraphoon ~ #
>                 > cat /proc/asound/card0/codec#* | grep Codec Codec:
>                 > VIA VIA VT1708 Codec: Motorola Si3054 Thank you very
>                 > much Norayr 
>                 > 
>                 > _______________________________________________
>                 > Alsa-devel mailing list
>                 > Alsa-devel@alsa-project.org
>                 > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>                 
>                 -- Tobin Davis 
>                 
>                 
>                 Hain't we got all the fools in town on our side?  And hain't that a big
>                 enough majority in any town?
>                 		-- Mark Twain, "Huckleberry Finn"
>         
>         
>         
> 
> 

-- 
Tobin Davis  


Anything anybody can say about America is true.
		-- Emmett Grogan
