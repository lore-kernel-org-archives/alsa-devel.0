From: Steffen Sauder <steffensauder@gmx.de>
Subject: Re: OSS emulation delays (?)
Date: Wed, 29 Oct 2003 19:33:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FA0080B.4080607@gmx.de>
References: <20031023124542.0868bfd8.rpav@mephle.com>	<3F992DF7.9090002@gmx.de> <s5h8yn543ly.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yn543ly.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>ok, finally i can reproduce this bug, too.
>this happens when the plug layer is used, e.g. sample-rate or format
>conversion is needed.  that's why this doesn't appear on most
>machines.
>
>the attached patch should fix the problem.
>
It did so indeed, thanks a lot.

>
>(but of course, it has nothing to do with the oss-emulation
> problem...  please let me know if you find the exact alsa version
> getting broken.) 
>  
>
0.9.3a works fine, but all versions 0.9.3b and later all seem to have 
that problem.

gruss,
Steffen




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
