From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: OSS API redirector
Date: Thu, 18 Mar 2004 14:12:46 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4059AE5E.7030703@superbug.demon.co.uk>
References: <Pine.LNX.4.58.0403181015270.1835@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA18355
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2004 15:10:23 +0100
In-Reply-To: <Pine.LNX.4.58.0403181015270.1835@pnote.perex-int.cz>
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
> Hi all,
> 
> 	I would like to point all developers to the OSS API redirector 
> which is in our alsa-oss package. It's universal piece of code which can 
> redirect all OSS API calls (actually mixer & PCM API only) to any shared 
> library.
> 
> Pros:
> - no more LD_PRELOAD hacks
> - any library can be used directly as endpoint
> - when used more applications will work (also some which does not work
>   with LD_PRELOAD hack)
> 
> Drawbacks:
> - still no fopen/fclose/fwrite/fread solution
> - applications must be a little bit modified
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 

What is the conclusion regarding fopen/fclose/fwrite/fread.
Can it be done?

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
