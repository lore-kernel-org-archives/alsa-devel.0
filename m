From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] fixes Re: problem compiling alsa-lib CVS.
Date: Thu, 01 Apr 2004 12:57:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <406C03AF.30405@superbug.demon.co.uk>
References: <405F1A01.8080408@superbug.demon.co.uk> <405F1C2A.1070000@superbug.demon.co.uk> <406B258B.4080106@superbug.demon.co.uk> <Pine.LNX.4.58.0404011041480.1843@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA17760
	for <alsa-devel@alsa-project.org>; Thu, 1 Apr 2004 13:56:00 +0200
In-Reply-To: <Pine.LNX.4.58.0404011041480.1843@pnote.perex-int.cz>
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
> On Wed, 31 Mar 2004, James Courtier-Dutton wrote:
> 
> 
>>Is there any reason why this patch was not added to the alsa-lib cvs ?
> 
> 
> It's better to put this information to configure.in?

No, because it selects which version of aclocal etc. that are used, 
which is before configure.in is even looked at.

> 
> 						Jaroslav



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
