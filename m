From: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Fri, 20 Jan 2006 20:04:15 +0100
Message-ID: <20060120190415.GM19398__10399.67562906$1137783990$gmane$org@stusta.de>
References: <20060119174600.GT19398@stusta.de> <20060120115443.GA16582@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id DD4E1176
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 20:04:16 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060120115443.GA16582@palantir8>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 20, 2006 at 11:54:43AM +0000, Martin Habets wrote:

> It seems to me we can already get rid of sound/oss/dmasound now.
> I cannot find anything refering to it anymore, and the ALSA powermac
> driver is being maintained.

You are correct that I forgot to add the dmasound drivers to my list, 
but I don't think we can get rid of all of them since I doubt the ALSA 
powermac driver was able to drive m68k hardware.

Can someone from the ppc developers drop me a small note whether 
SND_POWERMAC completely replaces DMASOUND_PMAC?

> Martin

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
