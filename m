From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: RFC: OSS driver removal, a slightly different
	approach
Date: Sat, 21 Jan 2006 10:15:31 +1100
Message-ID: <1137798931.12998.56.camel@localhost.localdomain>
References: <20060119174600.GT19398@stusta.de>
	 <20060120115443.GA16582@palantir8>  <20060120190415.GM19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 655EE185
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 00:15:42 +0100 (MET)
In-Reply-To: <20060120190415.GM19398@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-01-20 at 20:04 +0100, Adrian Bunk wrote:
> On Fri, Jan 20, 2006 at 11:54:43AM +0000, Martin Habets wrote:
> 
> > It seems to me we can already get rid of sound/oss/dmasound now.
> > I cannot find anything refering to it anymore, and the ALSA powermac
> > driver is being maintained.
> 
> You are correct that I forgot to add the dmasound drivers to my list, 
> but I don't think we can get rid of all of them since I doubt the ALSA 
> powermac driver was able to drive m68k hardware.
> 
> Can someone from the ppc developers drop me a small note whether 
> SND_POWERMAC completely replaces DMASOUND_PMAC?

It should...

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
