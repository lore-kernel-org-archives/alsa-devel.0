From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bt87x Audio Capture
Date: Thu, 09 Mar 2006 08:49:30 +0100
Message-ID: <20060309074930.GA993@turing.informatik.uni-halle.de>
References: <440F4F06.4030904@kmit.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <440F4F06.4030904@kmit.sk>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ondrej Ivani?? <ondrej@kmit.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ondrej Ivani?? wrote:
> After `modprobe snd_bt87x', I have got nothing in logs.
> 
> Last relevant info is from bt878 module:
> 
> bt878: AUDIO driver version 0.0.0 loaded

This is the wrong module.  "bt878" is the old OSS driver, but you want
to use the "snd-bt87x" driver.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
