From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: OSS API redirector
Date: Sun, 21 Mar 2004 22:53:10 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405E1CD6.4030404@superbug.demon.co.uk>
References: <Pine.LNX.4.58.0403181015270.1835@pnote.perex-int.cz> <4059AE5E.7030703@superbug.demon.co.uk> <Pine.LNX.4.58.3503191408270.16085@tomservo.workpc.tds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net [194.217.242.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA20043
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2004 00:31:15 +0100
In-Reply-To: <Pine.LNX.4.58.3503191408270.16085@tomservo.workpc.tds.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Lloyd <dmlloyd@tds.net>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Lloyd wrote:
> On Thu, 18 Mar 2004, James Courtier-Dutton wrote:
> 
> 
>>What is the conclusion regarding fopen/fclose/fwrite/fread. Can it be
>>done?
> 
> 
> I thought that one rather pie-in-the-sky idea might be to use a kernel
> module that made /dev/dsp, /dev/mixer, etc., and reflects back to a
> userspace ALSA sound server via another device.  This way, it doesn't
> matter how the device is opened.
> 
> Might be difficult to do though, especially when you get mmap and 
> dma involved.
> 
> Just a thought, anyway.
> 
> - D
> 
> 
I thought of that, but with that you just get different problems.
E.g. dmix only works is all application wishing to play sound are run by 
the same user. You would probably need some daemon to run the /dev/dsp, 
and that user deamon would have to run under the same user as any native 
alsa app.

Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
