From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: RFC: OSS driver removal, a slightly different
	approach
Date: Sat, 21 Jan 2006 10:16:40 +1100
Message-ID: <1137799001.12998.59.camel@localhost.localdomain>
References: <20060119174600.GT19398@stusta.de>
	 <20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
	 <20060120212917.GA14405@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CDF58185
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 00:16:53 +0100 (MET)
In-Reply-To: <20060120212917.GA14405@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Olaf Hering <olh@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, Ben Collins <ben.collins@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-01-20 at 22:29 +0100, Olaf Hering wrote:
>  On Fri, Jan 20, Adrian Bunk wrote:
> 
>  
> > Can someone from the ppc developers drop me a small note whether 
> > SND_POWERMAC completely replaces DMASOUND_PMAC?
> 
> It doesnt. Some tumbler models work only after one plug/unplug cycle of
> the headphone. early powerbooks report/handle the mute settings
> incorrectly. there are likely more bugs.

Interesting... Ben Collins hacked something to have Toonie work as a
"default" driver for non supported machine and saw that problem too, I
think he fixes it, I'll check with him what's up there and if his fix
applied to tumbler.c as well.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
