From: David Lloyd <dmlloyd@tds.net>
Subject: Re: OSS API redirector
Date: Thu, 18 Mar 2004 21:37:57 +0000 (UTC)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.3503191408270.16085@tomservo.workpc.tds.net>
References: <Pine.LNX.4.58.0403181015270.1835@pnote.perex-int.cz>
 <4059AE5E.7030703@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta01.mail.tds.net (mta01.mail.tds.net [216.170.230.81])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA27164
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2004 22:10:48 +0100
In-Reply-To: <4059AE5E.7030703@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Date: Mon, 19 Mar 2035 15:10:35 -0600 (CST)
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Mar 2004, James Courtier-Dutton wrote:

> What is the conclusion regarding fopen/fclose/fwrite/fread. Can it be
> done?

I thought that one rather pie-in-the-sky idea might be to use a kernel
module that made /dev/dsp, /dev/mixer, etc., and reflects back to a
userspace ALSA sound server via another device.  This way, it doesn't
matter how the device is opened.

Might be difficult to do though, especially when you get mmap and 
dma involved.

Just a thought, anyway.

- D


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
