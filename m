From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] fixes Re: problem compiling alsa-lib CVS.
Date: Wed, 31 Mar 2004 21:09:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <406B258B.4080106@superbug.demon.co.uk>
References: <405F1A01.8080408@superbug.demon.co.uk> <405F1C2A.1070000@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA30450
	for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2004 22:08:30 +0200
In-Reply-To: <405F1C2A.1070000@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Is there any reason why this patch was not added to the alsa-lib cvs ?


James Courtier-Dutton wrote:
> James Courtier-Dutton wrote:
> 
>> I attach the output I see on the screen when running ./cvscompile.
>>
>> Cheers
>> James
>>
> 
> I attach a patch to fix the problem for me.
> 
> 
> ------------------------------------------------------------------------
> 
> --- cvscompile	2002-10-24 13:09:30.000000000 +0100
> +++ cvscompile.new	2004-03-22 16:58:07.072241360 +0000
> @@ -1,4 +1,9 @@
>  #!/bin/bash
> +# Minimum value required to build
> +WANT_AUTOMAKE_1_6=1 export WANT_AUTOMAKE_1_6
> +AUTOMAKE_MIN=1.6.0
> +AUTOCONF_MIN=2.53
> +LIBTOOL_MIN=1.4.0
>  
>  touch ltconfig
>  libtoolize --force --copy --automake



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
